import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:job_finder_app/products/services/firebase/firebase_storage_manager.dart';
import 'package:job_finder_app/products/services/firebase/firebase_storage_service.dart';
import 'package:job_finder_app/products/services/image/pick_image_manager.dart';
import 'package:job_finder_app/products/services/image/pick_image_service.dart';
import 'package:job_finder_app/products/utilities/enums/firebase_storage_paths.dart';

mixin ImageTransactionsMixin {
  final PickImageManager _pickImageManager = PickImageManager(PickImageService.instance);
  final FirebaseStorageManager _firebaseStorageManager = FirebaseStorageManager(FirebaseStorageService.instance);

  Future<XFile?> pickImage() async {
    final XFile? file = await _pickImageManager.pickImageFromGallery();
    return file;
  }

  Future<String?> uploadImageToFirebase(
      {required XFile file, required FirebaseStoragePaths path, required String fileName}) async {
    final Uint8List bytes = await file.readAsBytes();
    final downloadUrl = await _firebaseStorageManager.uploadImage(file: bytes, path: path, fileName: fileName);
    return downloadUrl;
  }
}
