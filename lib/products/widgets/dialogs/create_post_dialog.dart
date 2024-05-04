import 'package:flutter/material.dart';
import 'package:job_finder_app/products/constants/string_constant.dart';
import 'package:job_finder_app/products/enums/create_ad_text_field_type.dart';
import 'package:job_finder_app/products/enums/job_skills.dart';
import 'package:job_finder_app/products/enums/work_styles.dart';
import 'package:job_finder_app/products/models/company_model.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/create_post_dialog_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/post_dialog_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/post_mixin.dart';
import 'package:job_finder_app/products/widgets/dialogs/base_dialog.dart';
import 'package:job_finder_app/products/widgets/dialogs/post_dialog.dart';
import 'package:job_finder_app/products/widgets/fields/dropdown_form_field.dart';
import 'package:job_finder_app/products/widgets/fields/post_form_field.dart';
import 'package:kartal/kartal.dart';

final class CreatePostDialog extends StatefulWidget {
  const CreatePostDialog({super.key});

  static Future<bool> show({required BuildContext context}) async {
    await BaseDialog.show<bool>(
      context: context,
      builder: (context) => const CreatePostDialog(),
    );
    return true;
  }

  @override
  State<CreatePostDialog> createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog>
    with BaseViewMixin, PostMixin, PostDialogMixin, CreatePostDialogMixin {
  @override
  Widget build(BuildContext context) {
    return PostDialog(
      title: StringConstant.createPostTitle,
      onPressed: () => getCreatePost(),
      buttonTitle: 'Create',
      items: Column(children: [
        ValueListenableBuilder(
          valueListenable: companyItemsValueNotifier,
          builder: (context, value, child) => DropDownFormField<CompanyModel>(
              items: value,
              onChanged: (value) => changeSelectedCompany(value),
              hintText: 'Company',
              prefixIcon: const Icon(Icons.business)),
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
                onChanged: (value) => changeSelectedWorkStyle(value),
                hintText: 'Working Style',
                prefixIcon: const Icon(Icons.workspaces_sharp))),
        context.sized.emptySizedHeightBoxLow,
        PostFormField(controller: locationController, type: CreateAdTextFieldType.location),
        context.sized.emptySizedHeightBoxLow,
        ValueListenableBuilder(
            valueListenable: jobSkillItems,
            builder: (context, value, child) => DropDownFormField<JobSkills>(
                items: value,
                onChanged: (value) => onChangedJobSkills(value),
                hintText: 'Job Skills',
                prefixIcon: const Icon(Icons.workspace_premium))),
        context.sized.emptySizedHeightBoxLow,
        PostFormField(controller: contentController, type: CreateAdTextFieldType.content),
      ]),
    );
  }
}
