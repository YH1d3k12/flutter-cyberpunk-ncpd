import 'package:flutter/material.dart';

class WantedPortrait extends StatelessWidget {
  const WantedPortrait({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.cyanAccent, width: 2),
        boxShadow: [
          BoxShadow(color: Colors.cyanAccent.withOpacity(0.4), blurRadius: 15),
        ],
      ),
      child: Image.asset(
        'djalma.jpg',
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}
