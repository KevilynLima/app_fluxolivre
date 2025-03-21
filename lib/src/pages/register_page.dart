import 'package:flutter/material.dart';
import 'package:app_fluxolivre/src/widget/input_login_widget.dart';
import 'package:app_fluxolivre/src/widget/button_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/img_fundologin.png'),
            fit: BoxFit.cover,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(image: AssetImage('assets/images/et.png')),
                ),
                const SizedBox(height: 30),
                const InputLoginWidget(
                  icon: Icons.person_outline,
                  hint: 'Nome',
                  obscure: false,
                ),
                const InputLoginWidget(
                  icon: Icons.email_outlined,
                  hint: 'E-mail',
                  obscure: false,
                ),
                const InputLoginWidget(
                  icon: Icons.document_scanner_outlined,
                  hint: 'CPF',
                  obscure: false,
                ),
                const InputLoginWidget(
                  icon: Icons.lock_outlined,
                  hint: 'Senha',
                  obscure: true,
                ),
                const InputLoginWidget(
                  icon: Icons.lock_outlined,
                  hint: 'Confirmar Senha',
                  obscure: true,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ButtonWidget(
                      text: 'Cancelar',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    ButtonWidget(
                      text: 'Cadastrar',
                      onPressed: () => Navigator.of(context).pushNamed('/home'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
