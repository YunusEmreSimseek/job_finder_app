import 'package:flutter/material.dart';
import 'package:job_finder_app/features/profile/view/profile_view.dart';
import 'package:job_finder_app/products/models/company_model.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/company_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/image_picker_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/user_mixin.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';
import 'package:job_finder_app/products/view_models/user_view_model.dart';

mixin ProfileMixin
    on
        State<ProfileView>,
        BaseViewMixin<ProfileView>,
        ImageMixin<ProfileView>,
        UserMixin<ProfileView>,
        CompanyMixin<ProfileView> {
  late final TextEditingController nameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formKey;
  late final ScrollController scrollController;
  // late CompanyModel? selectedCompany;
  List<DropdownMenuItem<CompanyModel>> items = [];
  UserViewModel get loggedInUser => getCubit<UserCubit>().state.loggedInUser!;
  late String userImageUrl;
  final ValueNotifier<bool> isProfileChangedNotifier = ValueNotifier<bool>(false);
  late final ValueNotifier<CompanyModel?> selectedCompany;

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
    selectedCompany = ValueNotifier<CompanyModel?>(loggedInUser.company);
    Future.microtask(() async => items = await getAllCompanies() ?? []);
  }

  void initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneNumberController = TextEditingController();
    nameController = TextEditingController();
    scrollController = ScrollController();
    formKey = GlobalKey();
    // updateLoggedInUser();
    userImageUrl = loggedInUser.imageUrl!;
    //selectedCompany = loggedInUser.company;
  }

  // void updateLoggedInUser() {
  //   loggedInUser = getCubit<UserCubit>().state.loggedInUser!;
  // }

  void setControllersText() {
    emailController.text = loggedInUser.email;
    nameController.text = loggedInUser.name;
    phoneNumberController.text = loggedInUser.phoneNo!;
    passwordController.text = loggedInUser.password;
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    scrollController.dispose();
    nameController.dispose();
  }

  void compareUserDetailsWithState() {
    if (loggedInUser.email != emailController.text ||
        loggedInUser.name != nameController.text ||
        loggedInUser.phoneNo != phoneNumberController.text ||
        loggedInUser.password != passwordController.text) {
      isProfileChangedNotifier.value = true;
      return;
    }
    if (loggedInUser.email == emailController.text &&
        loggedInUser.name == nameController.text &&
        loggedInUser.phoneNo == phoneNumberController.text &&
        loggedInUser.password == passwordController.text) {
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
      final convertedUser = loggedInUser.toUserModel();
      final updatedUser = convertedUser.copyWith(
        email: emailController.text,
        name: nameController.text,
        phoneNo: phoneNumberController.text,
        password: passwordController.text,
      );
      await updateUser(updatedUser);
      if (userImageUrl != loggedInUser.imageUrl! &&
          loggedInUser.imageUrl != null &&
          loggedInUser.imageUrl!.isNotEmpty) {
        await removeFirstImage();
        await renameNewImage();
        await removeNewImage();
      } else {
        await updateUserImage(userImageUrl);
      }
      if (selectedCompany.value != loggedInUser.company) {
        final user = updatedUser.copyWith(companyId: selectedCompany.value?.id);
        await updateUser(user);
      }
      isProfileChangedNotifier.value = false;
    }
    changeLoading();
  }

  void changeCompany(CompanyModel? value) {
    if (value != null) {
      if (loggedInUser.company != value) {
        selectedCompany.value = value;
        isProfileChangedNotifier.value = true;
        return;
      }
      if (loggedInUser.company == value) {
        selectedCompany.value = value;
        isProfileChangedNotifier.value = false;
        return;
      }
    }
  }
}
