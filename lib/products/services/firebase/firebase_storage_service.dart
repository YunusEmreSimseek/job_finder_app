import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:job_finder_app/products/utilities/enums/firebase_storage_paths.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

abstract class IFirebaseStorageService {
  Future<String?> uploadFile({required Uint8List file, required FirebaseStoragePaths path, required String fileName});
  Future<String?> uploadImage({required Uint8List file, required FirebaseStoragePaths path, required String fileName});
  Future<void> downloadFile(String fileName);
  Future<void> deleteFile(String fileName);
  Future<bool> deleteImage({required FirebaseStoragePaths path, required String fileName});
}

final class FirebaseStorageService implements IFirebaseStorageService {
  // Singleton
  static FirebaseStorageService? _instance;
  static FirebaseStorageService get instance {
    _instance ??= FirebaseStorageService._init();
    return _instance!;
  }

  FirebaseStorageService._init();

  final FirebaseStorage _storageRef = FirebaseStorage.instance;

  @override
  Future<String?> uploadFile(
      {required Uint8List file, required FirebaseStoragePaths path, required String fileName}) async {
    final response = await _storageRef.ref('${path.value}/$fileName').putData(file);
    final downloadUrl = await response.ref.getDownloadURL();
    if (downloadUrl.isNotEmpty) {
      Logger().i('File uploaded to firebase storage');
      return downloadUrl;
    }
    Logger().e('File upload failed');
    return null;
  }

  @override
  Future<String?> uploadImage(
      {required Uint8List file, required FirebaseStoragePaths path, required String fileName}) async {
    final response =
        await _storageRef.ref('${path.value}/$fileName').putData(file, SettableMetadata(contentType: 'image/png'));
    final downloadUrl = await response.ref.getDownloadURL();
    if (downloadUrl.isNotEmpty) {
      Logger().i('Image uploaded to firebase storage');
      return downloadUrl;
    }
    Logger().e('Image upload failed');
    return null;
  }

  @override
  Future<bool> deleteImage({required FirebaseStoragePaths path, required String fileName}) async {
    try {
      await _storageRef.ref('${path.value}/$fileName').delete();
      return true;
    } catch (e) {
      Logger().e('Image delete failed');
      return false;
    }
  }

  @override
  Future<void> downloadFile(String fileName) async {
    final response = await _storageRef.ref('files/$fileName').getData();
    if (response == null) {
      Logger().e('File download failed');
      return;
    }
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(response);
  }

  @override
  Future<void> deleteFile(String fileName) async {
    await _storageRef.ref('files/$fileName').delete();
  }
}
