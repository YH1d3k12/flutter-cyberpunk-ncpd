import 'package:floor/floor.dart';

/// Represents a row in the [officers] SQLite table.
/// Contains only primitives – no business logic, no Flutter imports.
@Entity(tableName: 'officers')
class OfficerEntity {
  @PrimaryKey(autoGenerate: false)
  final String id;

  @ColumnInfo(name: 'badge_number')
  final String badgeNumber;

  final String name;

  /// Stored as raw string matching [OfficerRank.name].
  final String rank;

  @ColumnInfo(name: 'password_hash')
  final String passwordHash;

  /// Stored as raw string matching [OfficerStatus.name].
  final String status;

  @ColumnInfo(name: 'created_at')
  final int createdAt; // milliseconds since epoch

  @ColumnInfo(name: 'updated_at')
  final int? updatedAt; // nullable

  const OfficerEntity({
    required this.id,
    required this.badgeNumber,
    required this.name,
    required this.rank,
    required this.passwordHash,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });
}
