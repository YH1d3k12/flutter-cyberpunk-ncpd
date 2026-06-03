import 'package:flutter/material.dart';

class LoginSubtitle extends StatelessWidget {
  
  const LoginSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "NCPD Cyberpunk Interface",
      style: TextStyle(
        color: Colors.white70.withOpacity(0.7),
        fontSize: 12,
        letterSpacing: 1,
      ),
    );
  }
}
