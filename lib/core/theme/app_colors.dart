import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Background ──────────────────────────────────────────────────────────
  static const Color background         = Color(0xFF080C14);
  static const Color backgroundSecondary = Color(0xFF0D1320);
  static const Color backgroundCard     = Color(0xFF111927);
  static const Color backgroundInput    = Color(0xFF0A1018);

  // ── Primary – NCPD Neon Cyan ────────────────────────────────────────────
  static const Color primary     = Color(0xFF00E5FF);
  static const Color primaryDark = Color(0xFF0099CC);
  static const Color primaryGlow = Color(0x3300E5FF);

  // ── Accent – Warning Amber ──────────────────────────────────────────────
  static const Color accent     = Color(0xFFFFC107);
  static const Color accentGlow = Color(0x33FFC107);

  // ── Danger – Alert Red ──────────────────────────────────────────────────
  static const Color danger     = Color(0xFFFF1744);
  static const Color dangerGlow = Color(0x33FF1744);

  // ── Success – Neon Green ────────────────────────────────────────────────
  static const Color success     = Color(0xFF00E676);
  static const Color successGlow = Color(0x3300E676);

  // ── Text ────────────────────────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFFD0E8F8);
  static const Color textSecondary = Color(0xFF6A8FA8);
  static const Color textMuted     = Color(0xFF2E4A62);

  // ── Border ──────────────────────────────────────────────────────────────
  static const Color border       = Color(0xFF1A2D42);
  static const Color borderActive = Color(0xFF00E5FF);
  static const Color borderGlow   = Color(0x5500E5FF);

  // ── Status ──────────────────────────────────────────────────────────────
  static const Color statusActive    = Color(0xFF00E676);
  static const Color statusInactive  = Color(0xFF6A8FA8);
  static const Color statusSuspended = Color(0xFFFF9100);
  static const Color statusKia       = Color(0xFFFF1744);
}
