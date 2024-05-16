import 'package:file_picker/file_picker.dart';
import 'package:job_finder_app/features/job_detail/view/job_detail_view.dart';
import 'package:job_finder_app/products/models/job_applicants_model.dart';
import 'package:job_finder_app/products/services/file/file_picker_manager.dart';
import 'package:job_finder_app/products/services/file/file_picker_service.dart';
import 'package:job_finder_app/products/services/firebase/firebase_storage_manager.dart';
import 'package:job_finder_app/products/services/firebase/firebase_storage_service.dart';
import 'package:job_finder_app/products/services/post/post_manager.dart';
import 'package:job_finder_app/products/utilities/enums/firebase_storage_paths.dart';
import 'package:job_finder_app/products/utilities/mixins/notification_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';
import 'package:logger/logger.dart';

mixin JobDetailMixin on BaseViewMixin<JobDetailView>, NotificationMixin<JobDetailView> {
  late final FilePickerManager _filePickerManager;
  late final FirebaseStorageManager _firebaseStorageManager;
  late final PostManager _postServiceManager;

  @override
  void initState() {
    super.initState();
    _filePickerManager = FilePickerManager(FilePickerService.instance);
    _firebaseStorageManager = FirebaseStorageManager(FirebaseStorageService.instance);
    _postServiceManager = PostManager(PostService.instance);
  }

  Future<bool> checkApply() async {
    final post = await _postServiceManager.getPostById(widget.post.id!);
    if (post == null || post.jobApplicants == null || post.jobApplicants!.isEmpty) return false;
    final userId = getCubit<UserCubit>().state.loggedInUser!.id;
    final isContain = post.jobApplicants!.any((element) => element.userId == userId);
    return isContain;
  }

  Future<void> applyToJob() async {
    changeLoading();
    final isContain = await checkApply();
    if (isContain) {
      Logger().i('Already applied');
      changeLoading();
      showTextDialog('You have already applied to this job');
      return;
    }
    final result = await pickItem();
    if (result != null) {
      final cvUrl = await uploadToStorage(result);
      if (cvUrl != null) {
        Logger().i('File uploaded');
        await updateJobApplicantsOfPost(cvUrl);
        changeLoading();
        showTextDialog('You have successfully applied to this job');
        return;
      }
      Logger().e('File not uploaded');
      changeLoading();
      showTextDialog('File can not uploaded');

      return;
    }
    Logger().e('No file picked');
    changeLoading();
  }

  Future<FilePickerResult?> pickItem() async {
    final response = await _filePickerManager.pickFile();
    return response;
  }

  Future<String?> uploadToStorage(FilePickerResult? result) async {
    if (result != null) {
      final fileBytes = await result.files.single.xFile.readAsBytes();
      String fileName = result.files.first.name;
      final cvUrl = await _firebaseStorageManager.uploadFile(
          file: fileBytes, fileName: fileName, path: FirebaseStoragePaths.files);
      return cvUrl;
    }
    return null;
  }

  Future<void> updateJobApplicantsOfPost(String cvUrl) async {
    final JobApplicantsModel jobApplicant = JobApplicantsModel(
      userId: getCubit<UserCubit>().state.loggedInUser!.id,
      cvUrl: cvUrl,
    );
    final post = widget.post.toPostModel();
    if (post.jobApplicants == null) {
      final newPost = post.copyWith(jobApplicants: [jobApplicant]);
      await _postServiceManager.updatePost(newPost);
      return;
    }
    post.jobApplicants!.add(jobApplicant);
    await _postServiceManager.updatePost(post);
    return;
  }
}
