import '../../database/app_database.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/officers/data/dao/officer_dao.dart';
import '../../features/officers/data/repositories/officer_repository_impl.dart';
import '../../features/officers/domain/repositories/officer_repository.dart';
import '../../features/officers/domain/services/officer_service.dart';

/// Simple service locator (manual DI) – no third-party DI package required.
/// Call [init] once in [main] before [runApp].
class ServiceLocator {
  ServiceLocator._();
  static final ServiceLocator instance = ServiceLocator._();

  late AppDatabase _database;
  late OfficerDao _officerDao;
  late OfficerRepository _officerRepository;
  late AuthRepository _authRepository;
  late OfficerService _officerService;

  // ── Public accessors ────────────────────────────────────────────────────
  AppDatabase      get database          => _database;
  OfficerDao       get officerDao        => _officerDao;
  OfficerRepository get officerRepository => _officerRepository;
  AuthRepository   get authRepository    => _authRepository;
  OfficerService   get officerService    => _officerService;

  // ── Initialisation ──────────────────────────────────────────────────────
  Future<void> init() async {
    _database          = await AppDatabase.init();
    _officerDao        = _database.officerDao;
    _officerRepository = OfficerRepositoryImpl(_officerDao);
    _authRepository    = AuthRepositoryImpl(_officerRepository);
    _officerService    = OfficerService(_officerRepository);
  }
}
