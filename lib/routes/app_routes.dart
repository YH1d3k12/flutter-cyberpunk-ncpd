import 'package:flutter/material.dart';

import '../features/auth/presentation/screens/login_screen.dart';
import '../features/home/home_screen.dart';
import '../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../features/officers/presentation/screens/officers_list_screen.dart';
import '../features/officers/presentation/screens/officer_form_screen.dart';

/// Central routing table.
/// All named routes are registered here – never scattered in screens.
class AppRoutes {
  AppRoutes._();

  static const String login         = '/';
  static const String home          = '/home';
  static const String dashboard     = '/dashboard';
  static const String officers      = '/officers';
  static const String officerCreate = '/officers/create';

  static Map<String, WidgetBuilder> get routes => {
    login:         (_) => const LoginScreen(),
    home:          (_) => const LoginScreen(),
    dashboard:     (_) => const DashboardScreen(),
    officers:      (_) => const OfficersListScreen(),
    officerCreate: (_) => const OfficerFormScreen(),
  };
}
