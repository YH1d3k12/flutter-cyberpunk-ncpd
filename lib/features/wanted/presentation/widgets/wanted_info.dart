import 'package:flutter/material.dart';

class WantedInfo extends StatelessWidget {
  const WantedInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        /// NAME
        Text(
          "DJALMA HIDEKI YAMAMOTO",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 3),
        ),

        // TITLE
        Text(
          "MILITECH SPECIAL FORCES",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 14,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
