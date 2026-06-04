import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../../officers/domain/models/officer.dart';
import '../../../officers/domain/repositories/officer_repository.dart';

/// Concrete auth implementation.
///
/// The 2-second delay simulates the latency of the NCPD secure network —
/// replace with a real HTTP call when the back-end is ready.
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._officerRepository);

  final OfficerRepository _officerRepository;

  @override
  Future<Officer?> login(String badgeNumber, String password) async {
    // ⚡ NCPD NETWORK SIMULATION – 2-second latency
    await Future.delayed(const Duration(seconds: 2));

    final officer = await _officerRepository.getByBadgeNumber(
      badgeNumber.trim().toUpperCase(),
    );

    if (officer == null) return null;

    final inputHash = _hashPassword(password);
    if (inputHash != officer.passwordHash) return null;

    if (officer.status == OfficerStatus.inactive ||
        officer.status == OfficerStatus.kia) {
      throw AuthException(
        'Access denied. Officer status: ${officer.status.displayName}.',
      );
    }

    if (officer.status == OfficerStatus.suspended) {
      throw AuthException(
        'Access denied. Officer ${officer.badgeNumber} is currently SUSPENDED.',
      );
    }

    return officer;
  }

  @override
  Future<void> logout() async {
    // Stateless MVP – nothing to clear on the data layer.
    await Future.delayed(const Duration(milliseconds: 300));
  }

  // ── Private ────────────────────────────────────────────────────────────────
  static String _hashPassword(String password) =>
      sha256.convert(utf8.encode(password)).toString();
}
