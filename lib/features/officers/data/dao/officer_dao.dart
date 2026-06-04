import 'package:floor/floor.dart';
import '../entities/officer_entity.dart';

/// Data-access object for the [officers] table.
/// Only queries here – zero business logic, zero validation.
@dao
abstract class OfficerDao {
  // ── Queries ──────────────────────────────────────────────────────────────

  @Query('SELECT * FROM officers ORDER BY name ASC')
  Future<List<OfficerEntity>> findAll();

  @Query('SELECT * FROM officers WHERE id = :id')
  Future<OfficerEntity?> findById(String id);

  @Query('SELECT * FROM officers WHERE badge_number = :badgeNumber LIMIT 1')
  Future<OfficerEntity?> findByBadgeNumber(String badgeNumber);

  @Query('SELECT COUNT(*) FROM officers')
  Future<int?> countAll();

  // ── Write operations ─────────────────────────────────────────────────────

  @Insert(onConflict: OnConflictStrategy.abort)
  Future<void> insertOfficer(OfficerEntity officer);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateOfficer(OfficerEntity officer);

  @delete
  Future<void> deleteOfficer(OfficerEntity officer);

  @Query('DELETE FROM officers WHERE id = :id')
  Future<void> deleteById(String id);
}
