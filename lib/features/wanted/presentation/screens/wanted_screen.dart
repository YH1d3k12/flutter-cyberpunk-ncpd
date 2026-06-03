import 'package:flutter/material.dart';
import '../../../../shared/widgets/header.dart';
import '../../../../shared/widgets/footer.dart';
import '../widgets/wanted_header.dart';
import '../widgets/wanted_portrait.dart';
import '../widgets/wanted_info.dart';
import '../widgets/wanted_level.dart';
import '../widgets/wanted_reward.dart';
import '../widgets/wanted_alert.dart';

class WantedScreen extends StatelessWidget {
  const WantedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0d0d0f),
      body: Column(
        children: [
          const AppHeader(
            currentPage: "WANTED DATABASE"
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 420,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xff15151a),
                  border: Border.all(color: Colors.yellowAccent, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.yellowAccent.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    /// WANTED TITLE
                    WantedHeader(),
                    /// IMAGE
                    WantedPortrait(),
                    /// INFO
                    WantedInfo(),
                    /// THREAT LEVEL
                    WantedLevel(),
                    /// REWARD
                    WantedReward(),
                    /// ALERT
                    WantedAlert(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: const Footer(),
    );
  }
}
