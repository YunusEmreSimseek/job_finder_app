import 'package:job_finder_app/products/models/user_model.dart';
import 'package:job_finder_app/products/utilities/enums/firebase_collections.dart';
import 'package:logger/logger.dart';

part 'user_service.dart';

final class UserManager {
  final IUserService _userService;

  UserManager(this._userService);

  Future<UserModel?> getUserByEmail(String email) async {
    final user = await _userService.getUserByEmail(email);
    return user;
  }

  Future<UserModel?> getUserById(String id) async {
    final user = await _userService.getUserById(id);
    return user;
  }

  Future<void> updateUserImage({required String imageUrl, required String userId}) async {
    await _userService.updateUserImage(userId: userId, imageUrl: imageUrl);
  }

  Future<void> updateUser(UserModel user) async {
    await _userService.updateUser(user);
  }
}
