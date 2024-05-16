import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_finder_app/features/profile/view/profile_view.dart';
import 'package:job_finder_app/products/models/user_model.dart';
import 'package:job_finder_app/products/services/auth/auth_manager.dart';
import 'package:job_finder_app/products/services/auth/auth_service.dart';
import 'package:job_finder_app/products/services/commands/update_user_command.dart';
import 'package:job_finder_app/products/utilities/enums/firebase_storage_paths.dart';
import 'package:job_finder_app/products/utilities/extensions/date_to_string_extension.dart';
import 'package:job_finder_app/products/utilities/mixins/keyboard_scroll_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/notification_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/image_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/user_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';

mixin ProfileMixin
    on
        BaseViewMixin<ProfileView>,
        ImageTransactionsMixin,
        UserTransactionMixin,
        KeyboardScrollMixin,
        NotificationMixin<ProfileView> {
  late final TextEditingController nameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController birthdayController;
  late final GlobalKey<FormState> formKey;
  DateTime? _selectedDate;
  UserModel get loggedInUser => getCubit<UserCubit>().state.loggedInUser!;
  late final ValueNotifier<XFile?> userImageFile;
  final ValueNotifier<bool> isProfileChangedNotifier = ValueNotifier<bool>(false);
  late final AuthManager _authManager;

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
    _authManager = AuthManager(AuthService.instance);
    userImageFile = ValueNotifier<XFile?>(null);
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
    formKey = GlobalKey();
  }

  void setControllersText() {
    emailController.text = loggedInUser.email!;
    nameController.text = loggedInUser.name!;
    phoneNumberController.text = loggedInUser.phoneNo ?? '';
    passwordController.text = loggedInUser.password!;
    birthdayController.text = loggedInUser.birthday?.toDateString() ?? '';
    _selectedDate = loggedInUser.birthday;
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
    final XFile? image = await pickImage();
    if (image != null) {
      userImageFile.value = image;
      isProfileChangedNotifier.value = true;
    }
    changeLoading();
  }

  Future<void> saveChanges() async {
    changeLoading();
    final isNameChanged = loggedInUser.name != nameController.text;
    final isEmailChanged = loggedInUser.email != emailController.text;
    final isPhoneNoChanged = loggedInUser.phoneNo != phoneNumberController.text;
    final isPasswordChanged = loggedInUser.password != passwordController.text;
    final isBirthdayChanged = loggedInUser.birthday != _selectedDate;
    final isImageChanged = userImageFile.value != null;

    if (isImageChanged &&
        !isBirthdayChanged &&
        !isPasswordChanged &&
        !isPhoneNoChanged &&
        !isEmailChanged &&
        !isNameChanged) {
      final response = await uploadImageAndUpdateUser();
      if (!response) {
        changeLoading();
        showTextDialog('An error occurred while updating the profile');
        return;
      }
      await getAndSetLoggedInUser(emailController.text);
      changeLoading();
      isProfileChangedNotifier.value = false;
      showTextDialog('Profile updated successfully');
      return;
    }
    // Check if the user has changed the profile picture and other details
    if (formKey.currentState!.validate()) {
      String? url;
      if (isImageChanged) {
        final downloadUrl = await uploadImage();
        if (downloadUrl != null) {
          url = downloadUrl;
        }
      }
      final UpdateUserCommand updateUserCommand = UpdateUserCommand(
        userId: loggedInUser.id!,
        email: emailController.text,
        name: nameController.text,
        phone: phoneNumberController.text.isEmpty ? null : phoneNumberController.text,
        password: passwordController.text,
        imageUrl: url ?? loggedInUser.imageUrl,
        birthDate: _selectedDate,
      );
      // Check if the user has changed the password
      if (isPasswordChanged) {
        await _authManager.changePassword(passwordController.text);
      }
      final response = await updateUser(updateUserCommand);
      if (!response) {
        changeLoading();
        showTextDialog('An error occurred while updating the profile');
        return;
      }
      await getAndSetLoggedInUser(emailController.text);
      changeLoading();
      isProfileChangedNotifier.value = false;
      showTextDialog('Profile updated successfully');
      return;
    }
    changeLoading();
  }

  Future<String?> uploadImage() async {
    final String fileName = '${loggedInUser.email}-${loggedInUser.name}';
    final String? downloadUrl = await uploadImageToFirebase(
        file: userImageFile.value!, fileName: fileName, path: FirebaseStoragePaths.user_images);
    return downloadUrl;
  }

  Future<bool> uploadImageAndUpdateUser() async {
    final String? downloadUrl = await uploadImage();
    if (downloadUrl != null) {
      final UpdateUserCommand updateUserCommand = UpdateUserCommand(
        userId: loggedInUser.id!,
        email: emailController.text,
        name: nameController.text,
        phone: phoneNumberController.text.isEmpty ? null : phoneNumberController.text,
        password: passwordController.text,
        imageUrl: downloadUrl,
        birthDate: _selectedDate,
      );
      final response = await updateUser(updateUserCommand);
      return response;
    }
    return false;
  }
}
