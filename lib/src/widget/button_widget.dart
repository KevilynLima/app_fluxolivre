import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;

  const ButtonWidget({
    required this.text,
    required this.onPressed,
    this.width = 150,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFAFAE24),
        minimumSize: Size(width, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14)
        )
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xff031c5f)
        ),
      )
    );
  }
}
