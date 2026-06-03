import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {
  final double screenWidth;

  const LoginTitle({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Text(
      "NCPD LOGIN",
      style: TextStyle(
        color: Colors.cyanAccent,
        fontSize: screenWidth * 0.05 > 32 ? 32 : screenWidth * 0.05,
        fontWeight: FontWeight.bold,
        letterSpacing: 4,
      ),
    );
  }
}