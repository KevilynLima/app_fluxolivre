import 'dart:convert';

import 'package:app_fluxolivrep/src/models/user.dart';
import 'package:app_fluxolivrep/src/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserApiService {
  static const String baseUrl = Constants.baseUrl;
  
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<http.Response> registerUser(User user) async {
    final url = Uri.parse('$baseUrl/user');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson())
    );
    return response;
  }
  
  static Future<List<User>> getUsers() async {
    final token = await _getToken();
    final url = Uri.parse('$baseUrl/users');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    
    if (response.statusCode == 200) {
      final List<dynamic> usersList = jsonDecode(response.body);
      return usersList.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao buscar usuários: ${response.statusCode}');
    }
  }
  
  static Future<User> getUserById(int id) async {
    final token = await _getToken();
    final url = Uri.parse('$baseUrl/users/$id');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao buscar usuário: ${response.statusCode}');
    }
  }
  
  static Future<http.Response> updateUser(User user) async {
    final token = await _getToken();
    final url = Uri.parse('$baseUrl/users/${user.id}');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(user.toJson())
    );
    return response;
  }
  
  static Future<http.Response> deleteUser(int id) async {
    final token = await _getToken();
    final url = Uri.parse('$baseUrl/users/$id');
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return response;
  }
}