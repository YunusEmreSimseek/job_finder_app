import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_finder_app/products/enums/firebase_storage_paths.dart';
import 'package:job_finder_app/products/models/user_model.dart';
import 'package:logger/logger.dart';

abstract class IImageService {
  Future<XFile?> pickImageFromGallery();
  Future<String?> uploadFirstImage(File file);
  Future<String?> uploadNewImage(File file);
  Future<void> removeFirstImage();
  Future<void> removeNewImage();
  Future<void> renameNewImage();
}

final class ImageService implements IImageService {
  final UserModel user;
  ImageService({required this.user});
  final ImagePicker _picker = ImagePicker();

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final SettableMetadata _metadata = SettableMetadata(contentType: 'image/png');
  Reference _defaultStroageReference() =>
      _firebaseStorage.ref().child('${FirebaseStoragePaths.user_images.value}/${user.email}-${user.name}');
  Reference _newStroageReference() =>
      _firebaseStorage.ref().child('${FirebaseStoragePaths.user_images.value}/${user.email}-${user.name}-New');

  @override
  Future<XFile?> pickImageFromGallery() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      Logger().i('Image picked');
      return file;
    }
    Logger().e('Image not picked');
    return null;
  }

  @override
  Future<String?> uploadFirstImage(File file) async {
    UploadTask uploadTask = _defaultStroageReference().putData(await file.readAsBytes());
    TaskSnapshot taskSnapshot = await uploadTask;
    final downloadUrl = await taskSnapshot.ref.getDownloadURL();
    if (downloadUrl.isNotEmpty) {
      Logger().i('Firs Image uploaded to firebase storage');
      return downloadUrl;
    }
    Logger().e('First Image upload failed');
    return null;
  }

  @override
  Future<String?> uploadNewImage(File file) async {
    UploadTask uploadTask = _newStroageReference().putData(await file.readAsBytes(), _metadata);
    TaskSnapshot taskSnapshot = await uploadTask;
    final downloadUrl = await taskSnapshot.ref.getDownloadURL();
    if (downloadUrl.isNotEmpty) {
      Logger().i('New Image uploaded to firebase storage');
      return downloadUrl;
    }
    Logger().e('New Image upload failed');
    return null;
  }

  @override
  Future<void> removeFirstImage() async {
    await _defaultStroageReference().delete();
  }

  @override
  Future<void> removeNewImage() async {
    await _newStroageReference().delete();
  }

  @override
  Future<void> renameNewImage() async {
    final data = await _newStroageReference().getData();
    UploadTask uploadTask = _defaultStroageReference().putData(data!, _metadata);
    await uploadTask;
  }
}
