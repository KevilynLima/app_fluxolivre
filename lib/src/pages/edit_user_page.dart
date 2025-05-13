import 'package:app_fluxolivrep/src/models/user.dart';
import 'package:app_fluxolivrep/src/services/user_api_service.dart';
import 'package:app_fluxolivrep/src/widget/input_login_widget.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  late User _user;
  bool _isNewPassword = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as User;
    _user = args;
    _nameController.text = _user.name;
    _emailController.text = _user.email;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });

        // Criando um novo usuário com os dados atualizados
        User updatedUser = User(
          id: _user.id,
          name: _nameController.text,
          email: _emailController.text,
          password: _isNewPassword ? _passwordController.text : _user.password,
        );

        final response = await UserApiService.updateUser(updatedUser);
        
        if (response.statusCode == 200) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Usuário atualizado com sucesso!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop();
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Erro ao atualizar usuário: ${response.statusCode}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Editar Usuário',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputLoginWidget(
                        controller: _nameController,
                        icon: Icons.person_outline,
                        hint: 'Nome',
                        validator: Validatorless.required('Nome é obrigatório'),
                      ),
                      const SizedBox(height: 16),
                      InputLoginWidget(
                        controller: _emailController,
                        icon: Icons.email_outlined,
                        hint: 'E-mail',
                        validator: Validatorless.multiple([
                          Validatorless.required('E-mail é obrigatório'),
                          Validatorless.email('E-mail inválido'),
                        ]),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(
                            value: _isNewPassword,
                            onChanged: (value) {
                              setState(() {
                                _isNewPassword = value ?? false;
                              });
                            },
                          ),
                          const Text(
                            'Alterar senha',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (_isNewPassword) ...[
                        const SizedBox(height: 16),
                        InputLoginWidget(
                          controller: _passwordController,
                          icon: Icons.lock_outlined,
                          hint: 'Nova senha',
                          obscure: true,
                          validator: Validatorless.multiple([
                            Validatorless.required('Nova senha é obrigatória'),
                            Validatorless.min(6, 'Senha deve ter pelo menos 6 caracteres'),
                          ]),
                        ),
                        const SizedBox(height: 16),
                        InputLoginWidget(
                          controller: _confirmPasswordController,
                          icon: Icons.lock_outlined,
                          hint: 'Confirmar nova senha',
                          obscure: true,
                          validator: Validatorless.multiple([
                            Validatorless.required('Confirme sua senha'),
                            Validatorless.compare(
                              _passwordController,
                              'As senhas não conferem',
                            ),
                          ]),
                        ),
                      ],
                      const SizedBox(height: 32),
                      Center(
                        child: ElevatedButton(
                          onPressed: _salvar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            'Salvar',
                            style: TextStyle(fontSize: 18),
                          ),
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