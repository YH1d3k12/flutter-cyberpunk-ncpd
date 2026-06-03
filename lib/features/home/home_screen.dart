import 'package:flutter/material.dart';
import '../../shared/widgets/header.dart';
import '../../shared/widgets/footer.dart';
import 'presentation/screens/home_card.dart';

class HomeScreen extends StatelessWidget {
  final String? userName;

  const HomeScreen({super.key, this.userName});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = 2;
    if (screenWidth > 1200) {
      crossAxisCount = 4;
    } else if (screenWidth > 800) {
      crossAxisCount = 3;
    }

    return Scaffold(
      backgroundColor: const Color(0xff0d0d0f),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppHeader(currentPage: "HOME"),
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Bem-vindo, ",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  userName ?? "Oficial",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
                children: [
                  HomeCard(icon: Icons.folder, title: "Casos Recentes", route: "/"),
                  HomeCard(icon: Icons.person_search, title: "Suspeitos", route: "/wanted"),
                  HomeCard(icon: Icons.report, title: "Relatórios", route: "/"),
                  HomeCard(icon: Icons.settings, title: "Configurações", route: "/"),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
