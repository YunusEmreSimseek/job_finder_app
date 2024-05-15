import 'dart:io';

import 'package:job_finder_app/products/services/cache/cache_service.dart';

final class CacheManager {
  late final ICacheService _cacheService;

  CacheManager(this._cacheService);

  Future<Directory> createDocumentsPath(String name) async {
    final response = await _cacheService.createDocumentsPath(name);
    return response;
  }

  Future<Directory> createDownloadsPath(String name) async {
    final response = await _cacheService.createDownloadsPath(name);
    return response;
  }

  Future<String?> getDownloadsPath() async {
    final response = await _cacheService.getDownloadsPath();
    return response;
  }

  Future<String> getDocumentsPath() async {
    final response = await _cacheService.getDocumentsPath();
    return response;
  }

  Future<bool> savePdf({required List<int> pdf, required String path}) async {
    final response = await _cacheService.savePdf(pdf: pdf, path: path);
    return response;
  }
}
