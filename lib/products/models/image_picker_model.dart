import 'package:image_picker/image_picker.dart';

final class ImagePickerModel {
  ImagePickerModel({required this.file, this.status = false});

  final XFile? file;
  final bool status;
}
