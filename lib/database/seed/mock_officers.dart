import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

import '../../features/officers/data/dao/officer_dao.dart';
import '../../features/officers/data/entities/officer_entity.dart';

/// Seeds the database with mock officers if the table is empty.
/// All mock passwords are: ncpd2077
class MockOfficers {
  MockOfficers._();

  static String _hash(String password) =>
      sha256.convert(utf8.encode(password)).toString();

  static String _id(int suffix) {
    final ts = DateTime(2077, 1, 1).millisecondsSinceEpoch + suffix;
    return '${ts}_${suffix.toString().padLeft(6, '0')}';
  }

  static Future<void> seedIfEmpty(OfficerDao dao) async {
    final count = await dao.countAll() ?? 0;
    if (count > 0) return;

    final now = DateTime.now().millisecondsSinceEpoch;
    const pass = 'ncpd2077';

    final officers = [
      OfficerEntity(
        id:           _id(1),
        badgeNumber:  'NCPD-001',
        name:         'Viktor Vektor',
        rank:         'captain',
        passwordHash: _hash(pass),
        status:       'active',
        createdAt:    now,
      ),
      OfficerEntity(
        id:           _id(2),
        badgeNumber:  'NCPD-002',
        name:         'River Ward',
        rank:         'detective',
        passwordHash: _hash(pass),
        status:       'active',
        createdAt:    now,
      ),
      OfficerEntity(
        id:           _id(3),
        badgeNumber:  'NCPD-003',
        name:         'Judy Alvarez',
        rank:         'officer',
        passwordHash: _hash(pass),
        status:       'active',
        createdAt:    now,
      ),
      OfficerEntity(
        id:           _id(4),
        badgeNumber:  'NCPD-004',
        name:         'Panam Palmer',
        rank:         'sergeant',
        passwordHash: _hash(pass),
        status:       'suspended',
        createdAt:    now,
      ),
      OfficerEntity(
        id:           _id(5),
        badgeNumber:  'NCPD-005',
        name:         'Johnny Silverhand',
        rank:         'rookie',
        passwordHash: _hash(pass),
        status:       'inactive',
        createdAt:    now,
      ),
    ];

    for (final officer in officers) {
      await dao.insertOfficer(officer);
    }
  }
}
