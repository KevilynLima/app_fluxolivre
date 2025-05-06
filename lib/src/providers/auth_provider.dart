import 'package:app_fluxolivrep/src/services/auth_api_service.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier{
    String? _token;
    int? _perfil;

    bool get isAuthenticade => _token != null;

    String? get token => _token;
    int? get perfil => _perfil;

    Future<String?> login(String email, String password) async{
      try {
        final response = await AuthApiService.login(email, password);
        if (response['token'] != null){
          _token = response['token'];
          _perfil = response['perfil'];
          notifyListeners();
          return null;
          
        }else{
          return response['message'];
        }
        
      } catch (error) {
        return 'Erro ao conectar com o Servidor';
      }

    }

    Future<void> logout() async{
      await AuthApiService.logout();
      _token = null;
      _perfil = null;
      notifyListeners();
    }

    Future<void> loadToken() async{
      _token = await AuthApiService.getToken();
      notifyListeners();
    }

}