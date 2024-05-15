import 'package:flutter/material.dart';
import 'package:job_finder_app/products/models/post_model.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/job_applicants_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/post_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/view_models/job_applicants_view_model.dart';
import 'package:job_finder_app/products/widgets/buttons/close_dialog_button.dart';
import 'package:job_finder_app/products/widgets/dialogs/applicants/applicants_dialog_mixin.dart';
import 'package:job_finder_app/products/widgets/dialogs/base_dialog.dart';
import 'package:job_finder_app/products/widgets/dialogs/user/user_dialog.dart';
import 'package:job_finder_app/products/widgets/images/user_image_with_radius.dart';
import 'package:job_finder_app/products/widgets/texts/extra_small_text.dart';
import 'package:job_finder_app/products/widgets/texts/semi_title_text.dart';
import 'package:job_finder_app/products/widgets/texts/title_text.dart';
import 'package:kartal/kartal.dart';

final class ApplicantsDialog extends StatefulWidget {
  ApplicantsDialog({super.key, required this.jobApplicants, required this.post})
      : jobApplicantsNotifier = ValueNotifier(jobApplicants);
  final PostModel post;
  final List<JobApplicantsViewModel>? jobApplicants;
  final ValueNotifier<List<JobApplicantsViewModel>?> jobApplicantsNotifier;

  static Future<bool> show(
      {required BuildContext context,
      required List<JobApplicantsViewModel>? jobApplicants,
      required PostModel post}) async {
    await BaseDialog.show<bool>(
        context: context,
        builder: (context) => ApplicantsDialog(
              jobApplicants: jobApplicants,
              post: post,
            ),
        barrierDismissible: true);
    return true;
  }

  @override
  State<ApplicantsDialog> createState() => _ApplicantsDialogState();
}

class _ApplicantsDialogState extends State<ApplicantsDialog>
    with PostTransactionsMixin, BaseViewMixin, JobApplicantsTransactionsMixin, ApplicantsDialogMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          titlePadding: EdgeInsets.zero,
          contentPadding: context.padding.low,
          title: Column(
            children: [
              CloseDialogButton(context: context),
              // LargeTitleText('Applicants', context: context),
              TitleText('Applicants', context: context),
            ],
          ),
          content: SizedBox(
              height: context.sized.dynamicHeight(.53),
              width: context.sized.dynamicWidth(.7),
              child: ValueListenableBuilder(
                valueListenable: widget.jobApplicantsNotifier,
                builder: (context, value, child) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: value?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      final currentItem = value![index];
                      return InkWell(
                        onTap: () async => UserDialog.show(context: context, user: currentItem.user),
                        child: Card(
                            child: Padding(
                          padding: context.padding.low,
                          child: SizedBox(
                            height: context.sized.dynamicHeight(.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: context.sized.dynamicHeight(.08),
                                    width: context.sized.dynamicWidth(.15),
                                    child: UserImageWithRadius.network(
                                        imageUrl: currentItem.user.imageUrl, context: context)),
                                context.sized.emptySizedWidthBoxLow3x,
                                SizedBox(
                                  width: context.sized.dynamicWidth(.275),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      context.sized.emptySizedHeightBoxLow,
                                      // GeneralBoldText(currentItem.user.name ?? '', context: context),
                                      SemiTitleText(currentItem.user.name ?? '', context: context, maxLines: 1),
                                      context.sized.emptySizedHeightBoxLow,
                                      // Text(currentItem.user.email ?? ''),
                                      ExtraSmallText(
                                        currentItem.user.email ?? '',
                                        context: context,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    InkWell(
                                        onTap: () async => removeApplicants(currentItem),
                                        child: const Icon(Icons.cancel)),
                                    context.sized.emptySizedHeightBoxLow,
                                    context.sized.emptySizedHeightBoxLow,
                                    InkWell(
                                        onTap: () async => downloadAndSavePdf(currentItem),
                                        child: const Icon(
                                          Icons.picture_as_pdf,
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                      );
                    },
                  );
                },
              )),
        ),
      ),
    );
  }
}
