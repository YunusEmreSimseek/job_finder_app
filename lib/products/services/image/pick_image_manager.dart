import 'package:image_picker/image_picker.dart';
import 'package:job_finder_app/products/services/image/pick_image_service.dart';

final class PickImageManager {
  late final IPickImageService _pickImageService;
  PickImageManager(this._pickImageService);

  Future<XFile?> pickImageFromGallery() async => await _pickImageService.pickImageFromGallery();
}
