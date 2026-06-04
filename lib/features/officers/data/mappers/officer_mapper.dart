import '../../domain/models/officer.dart';
import '../entities/officer_entity.dart';

/// Converts between [OfficerEntity] (DB) and [Officer] (domain).
/// No business logic here – only structural mapping.
class OfficerMapper {
  const OfficerMapper._();

  /// [OfficerEntity] → [Officer]
  static Officer toDomain(OfficerEntity e) => Officer(
        id:           e.id,
        badgeNumber:  e.badgeNumber,
        name:         e.name,
        rank:         OfficerRank.fromString(e.rank),
        passwordHash: e.passwordHash,
        status:       OfficerStatus.fromString(e.status),
        createdAt:    DateTime.fromMillisecondsSinceEpoch(e.createdAt),
        updatedAt:    e.updatedAt != null
            ? DateTime.fromMillisecondsSinceEpoch(e.updatedAt!)
            : null,
      );

  /// [Officer] → [OfficerEntity]
  static OfficerEntity toEntity(Officer o) => OfficerEntity(
        id:           o.id,
        badgeNumber:  o.badgeNumber,
        name:         o.name,
        rank:         o.rank.name,
        passwordHash: o.passwordHash,
        status:       o.status.name,
        createdAt:    o.createdAt.millisecondsSinceEpoch,
        updatedAt:    o.updatedAt?.millisecondsSinceEpoch,
      );

  /// Maps a list of entities to domain models.
  static List<Officer> toDomainList(List<OfficerEntity> entities) =>
      entities.map(toDomain).toList();
}
