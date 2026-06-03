import 'package:flutter/material.dart';

class WantedReward extends StatelessWidget {
  const WantedReward({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.yellowAccent, width: 2),
        color: Colors.black,
      ),
      child: const Text(
        "REWARD 500,000 €\$",
        style: TextStyle(
          fontSize: 28,
          color: Colors.yellowAccent,
          fontWeight: FontWeight.bold,
          shadows: [Shadow(color: Colors.orange, blurRadius: 10)],
        ),
      ),
    );
  }
}
