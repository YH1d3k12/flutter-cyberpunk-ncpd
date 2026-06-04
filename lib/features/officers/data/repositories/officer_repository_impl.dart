import '../../domain/models/officer.dart';
import '../../domain/repositories/officer_repository.dart';
import '../dao/officer_dao.dart';
import '../mappers/officer_mapper.dart';

/// Concrete implementation of [OfficerRepository].
/// Accesses [OfficerDao] and converts with [OfficerMapper].
/// Zero business rules here – only CRUD plumbing.
class OfficerRepositoryImpl implements OfficerRepository {
  OfficerRepositoryImpl(this._dao);

  final OfficerDao _dao;

  @override
  Future<List<Officer>> getAll() async {
    final entities = await _dao.findAll();
    return OfficerMapper.toDomainList(entities);
  }

  @override
  Future<Officer?> getById(String id) async {
    final entity = await _dao.findById(id);
    return entity != null ? OfficerMapper.toDomain(entity) : null;
  }

  @override
  Future<Officer?> getByBadgeNumber(String badgeNumber) async {
    final entity = await _dao.findByBadgeNumber(badgeNumber);
    return entity != null ? OfficerMapper.toDomain(entity) : null;
  }

  @override
  Future<int> count() async => await _dao.countAll() ?? 0;

  @override
  Future<void> create(Officer officer) =>
      _dao.insertOfficer(OfficerMapper.toEntity(officer));

  @override
  Future<void> update(Officer officer) =>
      _dao.updateOfficer(OfficerMapper.toEntity(officer));

  @override
  Future<void> delete(String id) => _dao.deleteById(id);
}
