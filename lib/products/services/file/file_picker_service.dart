import 'package:file_picker/file_picker.dart';

abstract class IFilePickerService {
  Future<FilePickerResult?> pickFile();
}

final class FilePickerService implements IFilePickerService {
// Singleton
  static FilePickerService? _instance;
  static FilePickerService get instance {
    _instance ??= FilePickerService._init();
    return _instance!;
  }

  FilePickerService._init();

  @override
  Future<FilePickerResult?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      return result;
    } else {
      return null;
    }
  }
}
