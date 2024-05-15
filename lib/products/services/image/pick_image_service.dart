import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

abstract class IPickImageService {
  Future<XFile?> pickImageFromGallery();
}

final class PickImageService implements IPickImageService {
  static PickImageService? _instance;
  static PickImageService get instance {
    _instance ??= PickImageService._init();
    return _instance!;
  }

  PickImageService._init();
  final ImagePicker _picker = ImagePicker();

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
}
