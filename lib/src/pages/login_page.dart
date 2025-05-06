import 'package:app_fluxolivrep/src/providers/auth_provider.dart';
import 'package:app_fluxolivrep/src/utils/show_erro_snackbar.dart';
import 'package:app_fluxolivrep/src/widget/input_login_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _acessar() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context , listen: false);
      String? erroMessage = await authProvider.login(
        _emailController.text, 
        _passwordController.text);

      if(mounted){
        if(erroMessage== null){
          Navigator.of(context).pushNamed('/hone');
        }else{
          showErroSnackBar(context, erroMessage);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/img_fundologin.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 200,
                  width: 200,
                  child: Image(image: AssetImage('assets/images/et.png')),
                ),
                const SizedBox(height: 30),
                InputLoginWidget(
                  icon: Icons.email_outlined,
                  hint: 'E-Mail',
                  controller: _emailController,
                  validator: Validatorless.required('Campo Obrigatório'),
                ),
                const SizedBox(height: 30),
                InputLoginWidget(
                  icon: Icons.lock_outlined,
                  hint: 'Password',
                  controller: _passwordController,
                  validator: Validatorless.required('Campo Obrigatório'),
                  obscure: true,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFAFAE24),
                    minimumSize: Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: _acessar,
                  child: const Text(
                    'Acessar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF031c5f),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/novousuario');
                  },
                  child: const Text(
                    'Novo Usuário',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
