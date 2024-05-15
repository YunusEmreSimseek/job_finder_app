import 'dart:io';

import 'package:flutter/material.dart';
import 'package:job_finder_app/products/utilities/enums/company_text_field_types.dart';
import 'package:job_finder_app/products/utilities/enums/icon_size.dart';
import 'package:job_finder_app/products/utilities/mixins/keyboard_scroll_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/company_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/post_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/widgets/buttons/close_dialog_button.dart';
import 'package:job_finder_app/products/widgets/buttons/general_button.dart';
import 'package:job_finder_app/products/widgets/dialogs/base_dialog.dart';
import 'package:job_finder_app/products/widgets/dialogs/company/add_company_dialog_mixin.dart';
import 'package:job_finder_app/products/widgets/fields/add_company_form_field.dart';
import 'package:job_finder_app/products/widgets/images/user_image_with_radius.dart';
import 'package:job_finder_app/products/widgets/texts/title_text.dart';
import 'package:kartal/kartal.dart';

final class AddCompanyDialog extends StatefulWidget {
  const AddCompanyDialog({super.key});

  static Future<bool> show({
    required BuildContext context,
  }) async {
    await BaseDialog.show<bool>(context: context, builder: (context) => const AddCompanyDialog());
    return true;
  }

  @override
  State<AddCompanyDialog> createState() => _AddCompanyDialogState();
}

class _AddCompanyDialogState extends State<AddCompanyDialog>
    with PostTransactionsMixin, BaseViewMixin, CompanyTransactionsMixin, AddCompanyDialogMixin, KeyboardScrollMixin {
  @override
  Widget build(BuildContext context) {
    scrollToBottomOnKeyboardOpen(context);
    return Center(
      child: SingleChildScrollView(
        controller: scrollController,
        child: AlertDialog(
          titlePadding: context.padding.onlyBottomNormal,
          contentPadding: context.padding.horizontalNormal,
          actionsPadding: context.padding.onlyRightNormal + context.padding.onlyBottomNormal,
          title: Column(
            children: [
              CloseDialogButton(context: context),
              // LargeTitleText('Add Company', context: context),
              TitleText('Add Company', context: context),
            ],
          ),
          content: Column(children: [
            AddCompanyFormField(controller: titleController, type: CompanyTextFieldTypes.title),
            context.sized.emptySizedHeightBoxLow,
            AddCompanyFormField(controller: contenetController, type: CompanyTextFieldTypes.content),
            context.sized.emptySizedHeightBoxLow,
            ValueListenableBuilder(
                valueListenable: imageNotifier,
                builder: (context, value, child) {
                  return IconButton(
                      onPressed: () async => await pickImage(),
                      icon: value == null
                          ? const Icon(Icons.add_a_photo)
                          : SizedBox(
                              height: context.sized.dynamicHeight(.1),
                              child: UserImageWithRadius.file(file: File(value.path), context: context)),
                      iconSize: IconSize.high.value);
                })
          ]),
          actions: [
            GeneralButton(onPressed: () async => await addCompany(), title: 'Add', context: context),
          ],
        ),
      ),
    );
  }
}
