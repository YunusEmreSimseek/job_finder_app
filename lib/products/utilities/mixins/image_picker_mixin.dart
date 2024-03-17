import 'dart:io';

import 'package:flutter/material.dart';
import 'package:job_finder_app/products/services/image/image_service.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';
import 'package:job_finder_app/products/view_models/user_view_model.dart';

mixin ImageMixin<T extends StatefulWidget> on BaseViewMixin<T> {
  UserViewModel get _loggedInUser => getCubit<UserCubit>().state.loggedInUser!;
  IImageService get _imageService => ImageService(user: _loggedInUser);

  Future<String?> pickAndUploadImage() async {
    final file = await _pickImage();
    if (file == null) return null;
    final imageUrl = await _uploadImageToFirebaseoStorage(file);
    if (imageUrl == null) return null;
    return imageUrl;
  }

  Future<File?> _pickImage() async {
    final file = await _imageService.pickImageFromGallery();
    if (file != null) {
      return File(file.path);
    }
    return null;
  }

  Future<String?> _uploadImageToFirebaseoStorage(File file) async {
    if (_loggedInUser.imageUrl != null && _loggedInUser.imageUrl!.isNotEmpty) {
      final response = await _imageService.uploadNewImage(file);
      return response;
    }
    if (_loggedInUser.imageUrl == null || _loggedInUser.imageUrl!.isEmpty) {
      final response = await _imageService.uploadFirstImage(file);
      return response;
    }
    return null;
  }

  // Future<String?> pickImageAndUploadFirebaseStorage(UserModel user) async {
  //   final responseFile = await _pickImage();
  //   if (responseFile == null) {
  //     Logger().e('Image not picked');
  //     return null;
  //   }
  //   Logger().i('Image picked');
  //   final responseUrl = await _uploadImageToFirebaseStorage(file: responseFile, user: user);
  //   if (responseUrl == null) return null;
  //   return responseUrl;
  // }

  // Future<File?> _pickImage() async {
  //   final IImagePickerManager pickManager = ImagePickerManager();
  //   final model = await pickManager.fetchMediaImage();
  //   if (model!.file != null) {
  //     final XFile image = model.file!;
  //     final File file = File(image.path);
  //     return file;
  //   }
  //   return null;
  // }

  // Future<String?> _uploadImageToFirebaseStorage({required File file, required UserModel user}) async {
  //   if (user.imageUrl != null && user.imageUrl!.isNotEmpty) {
  //     final response = await _uploadAsUpdate(file);
  //     return response;
  //   }
  //   if (user.imageUrl == null || user.imageUrl!.isEmpty) {
  //     final response = await _uploadAsNew(file);
  //     return response;
  //   }
  //   return null;
  // }

  // Future<String?> _uploadAsNew(
  //   File file,
  // ) async {
  //   UploadTask uploadTask = _defaultStroageReference().putData(await file.readAsBytes(), _metadata);
  //   TaskSnapshot taskSnapshot = await uploadTask;
  //   final downloadUrl = await taskSnapshot.ref.getDownloadURL();
  //   if (downloadUrl.isNotEmpty) {
  //     Logger().i('Image uploaded to firebase storage');
  //     return downloadUrl;
  //   }
  //   Logger().e('Image upload failed');
  //   return null;
  // }

  // Future<String?> _uploadAsUpdate(File file) async {
  //   UploadTask uploadTask = _newStroageReference().putData(await file.readAsBytes(), _metadata);
  //   TaskSnapshot taskSnapshot = await uploadTask;
  //   final downloadUrl = await taskSnapshot.ref.getDownloadURL();
  //   if (downloadUrl.isNotEmpty) {
  //     Logger().i('Image uploaded to firebase storage');
  //     return downloadUrl;
  //   }
  //   Logger().e('Image upload failed');
  //   return null;
  // }

  Future<void> removeFirstImage() async {
    await _imageService.removeFirstImage();
  }

  Future<void> removeNewImage() async {
    await _imageService.removeNewImage();
  }

  Future<void> renameNewImage() async {
    await _imageService.renameNewImage();
  }
}
