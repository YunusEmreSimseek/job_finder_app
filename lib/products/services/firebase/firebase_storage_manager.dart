import 'package:flutter/foundation.dart';
import 'package:job_finder_app/products/services/firebase/firebase_storage_service.dart';
import 'package:job_finder_app/products/utilities/enums/firebase_storage_paths.dart';

final class FirebaseStorageManager {
  late final IFirebaseStorageService _firebaseStorageService;

  FirebaseStorageManager(this._firebaseStorageService);

  Future<String?> uploadFile(
          {required Uint8List file, required FirebaseStoragePaths path, required String fileName}) async =>
      await _firebaseStorageService.uploadFile(file: file, fileName: fileName, path: path);

  Future<String?> uploadImage(
          {required Uint8List file, required FirebaseStoragePaths path, required String fileName}) async =>
      await _firebaseStorageService.uploadImage(file: file, fileName: fileName, path: path);

  Future<void> downloadFile(String fileName) async => await _firebaseStorageService.downloadFile(fileName);

  Future<void> deleteFile(String fileName) async => await _firebaseStorageService.deleteFile(fileName);

  Future<bool> deleteImage({required FirebaseStoragePaths path, required String fileName}) async =>
      await _firebaseStorageService.deleteImage(path: path, fileName: fileName);
}
