import 'package:job_finder_app/products/services/auth/auth_service.dart';
import 'package:job_finder_app/products/services/commands/create_user_command.dart';

final class AuthManager {
  late final IAuthService _authService;

  AuthManager(this._authService);

  Future<bool> login({required String email, required String password}) async {
    final response = await _authService.loginWithEmailAndPassword(email: email, password: password);
    return response;
  }

  Future<bool> register(CreateUserCommand command) async {
    final response = await _authService.register(command);
    return response;
  }

  Future<bool> changePassword(String newPassword) async {
    final response = await _authService.changePassword(newPassword);
    return response;
  }
}
