import 'package:flutter/material.dart';
import 'package:app_fluxolivrep/src/widget/input_login_widget.dart';
import 'package:app_fluxolivrep/src/widget/button_widget.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      // Implementar a lógica de cadastro aqui
      Navigator.of(context).pushNamed('/home');
    }
  }

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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                    width: 150,
                    child: Image(image: AssetImage('assets/images/et.png')),
                  ),
                  const SizedBox(height: 30),
                  InputLoginWidget(
                    icon: Icons.person_outline,
                    hint: 'Nome',
                    obscure: false,
                    controller: _nameController,
                    validator: Validatorless.required('Nome é obrigatório'),
                  ),
                  InputLoginWidget(
                    icon: Icons.email_outlined,
                    hint: 'E-mail',
                    obscure: false,
                    controller: _emailController,
                    validator: Validatorless.multiple([
                      Validatorless.required('E-mail é obrigatório'),
                      Validatorless.email('E-mail inválido')
                    ]),
                  ),
                  InputLoginWidget(
                    icon: Icons.document_scanner_outlined,
                    hint: 'CPF',
                    obscure: false,
                    controller: _cpfController,
                    validator: Validatorless.required('CPF é obrigatório'),
                  ),
                  InputLoginWidget(
                    icon: Icons.lock_outlined,
                    hint: 'Senha',
                    obscure: true,
                    controller: _passwordController,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha é obrigatória'),
                      Validatorless.min(6, 'Senha deve ter pelo menos 6 caracteres'),
                    ]),
                  ),
                  InputLoginWidget(
                    icon: Icons.lock_outlined,
                    hint: 'Confirmar Senha',
                    obscure: true,
                    controller: _confirmPasswordController,
                    validator: Validatorless.multiple([
                      Validatorless.required('Confirme sua senha'),
                      Validatorless.compare(_passwordController, 'As senhas não conferem'),
                    ]),
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
                        onPressed: _cadastrar,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
