import 'package:flutter/material.dart';
import 'package:job_finder_app/features/profile/view/profile_view.dart';
import 'package:job_finder_app/products/models/user_model.dart';
import 'package:job_finder_app/products/services/user/user_service_manager.dart';
import 'package:job_finder_app/products/utilities/extensions/date_to_string_extension.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/image_picker_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/user_mixin.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';

mixin ProfileMixin on BaseViewMixin<ProfileView>, ImageMixin<ProfileView>, UserMixin<ProfileView> {
  late final TextEditingController nameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController birthdayController;
  late final GlobalKey<FormState> formKey;
  late final ScrollController scrollController;
  DateTime? _selectedDate;
  UserModel get loggedInUser => getCubit<UserCubit>().state.loggedInUser!;
  late String userImageUrl;
  final ValueNotifier<bool> isProfileChangedNotifier = ValueNotifier<bool>(false);
  late final UserServiceManager _userServiceManager;

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
  }

  @override
  void initState() {
    super.initState();
    initControllers();
    setControllersText();
    _userServiceManager = UserServiceManager(UserService.instance);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      birthdayController.text = _selectedDate!.toDateString();
    }
  }

  void updateBirthdayValue() {
    if (_selectedDate == null && loggedInUser.birthday != null) {
      birthdayController.text = loggedInUser.birthday!.toDateString();
      return;
    }
    if (_selectedDate != null && _selectedDate != loggedInUser.birthday) {
      birthdayController.text = _selectedDate!.toDateString();
      return;
    }
  }

  void initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneNumberController = TextEditingController();
    nameController = TextEditingController();
    birthdayController = TextEditingController();
    scrollController = ScrollController();
    formKey = GlobalKey();
    // updateLoggedInUser();
    userImageUrl = loggedInUser.imageUrl!;
  }

  // void updateLoggedInUser() {
  //   loggedInUser = getCubit<UserCubit>().state.loggedInUser!;
  // }

  void setControllersText() {
    emailController.text = loggedInUser.email!;
    nameController.text = loggedInUser.name!;
    phoneNumberController.text = loggedInUser.phoneNo ?? '';
    passwordController.text = loggedInUser.password!;
    birthdayController.text = loggedInUser.birthday?.toDateString() ?? '';
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    scrollController.dispose();
    nameController.dispose();
    birthdayController.dispose();
  }

  void compareUserDetailsWithState() {
    if (loggedInUser.email != emailController.text ||
        loggedInUser.name != nameController.text ||
        loggedInUser.phoneNo != phoneNumberController.text ||
        loggedInUser.password != passwordController.text ||
        loggedInUser.birthday != _selectedDate) {
      isProfileChangedNotifier.value = true;
      return;
    }
    if (loggedInUser.email == emailController.text &&
        loggedInUser.name == nameController.text &&
        loggedInUser.phoneNo == phoneNumberController.text &&
        loggedInUser.password == passwordController.text &&
        loggedInUser.birthday == _selectedDate) {
      isProfileChangedNotifier.value = false;

      return;
    }
  }

  Future<void> changeProfilePicture() async {
    changeLoading();
    final String? responseUrl = await pickAndUploadImage();
    if (responseUrl != null) {
      setState(() {
        userImageUrl = responseUrl;
        isProfileChangedNotifier.value = true;
      });
    }
    changeLoading();
  }

  Future<void> saveChanges() async {
    changeLoading();
    if (formKey.currentState!.validate()) {
      final updatedUser = loggedInUser.copyWith(
        email: emailController.text,
        name: nameController.text,
        phoneNo: phoneNumberController.text,
        password: passwordController.text,
        birthday: _selectedDate,
      );
      await _userServiceManager.updateUser(updatedUser);
      if (userImageUrl != loggedInUser.imageUrl! &&
          loggedInUser.imageUrl != null &&
          loggedInUser.imageUrl!.isNotEmpty) {
        await removeFirstImage();
        await renameNewImage();
        await removeNewImage();
      } else {
        await tryUpdateUserImage(userImageUrl);
      }
      isProfileChangedNotifier.value = false;

      changeLoading();
    }
  }
}
