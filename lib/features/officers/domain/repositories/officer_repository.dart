import '../models/officer.dart';

/// Contract that the Data layer must fulfil.
/// The Presentation layer only knows this interface – never the implementation.
abstract class OfficerRepository {
  Future<List<Officer>> getAll();
  Future<Officer?> getById(String id);
  Future<Officer?> getByBadgeNumber(String badgeNumber);
  Future<int>      count();
  Future<void>     create(Officer officer);
  Future<void>     update(Officer officer);
  Future<void>     delete(String id);
}
