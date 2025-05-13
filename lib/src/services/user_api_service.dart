import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:app_fluxolivrep/src/models/user.dart';
import 'package:app_fluxolivrep/src/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserApiService {
  static const String baseUrl = Constants.baseUrl;
  // Define um timeout de 10 segundos para todas as requisições
  static const Duration timeoutDuration = Duration(seconds: 10);
  
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<http.Response> registerUser(User user) async {
    try {
      final url = Uri.parse('$baseUrl/user');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(user.toJson())
      ).timeout(timeoutDuration);
      
      return response;
    } on SocketException {
      throw 'Não foi possível conectar ao servidor. Verifique sua conexão com a internet.';
    } on TimeoutException {
      throw 'A conexão com o servidor expirou. Tente novamente mais tarde.';
    } on HttpException {
      throw 'Ocorreu um erro no servidor. Tente novamente mais tarde.';
    } on FormatException {
      throw 'Dados inválidos recebidos do servidor.';
    } catch (e) {
      throw 'Erro ao conectar ao servidor: ${e.toString()}';
    }
  }
  
  static Future<List<User>> getUsers() async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw 'Usuário não autenticado. Faça login novamente.';
      }
      
      final url = Uri.parse('$baseUrl/users');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);
      
      if (response.statusCode == 200) {
        final List<dynamic> usersList = jsonDecode(response.body);
        return usersList.map((json) => User.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw 'Sessão expirada. Faça login novamente.';
      } else {
        throw 'Erro ao buscar usuários. Código: ${response.statusCode}';
      }
    } on SocketException {
      throw 'Não foi possível conectar ao servidor. Verifique sua conexão com a internet.';
    } on TimeoutException {
      throw 'A conexão com o servidor expirou. Tente novamente mais tarde.';
    } on FormatException {
      throw 'Dados inválidos recebidos do servidor.';
    } catch (e) {
      throw e.toString();
    }
  }
  
  static Future<User> getUserById(int id) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw 'Usuário não autenticado. Faça login novamente.';
      }
      
      final url = Uri.parse('$baseUrl/users/$id');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);
      
      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        throw 'Sessão expirada. Faça login novamente.';
      } else if (response.statusCode == 404) {
        throw 'Usuário não encontrado.';
      } else {
        throw 'Erro ao buscar dados do usuário. Código: ${response.statusCode}';
      }
    } on SocketException {
      throw 'Não foi possível conectar ao servidor. Verifique sua conexão com a internet.';
    } on TimeoutException {
      throw 'A conexão com o servidor expirou. Tente novamente mais tarde.';
    } on FormatException {
      throw 'Dados inválidos recebidos do servidor.';
    } catch (e) {
      throw e.toString();
    }
  }
  
  static Future<http.Response> updateUser(User user) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw 'Usuário não autenticado. Faça login novamente.';
      }
      
      final url = Uri.parse('$baseUrl/users/${user.id}');
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(user.toJson())
      ).timeout(timeoutDuration);
      
      return response;
    } on SocketException {
      throw 'Não foi possível conectar ao servidor. Verifique sua conexão com a internet.';
    } on TimeoutException {
      throw 'A conexão com o servidor expirou. Tente novamente mais tarde.';
    } on HttpException {
      throw 'Ocorreu um erro no servidor. Tente novamente mais tarde.';
    } on FormatException {
      throw 'Dados inválidos recebidos do servidor.';
    } catch (e) {
      throw 'Erro ao conectar ao servidor: ${e.toString()}';
    }
  }
  
  static Future<http.Response> deleteUser(int id) async {
    try {
      final token = await _getToken();
      if (token == null) {
        throw 'Usuário não autenticado. Faça login novamente.';
      }
      
      final url = Uri.parse('$baseUrl/users/$id');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(timeoutDuration);
      
      return response;
    } on SocketException {
      throw 'Não foi possível conectar ao servidor. Verifique sua conexão com a internet.';
    } on TimeoutException {
      throw 'A conexão com o servidor expirou. Tente novamente mais tarde.';
    } on HttpException {
      throw 'Ocorreu um erro no servidor. Tente novamente mais tarde.';
    } on FormatException {
      throw 'Dados inválidos recebidos do servidor.';
    } catch (e) {
      throw 'Erro ao conectar ao servidor: ${e.toString()}';
    }
  }
}