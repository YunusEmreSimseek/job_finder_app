import 'package:flutter/material.dart';
import 'package:job_finder_app/products/services/user/user_service_manager.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';

mixin UserMixin<T extends StatefulWidget> on BaseViewMixin<T> {
  late final UserServiceManager _userServiceManager;
  @override
  void initState() {
    super.initState();
    _userServiceManager = UserServiceManager(UserService.instance);
  }

  Future<void> getAndSetLoggedInUser(String email) async {
    final response = await _userServiceManager.getUserByEmail(email);

    if (response != null) {
      getCubit<UserCubit>().setUser(response);
    }
  }

  Future<void> tryUpdateUserImage(String imageUrl) async {
    final userId = getCubit<UserCubit>().state.loggedInUser!.id;
    if (userId == null) return;
    await _userServiceManager.updateUserImage(userId: userId, imageUrl: imageUrl);
  }
}
