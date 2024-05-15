import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_finder_app/products/models/company_model.dart';
import 'package:job_finder_app/products/services/company/company_manager.dart';
import 'package:job_finder_app/products/services/company/company_service.dart';
import 'package:job_finder_app/products/services/firebase/firebase_storage_manager.dart';
import 'package:job_finder_app/products/services/firebase/firebase_storage_service.dart';
import 'package:job_finder_app/products/services/image/pick_image_manager.dart';
import 'package:job_finder_app/products/services/image/pick_image_service.dart';
import 'package:job_finder_app/products/utilities/enums/firebase_storage_paths.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/company_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/widgets/dialogs/company/add_company_dialog.dart';
import 'package:job_finder_app/products/widgets/dialogs/text_dialog.dart';

mixin AddCompanyDialogMixin on BaseViewMixin<AddCompanyDialog>, CompanyTransactionsMixin {
  late final TextEditingController titleController;
  late final TextEditingController contenetController;
  late final FirebaseStorageManager _firebaseStorageManager;
  late final PickImageManager _pickImageManager;
  late final CompanyManager _companyManager;
  late final ValueNotifier<XFile?> imageNotifier;

  Future<void> pickImage() async {
    changeLoading();
    final response = await _pickImageManager.pickImageFromGallery();
    if (response != null) {
      imageNotifier.value = response;
    }
    changeLoading();
  }

  Future<String?> saveImageToFirebaseStorage() async {
    if (imageNotifier.value == null) return null;
    final file = await imageNotifier.value!.readAsBytes();
    final imageUrl = await _firebaseStorageManager.uploadFile(
        file: file, path: FirebaseStoragePaths.company_images, fileName: '${titleController.text}.png');
    return imageUrl;
  }

  Future<void> addCompany() async {
    if (titleController.text.isEmpty || contenetController.text.isEmpty) return;
    changeLoading();
    final imageUrl = await saveImageToFirebaseStorage();
    if (imageUrl != null) {
      final company = CompanyModel(
        title: titleController.text,
        content: contenetController.text,
        imageUrl: imageUrl,
      );
      final response = await _companyManager.addCompany(company);
      if (response) {
        await getAndSetCompanies();
        changeLoading();
        safeOperation(() => TextDialog.show(context: context, text: 'Company added successfully'));
        return;
      }
      changeLoading();
      safeOperation(() => TextDialog.show(context: context, text: 'Company could not be added'));
      return;
    }
    changeLoading();
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contenetController = TextEditingController();
    _pickImageManager = PickImageManager(PickImageService.instance);
    _firebaseStorageManager = FirebaseStorageManager(FirebaseStorageService.instance);
    _companyManager = CompanyManager(CompanyService.instance);
    imageNotifier = ValueNotifier(null);
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contenetController.dispose();
  }
}
