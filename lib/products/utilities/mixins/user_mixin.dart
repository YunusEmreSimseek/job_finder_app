import 'package:flutter/material.dart';
import 'package:job_finder_app/products/models/user_model.dart';
import 'package:job_finder_app/products/services/company/company_service.dart';
import 'package:job_finder_app/products/services/user/user_service.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';
import 'package:job_finder_app/products/view_models/user_view_model.dart';
import 'package:logger/logger.dart';

mixin UserMixin<T extends StatefulWidget> on BaseViewMixin<T> {
  final IUserService _userService = UserService();
  final ICompanyService _companyService = CompanyService();

  Future<void> getLoggedInUser(String email) async {
    final response = await _userService.getUserByEmail(email);

    if (response != null) {
      final user = await toUserViewModel(response);
      if (user == null) return;
      getCubit<UserCubit>().setUser(user);
    }
  }

  Future<void> updateUserImage(String imageUrl) async {
    final userId = getCubit<UserCubit>().state.loggedInUser!.id;
    await _userService.updateUserImage(userId: userId, imageUrl: imageUrl);
  }

  Future<void> updateUser(UserModel user) async {
    await _userService.updateUser(user);
    await getLoggedInUser(user.email!);
  }

  Future<UserViewModel?> toUserViewModel(UserModel user) async {
    if (user.companyId != null) {
      final company = await _companyService.getCompanyById(user.companyId!);
      Logger().i('User converted to UserViewModel with company');
      return UserViewModel(
        id: user.id!,
        name: user.name!,
        email: user.email!,
        password: user.password!,
        imageUrl: user.imageUrl,
        location: user.location,
        phoneNo: user.phoneNo,
        company: company,
      );
    }
    Logger().i('User converted to UserViewModel without company');
    return UserViewModel(
      id: user.id!,
      name: user.name!,
      email: user.email!,
      password: user.password!,
      imageUrl: user.imageUrl,
      location: user.location,
      phoneNo: user.phoneNo,
    );
  }
}
