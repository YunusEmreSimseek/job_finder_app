import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_finder_app/products/services/cache/cache_manager.dart';
import 'package:job_finder_app/products/services/cache/cache_service.dart';
import 'package:job_finder_app/products/services/file/file_picker_manager.dart';
import 'package:job_finder_app/products/services/file/file_picker_service.dart';
import 'package:logger/logger.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'mock_path.dart';

void main() {
  late final FilePickerManager filePickerManager;
  late final CacheManager cacheManager;
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    filePickerManager = FilePickerManager(FilePickerService.instance);
    cacheManager = CacheManager(CacheService.instance);
    PathProviderPlatform.instance = MockPathProviderPlatform();
  });
  test('Sample File Pick Test', () async {
    final response = await filePickerManager.pickFile();
    expect(response, isNotNull);
  });

  test('Pick File And Save To Downloads Path', () async {
    FilePickerResult? result = await filePickerManager.pickFile();
    if (result != null) {
      final fileBytes = await result.files.single.xFile.readAsBytes();
      String fileName = result.files.first.name;
      final mainPath = await cacheManager.getDownloadsPath();
      final path = '$mainPath/$fileName';
      Logger().i(path);
      await cacheManager.savePdf(pdf: fileBytes, path: path);
    }
  });
}
