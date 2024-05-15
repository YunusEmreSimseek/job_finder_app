import 'package:job_finder_app/products/services/user/user_manager.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';

mixin UserTransactionMixin {
  late final UserManager _userServiceManager = UserManager(UserService.instance);

  Future<void> getAndSetLoggedInUser(String email) async {
    final response = await _userServiceManager.getUserByEmail(email);

    if (response != null) {
      UserCubit.instance.setUser(response);
    }
  }

  Future<void> tryUpdateUserImage(String imageUrl) async {
    final userId = UserCubit.instance.state.loggedInUser!.id;
    if (userId == null) return;
    await _userServiceManager.updateUserImage(userId: userId, imageUrl: imageUrl);
  }

  Future<bool> checkEmailUsing(String email) async {
    final response = await _userServiceManager.getUserByEmail(email);
    if (response != null) return true;
    return false;
  }
}
