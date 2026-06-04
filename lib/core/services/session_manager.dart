import '../../features/officers/domain/models/officer.dart';

/// Manages the currently logged-in officer across the session.
/// Simple in-memory store – no persistence required for the MVP.
class SessionManager {
  SessionManager._();
  static final SessionManager instance = SessionManager._();

  Officer? _currentOfficer;

  Officer? get currentOfficer => _currentOfficer;
  bool get isLoggedIn => _currentOfficer != null;

  void setCurrentOfficer(Officer officer) {
    _currentOfficer = officer;
  }

  void clearSession() {
    _currentOfficer = null;
  }
}
