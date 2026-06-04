// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  OfficerDao? _officerDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `officers` (`id` TEXT NOT NULL, `badge_number` TEXT NOT NULL, `name` TEXT NOT NULL, `rank` TEXT NOT NULL, `password_hash` TEXT NOT NULL, `status` TEXT NOT NULL, `created_at` INTEGER NOT NULL, `updated_at` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  OfficerDao get officerDao {
    return _officerDaoInstance ??= _$OfficerDao(database, changeListener);
  }
}

class _$OfficerDao extends OfficerDao {
  _$OfficerDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _officerEntityInsertionAdapter = InsertionAdapter(
            database,
            'officers',
            (OfficerEntity item) => <String, Object?>{
                  'id': item.id,
                  'badge_number': item.badgeNumber,
                  'name': item.name,
                  'rank': item.rank,
                  'password_hash': item.passwordHash,
                  'status': item.status,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                }),
        _officerEntityUpdateAdapter = UpdateAdapter(
            database,
            'officers',
            ['id'],
            (OfficerEntity item) => <String, Object?>{
                  'id': item.id,
                  'badge_number': item.badgeNumber,
                  'name': item.name,
                  'rank': item.rank,
                  'password_hash': item.passwordHash,
                  'status': item.status,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                }),
        _officerEntityDeletionAdapter = DeletionAdapter(
            database,
            'officers',
            ['id'],
            (OfficerEntity item) => <String, Object?>{
                  'id': item.id,
                  'badge_number': item.badgeNumber,
                  'name': item.name,
                  'rank': item.rank,
                  'password_hash': item.passwordHash,
                  'status': item.status,
                  'created_at': item.createdAt,
                  'updated_at': item.updatedAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OfficerEntity> _officerEntityInsertionAdapter;

  final UpdateAdapter<OfficerEntity> _officerEntityUpdateAdapter;

  final DeletionAdapter<OfficerEntity> _officerEntityDeletionAdapter;

  @override
  Future<List<OfficerEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM officers ORDER BY name ASC',
        mapper: (Map<String, Object?> row) => OfficerEntity(
            id: row['id'] as String,
            badgeNumber: row['badge_number'] as String,
            name: row['name'] as String,
            rank: row['rank'] as String,
            passwordHash: row['password_hash'] as String,
            status: row['status'] as String,
            createdAt: row['created_at'] as int,
            updatedAt: row['updated_at'] as int?));
  }

  @override
  Future<OfficerEntity?> findById(String id) async {
    return _queryAdapter.query('SELECT * FROM officers WHERE id = ?1',
        mapper: (Map<String, Object?> row) => OfficerEntity(
            id: row['id'] as String,
            badgeNumber: row['badge_number'] as String,
            name: row['name'] as String,
            rank: row['rank'] as String,
            passwordHash: row['password_hash'] as String,
            status: row['status'] as String,
            createdAt: row['created_at'] as int,
            updatedAt: row['updated_at'] as int?),
        arguments: [id]);
  }

  @override
  Future<OfficerEntity?> findByBadgeNumber(String badgeNumber) async {
    return _queryAdapter.query(
        'SELECT * FROM officers WHERE badge_number = ?1 LIMIT 1',
        mapper: (Map<String, Object?> row) => OfficerEntity(
            id: row['id'] as String,
            badgeNumber: row['badge_number'] as String,
            name: row['name'] as String,
            rank: row['rank'] as String,
            passwordHash: row['password_hash'] as String,
            status: row['status'] as String,
            createdAt: row['created_at'] as int,
            updatedAt: row['updated_at'] as int?),
        arguments: [badgeNumber]);
  }

  @override
  Future<int?> countAll() async {
    return _queryAdapter.query('SELECT COUNT(*) FROM officers',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> deleteById(String id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM officers WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertOfficer(OfficerEntity officer) async {
    await _officerEntityInsertionAdapter.insert(
        officer, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateOfficer(OfficerEntity officer) async {
    await _officerEntityUpdateAdapter.update(
        officer, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteOfficer(OfficerEntity officer) async {
    await _officerEntityDeletionAdapter.delete(officer);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _nullableDateTimeConverter = NullableDateTimeConverter();
