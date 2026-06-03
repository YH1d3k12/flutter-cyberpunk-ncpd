import 'package:flutter/material.dart';

class WantedHeader extends StatelessWidget {
  const WantedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "WANTED",
          style: TextStyle(
            color: Color(0xffffd400),
            fontSize: 44,
            fontWeight: FontWeight.bold,
            letterSpacing: 6,
            shadows: [Shadow(color: Colors.orange, blurRadius: 15)],
          ),
        ),

        Text(
          "DEAD OR ALIVE",
          style: TextStyle(
            color: Colors.white70,
            letterSpacing: 5,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
