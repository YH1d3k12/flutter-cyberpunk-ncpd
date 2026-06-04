import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

// ── Enums ────────────────────────────────────────────────────────────────────

enum OfficerRank {
  rookie,
  officer,
  detective,
  sergeant,
  lieutenant,
  captain,
  chief;

  String get displayName => name.toUpperCase();

  static OfficerRank fromString(String value) => OfficerRank.values.firstWhere(
        (e) => e.name == value.toLowerCase(),
        orElse: () => OfficerRank.officer,
      );
}

enum OfficerStatus {
  active,
  inactive,
  suspended,
  kia;

  String get displayName => name.toUpperCase();

  Color get color => switch (this) {
        OfficerStatus.active    => AppColors.statusActive,
        OfficerStatus.inactive  => AppColors.statusInactive,
        OfficerStatus.suspended => AppColors.statusSuspended,
        OfficerStatus.kia       => AppColors.statusKia,
      };

  static OfficerStatus fromString(String value) =>
      OfficerStatus.values.firstWhere(
        (e) => e.name == value.toLowerCase(),
        orElse: () => OfficerStatus.active,
      );
}

// ── Domain Model ─────────────────────────────────────────────────────────────

/// Pure domain object – no annotations, no DB imports.
class Officer {
  final String id;
  final String badgeNumber;
  final String name;
  final OfficerRank rank;
  final String passwordHash;
  final OfficerStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Officer({
    required this.id,
    required this.badgeNumber,
    required this.name,
    required this.rank,
    required this.passwordHash,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  /// Returns a copy with overridden fields.
  Officer copyWith({
    String? id,
    String? badgeNumber,
    String? name,
    OfficerRank? rank,
    String? passwordHash,
    OfficerStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Officer(
        id:           id           ?? this.id,
        badgeNumber:  badgeNumber  ?? this.badgeNumber,
        name:         name         ?? this.name,
        rank:         rank         ?? this.rank,
        passwordHash: passwordHash ?? this.passwordHash,
        status:       status       ?? this.status,
        createdAt:    createdAt    ?? this.createdAt,
        updatedAt:    updatedAt    ?? this.updatedAt,
      );

  @override
  String toString() =>
      'Officer(id: $id, badge: $badgeNumber, name: $name, rank: ${rank.displayName})';
}
