import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_finder_app/products/enums/firebase_collections.dart';
import 'package:job_finder_app/products/models/user_model.dart';
import 'package:logger/logger.dart';

part 'auth_service.dart';

final class AuthServiceManager {
  final IAuthService _authService;

  AuthServiceManager(this._authService);

  Future<bool> login({required String email, required String password}) async {
    final response = await _authService.loginWithEmailAndPassword(email: email, password: password);
    return response;
  }

  Future<bool> register(UserModel user) async {
    final response = await _authService.register(user: user);
    return response;
  }
}
