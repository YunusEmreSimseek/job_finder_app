import 'package:flutter/material.dart';
import 'package:job_finder_app/products/models/company_model.dart';
import 'package:job_finder_app/products/utilities/constants/string_constant.dart';
import 'package:job_finder_app/products/utilities/enums/create_ad_text_field_type.dart';
import 'package:job_finder_app/products/utilities/enums/job_skills.dart';
import 'package:job_finder_app/products/utilities/enums/work_styles.dart';
import 'package:job_finder_app/products/utilities/mixins/notification_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/post_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/post_dialog_mixin.dart';
import 'package:job_finder_app/products/view_models/post_view_model.dart';
import 'package:job_finder_app/products/widgets/dialogs/base_dialog.dart';
import 'package:job_finder_app/products/widgets/dialogs/edit_post/edit_post_dialog_mixin.dart';
import 'package:job_finder_app/products/widgets/dialogs/post_dialog.dart';
import 'package:job_finder_app/products/widgets/fields/dropdown_form_field.dart';
import 'package:job_finder_app/products/widgets/fields/post_form_field.dart';
import 'package:kartal/kartal.dart';

final class EditPostDialog extends StatefulWidget {
  const EditPostDialog({super.key, required this.post});
  final PostViewModel post;

  static Future<bool> show({required BuildContext context, required PostViewModel post}) async {
    await BaseDialog.show<bool>(
      context: context,
      builder: (context) => EditPostDialog(
        post: post,
      ),
    );
    return true;
  }

  @override
  State<EditPostDialog> createState() => _EditPostDialogState();
}

class _EditPostDialogState extends State<EditPostDialog>
    with PostTransactionsMixin, BaseViewMixin, PostDialogMixin, NotificationMixin, EditPostDialogMixin {
  @override
  Widget build(BuildContext context) {
    return PostDialog(
      title: StringConstant.editPostTite,
      onPressed: () => saveChanges(),
      buttonTitle: 'Save Changes',
      post: widget.post,
      items: Column(children: [
        ValueListenableBuilder(
          valueListenable: companyItemsValueNotifier,
          builder: (context, value, child) => DropDownFormField<CompanyModel>(
              items: value,
              value: selectedCompany,
              onChanged: (value) => changeSelectedCompany(value),
              hintText: 'Company',
              prefixIconData: Icons.business),
        ),
        context.sized.emptySizedHeightBoxLow,
        PostFormField(controller: workTitleController, type: CreateAdTextFieldType.workTitle),
        context.sized.emptySizedHeightBoxLow,
        PostFormField(controller: pricePerHourController, type: CreateAdTextFieldType.pricePerHour),
        context.sized.emptySizedHeightBoxLow,
        ValueListenableBuilder(
            valueListenable: workStylesValueNotifier,
            builder: (context, value, child) => DropDownFormField<WorkStyles>(
                items: value,
                value: selectedWorkStyle,
                onChanged: (value) => changeSelectedWorkStyle(value),
                hintText: 'Working Style',
                prefixIconData: Icons.workspaces_sharp)),
        context.sized.emptySizedHeightBoxLow,
        PostFormField(controller: locationController, type: CreateAdTextFieldType.location),
        context.sized.emptySizedHeightBoxLow,
        ValueListenableBuilder(
            valueListenable: jobSkillItems,
            builder: (context, value, child) => DropDownFormField<JobSkills>(
                items: value,
                value: selectedJobSkillsValueNotifier.value.firstOrNull,
                onChanged: (value) => onChangedJobSkills(value),
                hintText: 'Job Skills',
                prefixIconData: Icons.workspace_premium)),
        context.sized.emptySizedHeightBoxLow,
        PostFormField(controller: contentController, type: CreateAdTextFieldType.content),
      ]),
    );
  }
}
