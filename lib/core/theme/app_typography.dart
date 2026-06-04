import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static const String _mono = 'monospace';

  static const TextStyle displayLarge = TextStyle(
    fontFamily: _mono,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    letterSpacing: 3.0,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _mono,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: 2.0,
  );

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: _mono,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 1.5,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: _mono,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 1.2,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    letterSpacing: 0.4,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: 0.3,
  );

  static const TextStyle labelPrimary = TextStyle(
    fontFamily: _mono,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    letterSpacing: 1.8,
  );

  static const TextStyle labelMuted = TextStyle(
    fontFamily: _mono,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    letterSpacing: 1.4,
  );
}
