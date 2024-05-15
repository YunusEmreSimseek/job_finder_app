import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

abstract class ICacheService {
  Future<Directory> createDocumentsPath(String name);
  Future<Directory> createDownloadsPath(String name);
  Future<String?> getDownloadsPath();
  Future<String> getDocumentsPath();
  Future<bool> savePdf({required List<int> pdf, required String path});
}

final class CacheService implements ICacheService {
// Singleton
  static CacheService? _instance;
  static CacheService get instance {
    _instance ??= CacheService._init();
    return _instance!;
  }

  CacheService._init();

  String? mainDocumentsPath;
  String? mainDownloadsPath;
  @override
  Future<Directory> createDocumentsPath(String name) async {
    if (mainDocumentsPath != null) {
      final path = Directory('$mainDocumentsPath/$name').create(recursive: true);
      return path;
    }
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String appPath = appDirectory.path;
    mainDocumentsPath = appPath;
    final newPath = await Directory('$appPath/$name').create(recursive: true);
    return newPath;
  }

  @override
  Future<Directory> createDownloadsPath(String name) async {
    if (mainDownloadsPath != null) {
      final path = Directory('$mainDownloadsPath/$name').create(recursive: true);
      return path;
    }
    Directory? appDirectory = await getDownloadsDirectory();
    String? appPath = appDirectory?.path;
    mainDocumentsPath = appPath;
    final newPath = await Directory('$appPath/$name').create(recursive: true);
    return newPath;
  }

  @override
  Future<String?> getDownloadsPath() async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  @override
  Future<String> getDocumentsPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Future<bool> savePdf({required List<int> pdf, required String path}) async {
    final file = File(path);
    try {
      await file.writeAsBytes(pdf);
      Logger().d('Pdf saved to $path');
      return true;
    } catch (e) {
      Logger().e('Error while saving pdf: $e');
      return false;
    }
  }
}
