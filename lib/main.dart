import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/services/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'database/seed/mock_officers.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait for mobile (remove if targeting desktop/tablet)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 1. Initialize all services and the Floor database
  await ServiceLocator.instance.init();

  // 2. Seed mock officers if the database is empty
  await MockOfficers.seedIfEmpty(ServiceLocator.instance.officerDao);

  runApp(const NcpdApp());
}

class NcpdApp extends StatelessWidget {
  const NcpdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NCPD SYSTEM',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      initialRoute: AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
