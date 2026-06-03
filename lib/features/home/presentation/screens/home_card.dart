import 'package:flutter/material.dart';

class HomeCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String route;

  const HomeCard({
    super.key,
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double iconSize = (screenWidth * 0.05).clamp(40, 80);
    double containerWidth = (screenWidth * 0.15).clamp(120, 200);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, widget.route);
        },
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 200),
          tween: Tween<double>(begin: 1, end: isHovered ? 1.05 : 1),
          builder: (context, scale, child) {
            return Transform.scale(scale: scale, child: child);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: containerWidth,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xff1a1a1f),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.cyanAccent.withOpacity(isHovered ? 1 : 0.5),
                width: isHovered ? 2 : 1,
              ),
              boxShadow: isHovered
                  ? [
                      BoxShadow(
                        color: Colors.cyanAccent.withOpacity(0.6),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    widget.icon,
                    color: Colors.cyanAccent,
                    size: isHovered ? iconSize * 1.1 : iconSize,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: isHovered ? 1.5 : 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
