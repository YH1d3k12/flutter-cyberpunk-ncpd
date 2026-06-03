
import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/auth_boot_screen.dart';
import '../../features/home/home_screen.dart';
import '../features/auth/presentation/screens/auth_login_screen.dart';
import '../features/wanted/presentation/screens/wanted_screen.dart';

class AppRoutes {
  static const boot = '/boot';
  static const home = '/home';
  static const wanted = '/wanted';
  static const login = '/login';

  static Map<String, WidgetBuilder> routes = {
    boot: (_) => const BootScreen(),
    login: (_) => const LoginScreen(),
    home: (_) => const HomeScreen(),
    wanted: (_) => const WantedScreen()
  };
}
