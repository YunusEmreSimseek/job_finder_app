import 'package:logger/logger.dart';
import 'package:vexana/vexana.dart';

abstract class IImageService {
  Future<List<int>?> downloadImage(String url);
}

final class ImageService implements IImageService {
  late final INetworkManager imageManager;

  ImageService(this.imageManager);

  @override
  Future<List<int>?> downloadImage(String url) async {
    final response = await imageManager.downloadFileSimple(url, null);
    if (response.data != null) {
      Logger().i('image found : ${response.data?.length}');
      return response.data;
    }
    Logger().i('image not found');
    return null;
  }
}
