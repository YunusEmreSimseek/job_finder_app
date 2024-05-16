import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:job_finder_app/products/services/cache/cache_service.dart';
import 'package:job_finder_app/products/services/image/download_image_service.dart';
import 'package:job_finder_app/products/services/queries/get_user_by_id_query.dart';
import 'package:job_finder_app/products/services/user/user_manager.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:vexana/vexana.dart';

import '../firebase/mock_firebase.dart';
import 'mock_path.dart';

void main() {
  late final MockFirebaseService service;
  late final UserManager userServiceManager;
  late final ICacheService cacheManager;
  late final IImageService imageService;

  setUp(() {
    imageService = ImageService(NetworkManager<EmptyModel>(options: BaseOptions()));
    service = MockFirebaseService();
    userServiceManager = UserManager(service);
    cacheManager = CacheService.instance;
    PathProviderPlatform.instance = MockPathProviderPlatform();
  });
  test('Sample Test', () async {
    final query = GetUserByIdQuery('1');
    final response = await userServiceManager.getUserById(query);
    expect(response, isNotNull);
  });

  test('Create Sample File', () async {
    final path = await cacheManager.createDocumentsPath('deneme');
    expect(path, isNotNull);
  });

  test('Fetch Data And Create File With Data', () async {
    final query = GetUserByIdQuery('1');
    final response = await userServiceManager.getUserById(query);
    final path = await cacheManager.createDocumentsPath('images');
    final userImageDirectory = await Directory('${path.path}/${response?.id}').create(recursive: true);
    final file = File('${userImageDirectory.path}/user.png');
    if (!await file.exists()) {
      final responseImage = await imageService.downloadImage(response?.imageUrl ?? '');
      await file.writeAsBytes(responseImage!);
    }

    final userImageDirectoryItems = await userImageDirectory.list().toList();

    expect(userImageDirectoryItems.isEmpty, false);
  });
}
