import 'package:file_picker/file_picker.dart';
import 'package:job_finder_app/products/services/file/file_picker_service.dart';

final class FilePickerManager {
  late final IFilePickerService _filePickerService;

  FilePickerManager(this._filePickerService);

  Future<FilePickerResult?> pickFile() async {
    final response = await _filePickerService.pickFile();
    return response;
  }
}
