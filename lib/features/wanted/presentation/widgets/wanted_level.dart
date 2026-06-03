import 'package:flutter/material.dart';

class WantedLevel extends StatelessWidget {
  const WantedLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "THREAT LEVEL:",
          style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Text(
          "HIGH",
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
