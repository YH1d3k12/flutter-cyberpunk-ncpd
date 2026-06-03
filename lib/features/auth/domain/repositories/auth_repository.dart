import '../models/officer_model.dart';

abstract class AuthRepository {
  Future<OfficerModel> login(String badge, String password);
}