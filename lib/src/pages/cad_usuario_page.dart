import 'package:app_fluxolivrep/src/models/user.dart';
import 'package:app_fluxolivrep/src/pages/home_page.dart';
import 'package:app_fluxolivrep/src/providers/user_register_provider.dart';
import 'package:app_fluxolivrep/src/widget/input_login_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class CadUsuarioPage extends StatefulWidget {
  const CadUsuarioPage({super.key});

  @override
  State<CadUsuarioPage> createState() => _CadUsuarioPageState();
}

class _CadUsuarioPageState extends State<CadUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confSenhaController = TextEditingController();

  void _cadastrar() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        name: _nomeController.text,
        email: _emailController.text,
        password: _senhaController.text,
      );
      try {
        await Provider.of<UserRegisterProvider>(
          context,
          listen: false,
        ).resterUser(user);
        print('Usuário Cadastrado');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } catch (error) {
        print(error.toString());
      }
    }
  }

  void _cancelar() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/img_fundologin.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              color: const Color(0xFF3C3E40),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                        alignment: Alignment.center,
                        child: const Text(
                          'Novo Usuário',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                      const Text(
                        "Preencha os Dados",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InputLoginWidget(
                        controller: _nomeController,
                        icon: Icons.person_outlined,
                        hint: 'Nome',
                        validator: Validatorless.required('Campo Obrigatorio'),
                      ),
                      const SizedBox(height: 10),
                      InputLoginWidget(
                        controller: _emailController,
                        icon: Icons.email_outlined,
                        hint: 'E-mail',
                        validator: Validatorless.multiple([
                          Validatorless.required('Campo Obrigatório'),
                          Validatorless.email('E-mail Invalido!'),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      InputLoginWidget(
                        controller: _senhaController,
                        icon: Icons.lock_outlined,
                        hint: 'Senha',
                        validator: Validatorless.multiple([
                          Validatorless.required('Campo Obrigatório'),
                          Validatorless.min(8, 'Digite no minimo 8 caracteres'),
                        ]),
                        obscure: true,
                      ),
                      const SizedBox(height: 10),
                      InputLoginWidget(
                        controller: _confSenhaController,
                        icon: Icons.lock_outlined,
                        hint: 'Confirma Senha',
                        validator: Validatorless.multiple([
                          Validatorless.required('Campo Obrigatório'),
                          Validatorless.compare(
                            _senhaController,
                            'As Senhas não são Iguais',
                          ),
                        ]),
                        obscure: true,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF90F74F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: _cadastrar,
                            child: const Text(
                              'Cadastrar',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFA271E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: _cancelar,
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
