import 'dart:io';

import 'package:job_finder_app/features/pdf/view/pdf_view.dart';
import 'package:job_finder_app/products/models/user_model.dart';
import 'package:job_finder_app/products/services/cache/cache_manager.dart';
import 'package:job_finder_app/products/services/cache/cache_service.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/job_applicants_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/view_models/job_applicants_view_model.dart';
import 'package:job_finder_app/products/widgets/dialogs/applicants/applicants_dialog.dart';
import 'package:job_finder_app/products/widgets/dialogs/question_dialog.dart';
import 'package:job_finder_app/products/widgets/dialogs/text_dialog.dart';
import 'package:job_finder_app/products/widgets/dialogs/user/user_dialog.dart';
import 'package:kartal/kartal.dart';
import 'package:logger/logger.dart';
import 'package:vexana/vexana.dart';

mixin ApplicantsDialogMixin on BaseViewMixin<ApplicantsDialog>, JobApplicantsTransactionsMixin {
  late final INetworkManager _downloadManager;
  late final CacheManager _cacheManager;

  @override
  void initState() {
    super.initState();
    _downloadManager = NetworkManager<EmptyModel>(options: BaseOptions());
    _cacheManager = CacheManager(CacheService.instance);
  }

  Future<bool> checkPdf(String path) async {
    final file = File(path);
    bool fileExist = await file.exists();
    return fileExist;
  }

  Future<List<int>?> downloadPdf(String url) async {
    final response = await _downloadManager.downloadFileSimple(url, null);
    return response.data;
  }

  Future<void> downloadAndSavePdf(JobApplicantsViewModel applicant) async {
    final cvUrl = applicant.cvUrl;
    final fileName = '${applicant.user.email}_${applicant.user.name}';
    final basePath = await _cacheManager.getDocumentsPath();
    final path = '$basePath/$fileName.pdf';
    final fileExist = await checkPdf(path);
    if (fileExist) {
      Logger().d('File exist');
      safeOperation(() async => openPdf(path));
      return;
    }
    final pdf = await downloadPdf(cvUrl);
    if (pdf == null) {
      safeOperation(() => TextDialog.show(context: context, text: 'Pdf download failed'));
      return;
    }
    Logger().d('Pdf downloaded');
    await savePdf(pdf: pdf, path: path);
    safeOperation(() async => openPdf(path));
  }

  Future<String> savePdf({required List<int>? pdf, required String path}) async {
    final file = File(path);
    final response = await file.writeAsBytes(pdf!);
    return response.path;
  }

  void openPdf(String path) {
    safeOperation(() => context.route.navigateToPage(PdfView(
          path: path,
        )));
  }

  Future<void> removeApplicants(JobApplicantsViewModel applicant) async {
    final cvUrl = applicant.cvUrl;
    final fileName = '${applicant.user.email}_${applicant.user.name}';
    final response = await QuestionDialog.show(context: context, question: 'Are you sure to remove applicants?');
    if (!response) return;
    await getRemoveApplicants(post: widget.post, cvUrl: cvUrl);
    final basePath = await _cacheManager.getDocumentsPath();
    final path = '$basePath/$fileName.pdf';
    final fileExist = await checkPdf(path);
    if (fileExist) {
      Logger().d('File exist');
      await File(path).delete();
    }
    final list = widget.jobApplicantsNotifier.value;
    list?.removeWhere((element) => element == applicant);
    widget.jobApplicantsNotifier.value = List.from(list!);

    safeOperation(() => TextDialog.show(context: context, text: 'The applicant has been removed'));
  }

  Future<void> navigateToUserDialog(UserModel user) async {
    await UserDialog.show(context: context, user: user);
  }
}
