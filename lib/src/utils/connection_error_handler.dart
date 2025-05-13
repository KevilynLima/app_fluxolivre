import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';

class ConnectionErrorHandler {

  static void showConnectionErrorDialog(BuildContext context, Function onRetry) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Erro de Conexão'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.signal_wifi_off,
              color: Colors.red,
              size: 50,
            ),
            SizedBox(height: 15),
            Text(
              'Não foi possível conectar ao servidor. Verifique sua conexão com a internet e tente novamente.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onRetry();
            },
            child: const Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }

  /// Trata exceções de conexão específicas e retorna uma mensagem apropriada
  static String getConnectionErrorMessage(Object error) {
    if (error is SocketException) {
      return 'Não foi possível conectar ao servidor. Verifique sua conexão com a internet.';
    } else if (error is TimeoutException) {
      return 'A conexão com o servidor expirou. Tente novamente mais tarde.';
    } else if (error is HttpException) {
      return 'Ocorreu um erro no servidor. Tente novamente mais tarde.';
    } else if (error is FormatException) {
      return 'Dados inválidos recebidos do servidor.';
    } else {
      return 'Erro ao conectar ao servidor: ${error.toString()}';
    }
  }

  /// Exibe uma mensagem de erro em um SnackBar
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}