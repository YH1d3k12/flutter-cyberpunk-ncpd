import 'package:flutter/material.dart';

class BootScreen extends StatefulWidget {
  const BootScreen({super.key});

  @override
  State<BootScreen> createState() => _BootScreenState();
}

class _BootScreenState extends State<BootScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _dotsAnimation;

  String currentText = "INITIALIZING SYSTEM...";
  bool accessGranted = false;
  String nextRoute = '/home';
  bool _started = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..repeat();

    _dotsAnimation = Tween<double>(begin: 0, end: 3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  // Verifica se os argumentos foram passados e inicia a sequência de boot.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_started) {
      final args = ModalRoute.of(context)?.settings.arguments;

      if (args is String) {
        nextRoute = args;
      }

      _started = true;
      _startBootSequence();
    }
  }

  Future<void> _startBootSequence() async {
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      currentText = "CONNECTING TO NCPD DATABASE";
    });

    await Future.delayed(const Duration(seconds: 2));

    _controller.stop();

    setState(() {
      accessGranted = true;
      currentText = "ACCESS GRANTED";
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    Navigator.pushReplacementNamed(context, nextRoute);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _buildDots(double value) {
    return "." * value.floor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _dotsAnimation,
          builder: (context, child) {
            final dots = accessGranted ? "" : _buildDots(_dotsAnimation.value);

            return Text(
              "> $currentText$dots",
              style: TextStyle(
                color: accessGranted
                    ? Colors.greenAccent
                    : Colors.cyanAccent,
                fontSize: 18,
                fontFamily: 'monospace',
              ),
            );
          },
        ),
      ),
    );
  }
}