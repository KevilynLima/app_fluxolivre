import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:app_fluxolivrep/src/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthApiService {
   static const String baseUrl = Constants.baseUrl;
   static const Duration timeoutDuration = Duration(seconds: 10);
   
   static Future<Map<String?, dynamic>> login(String email, String password) async {
      try {
         final url = Uri.parse('$baseUrl/login');
         final response = await http.post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({"email": email, "password": password}),
         ).timeout(timeoutDuration);
         
         final data = jsonDecode(response.body);
         
         if (response.statusCode == 200 && data.containsKey('token')) {
            await _saveToken(data['token']);
            return {
               'token': data['token'],
               'perfil': data['perfil']
            };
         } else {
            return {
               'message': data['message'] ?? 'Credenciais inválidas. Verifique seu email e senha.'
            };
         }
      } on SocketException {
         return {'message': 'Não foi possível conectar ao servidor. Verifique sua conexão com a internet.'};
      } on TimeoutException {
         return {'message': 'A conexão com o servidor expirou. Tente novamente mais tarde.'};
      } on FormatException {
         return {'message': 'Dados inválidos recebidos do servidor.'};
      } catch (e) {
         return {'message': 'Erro ao conectar ao servidor: ${e.toString()}'};
      }
   }

   static Future<void> _saveToken(token) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
   }
   
   static Future<void> logout() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
   }
   
   static Future<String?> getToken() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('token');
   }
}