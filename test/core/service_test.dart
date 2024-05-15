import 'package:flutter_test/flutter_test.dart';
import 'package:job_finder_app/products/services/image/download_image_service.dart';
import 'package:vexana/vexana.dart';

void main() {
  late final IImageService imageService;
  const url =
      'https://firebasestorage.googleapis.com/v0/b/jobsearchapp-3da0a.appspot.com/o/User%20Images%2Femre%40test.com-Emre%20%C5%9Eim%C5%9Fek?alt=media&token=be5968bb-2e3b-4eac-8f70-cddaab8dc635';
  setUp(() {
    imageService = ImageService(NetworkManager<EmptyModel>(options: BaseOptions()));
  });
  test('Download Image Test', () async {
    await imageService.downloadImage(url);
  });
}
