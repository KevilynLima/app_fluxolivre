import 'dart:convert';

import 'package:app_fluxolivrep/src/models/user.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  static const String baseUrl = 'http://34.224.167.171:4040';
  static Future<http.Response> registerUser(User user) async{
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
}