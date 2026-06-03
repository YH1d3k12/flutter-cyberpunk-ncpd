import '../../domain/models/officer_model.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<OfficerModel> login(String badge, String password) async {

    await Future.delayed(const Duration(seconds: 2)); 
    
    if (badge == "1234" && password == "cyberpunk") {
      return OfficerModel(id: "1", name: "Agente V", badgeNumber: badge);
    } else {
      throw Exception("Credenciais NCPD inválidas.");
    }
  }
}