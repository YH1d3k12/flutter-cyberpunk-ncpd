import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.backgroundSecondary,
      error: AppColors.danger,
    ),
    textTheme: const TextTheme(
      displayLarge:  AppTypography.displayLarge,
      displayMedium: AppTypography.displayMedium,
      headlineLarge: AppTypography.headlineLarge,
      headlineMedium: AppTypography.headlineMedium,
      bodyLarge:     AppTypography.bodyLarge,
      bodyMedium:    AppTypography.bodyMedium,
      labelLarge:    AppTypography.labelPrimary,
      labelSmall:    AppTypography.labelMuted,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundSecondary,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'monospace',
        color: AppColors.primary,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 2.5,
      ),
      iconTheme: IconThemeData(color: AppColors.primary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        minimumSize: const Size(double.infinity, 50),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        textStyle: const TextStyle(
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
          fontSize: 13,
          letterSpacing: 2.5,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        minimumSize: const Size(double.infinity, 50),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        textStyle: const TextStyle(
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
          fontSize: 13,
          letterSpacing: 2.0,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          letterSpacing: 1.5,
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.backgroundInput,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border),
        borderRadius: BorderRadius.zero,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border),
        borderRadius: BorderRadius.zero,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        borderRadius: BorderRadius.zero,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.danger),
        borderRadius: BorderRadius.zero,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.danger, width: 1.5),
        borderRadius: BorderRadius.zero,
      ),
      labelStyle: TextStyle(
        color: AppColors.textSecondary,
        fontFamily: 'monospace',
        fontSize: 11,
        letterSpacing: 1.5,
      ),
      hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
      prefixIconColor: AppColors.textMuted,
      suffixIconColor: AppColors.textMuted,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.border,
      thickness: 1,
    ),
    iconTheme: const IconThemeData(color: AppColors.primary),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.backgroundCard,
      contentTextStyle: TextStyle(color: AppColors.textPrimary),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    ),
    useMaterial3: true,
  );
}
