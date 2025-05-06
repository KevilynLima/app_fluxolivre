import 'package:flutter/material.dart';

class InputLoginWidget extends StatelessWidget {
  final IconData icon;
  final String hint;
  final bool obscure;
  final TextInputType type;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  
  const InputLoginWidget({
    required this.icon,
    required this.hint,
    required this.controller,
    this.obscure = false,
    this.type = TextInputType.text,
    this.validator,
    super.key,
    });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(icon, color: Color(0xFFFFFFFF)),
        hintText: hint,
        hintStyle: TextStyle(color: Color(0xFFFFFFFF)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.pinkAccent),
        ),
      ),
      style: TextStyle(color: Color(0xFFFFFFFF)),
      obscureText: obscure,
      keyboardType: type,
      validator: validator,
    );
  }
}
