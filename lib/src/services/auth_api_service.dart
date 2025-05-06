import 'dart:convert';
import 'package:app_fluxolivrep/src/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AuthApiService {
   static const String baseUrl = Constants.baseUrl;
   static Future<Map<String?, dynamic>> login(String email, String password) async {
      final url = Uri.parse('$baseUrl/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password":password}),
        );
      final data = jsonDecode(response.body);
      if(response.statusCode == 200 && data.containsKey('token')){
         await _saveToken(data['token']);
         return {
            'token': data['token'],
            'perfil': data['perfil']
         };
      }else{
         return {'message': data['message'] ?? 'Erro ao realizar on login' };
      }
   }

   static Future<void> _saveToken(token) async{
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
   }

   static Future<String?> getToken() async{
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('auth_token');
   }

   static Future<void> logout() async{
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
   }

}