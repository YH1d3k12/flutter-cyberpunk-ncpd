import 'package:flutter/material.dart';

class WantedAlert extends StatelessWidget {
  const WantedAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        /// WARNING
        Text(
          "ARMED & EXTREMELY DANGEROUS",
          style: TextStyle(
            color: Colors.redAccent,
            fontSize: 16,
            letterSpacing: 2,
          ),
        ),

        Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 48),
      ],
    );
  }
}
