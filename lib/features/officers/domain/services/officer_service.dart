import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

import '../models/officer.dart';
import '../repositories/officer_repository.dart';

/// All police-business rules for officers live here.
/// Services call Repositories – never DAOs or Floor directly.
class OfficerService {
  OfficerService(this._repository);

  final OfficerRepository _repository;

  // ── Queries ───────────────────────────────────────────────────────────────

  Future<List<Officer>> getAllOfficers() => _repository.getAll();

  Future<Officer?> getOfficerById(String id) => _repository.getById(id);

  Future<int> countOfficers() => _repository.count();

  // ── Commands ──────────────────────────────────────────────────────────────

  /// Creates a new officer after validation.
  Future<void> createOfficer({
    required String badgeNumber,
    required String name,
    required OfficerRank rank,
    required String password,
  }) async {
    _validateBadgeNumber(badgeNumber);
    _validateName(name);
    _validatePassword(password);

    final existing = await _repository.getByBadgeNumber(badgeNumber.trim());
    if (existing != null) {
      throw OfficerServiceException('Badge number ${badgeNumber.trim()} is already registered.');
    }

    final officer = Officer(
      id:           _generateId(),
      badgeNumber:  badgeNumber.trim().toUpperCase(),
      name:         name.trim(),
      rank:         rank,
      passwordHash: _hashPassword(password),
      status:       OfficerStatus.active,
      createdAt:    DateTime.now(),
    );

    await _repository.create(officer);
  }

  /// Updates an existing officer's mutable fields.
  Future<void> updateOfficer({
    required Officer current,
    required String name,
    required OfficerRank rank,
    required OfficerStatus status,
    String? newPassword, // null = keep existing hash
  }) async {
    _validateName(name);
    if (newPassword != null && newPassword.isNotEmpty) {
      _validatePassword(newPassword);
    }

    final updated = current.copyWith(
      name:         name.trim(),
      rank:         rank,
      status:       status,
      passwordHash: (newPassword != null && newPassword.isNotEmpty)
          ? _hashPassword(newPassword)
          : current.passwordHash,
      updatedAt:    DateTime.now(),
    );

    await _repository.update(updated);
  }

  /// Hard-deletes an officer record.
  Future<void> deleteOfficer(String id) => _repository.delete(id);

  // ── Helpers ───────────────────────────────────────────────────────────────

  static String hashPasswordPublic(String password) => _hashPassword(password);

  static String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  static String _generateId() {
    final ts  = DateTime.now().millisecondsSinceEpoch;
    final rnd = Random.secure().nextInt(999999).toString().padLeft(6, '0');
    return '${ts}_$rnd';
  }

  // ── Validators ────────────────────────────────────────────────────────────

  void _validateBadgeNumber(String value) {
    if (value.trim().isEmpty) {
      throw OfficerServiceException('Badge number is required.');
    }
    if (value.trim().length < 3) {
      throw OfficerServiceException('Badge number must be at least 3 characters.');
    }
  }

  void _validateName(String value) {
    if (value.trim().isEmpty) {
      throw OfficerServiceException('Name is required.');
    }
    if (value.trim().length < 2) {
      throw OfficerServiceException('Name must be at least 2 characters.');
    }
  }

  void _validatePassword(String value) {
    if (value.isEmpty) {
      throw OfficerServiceException('Password is required.');
    }
    if (value.length < 6) {
      throw OfficerServiceException('Password must be at least 6 characters.');
    }
  }
}

class OfficerServiceException implements Exception {
  const OfficerServiceException(this.message);
  final String message;

  @override
  String toString() => 'OfficerServiceException: $message';
}
