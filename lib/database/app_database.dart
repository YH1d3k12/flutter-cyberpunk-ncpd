import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

// Aqui você importará seus DAOs e Entities futuramente
// import '../features/officers/data/entities/officer_entity.dart';
// import '../features/officers/data/dao/officer_dao.dart';

part 'app_database.g.dart'; // Arquivo gerado automaticamente pelo build_runner

@Database(version: 1, entities: [
  // OfficerEntity::class, (Exemplo de registro de entidade)
])
abstract class AppDatabase extends FloorDatabase {
  // abstract OfficerDao get officerDao; (Exemplo de registro de DAO)
}