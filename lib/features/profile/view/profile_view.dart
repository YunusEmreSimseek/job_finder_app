import 'dart:io';

import 'package:flutter/material.dart';
import 'package:job_finder_app/features/profile/mixin/profile_mixin.dart';
import 'package:job_finder_app/products/utilities/constants/string_constant.dart';
import 'package:job_finder_app/products/utilities/enums/auth_text_field_type.dart';
import 'package:job_finder_app/products/utilities/enums/font_size.dart';
import 'package:job_finder_app/products/utilities/enums/icon_size.dart';
import 'package:job_finder_app/products/utilities/mixins/keyboard_scroll_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/notification_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/image_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/post_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/user_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/padding/project_padding.dart';
import 'package:job_finder_app/products/widgets/buttons/general_button.dart';
import 'package:job_finder_app/products/widgets/core/app_bar_with_title.dart';
import 'package:job_finder_app/products/widgets/fields/form_field_with_valid.dart';
import 'package:job_finder_app/products/widgets/images/user_image_with_radius.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';
import 'package:kartal/kartal.dart';

final class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with
        PostTransactionsMixin,
        BaseViewMixin,
        ImageTransactionsMixin,
        UserTransactionMixin,
        KeyboardScrollMixin,
        NotificationMixin,
        ProfileMixin {
  @override
  Widget build(BuildContext context) {
    scrollToBottomOnKeyboardOpen(context);
    return Scaffold(
      appBar: AppBarWithTitle.onlyTitle(context: context, titleText: StringConstant.profile),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Form(
          key: formKey,
          onChanged: () => compareUserDetailsWithState(),
          child: Padding(
            padding: ProjectPadding.allNormalDynamic(context),
            child: Center(
              child: Column(
                children: [
                  _userImage(context),
                  context.sized.emptySizedHeightBoxLow3x,
                  _changeProfilePictureButton(context),
                  context.sized.emptySizedHeightBoxNormal,
                  FormFieldWithValid(controller: nameController, type: AuthTextFieldType.name),
                  context.sized.emptySizedHeightBoxLow,
                  FormFieldWithValid(controller: phoneNumberController, type: AuthTextFieldType.phone),
                  context.sized.emptySizedHeightBoxLow,
                  _birthdayField(context),
                  context.sized.emptySizedHeightBoxLow,
                  FormFieldWithValid(controller: emailController, type: AuthTextFieldType.email),
                  context.sized.emptySizedHeightBoxLow,
                  FormFieldWithValid(controller: passwordController, type: AuthTextFieldType.password),
                  context.sized.emptySizedHeightBoxNormal,
                  _saveButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _birthdayField(BuildContext context) {
    return TextFormField(
      controller: birthdayController,
      style: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSizes.low.value),
      onTap: () async => await selectDate(context),
      onChanged: (value) => updateBirthdayValue(),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.all(context.border.normalRadius)),
        prefixIcon: Icon(
          Icons.calendar_today,
          size: IconSize.low.value,
        ),
      ),
    );
  }

  InkWell _changeProfilePictureButton(BuildContext context) => InkWell(
        onTap: () async => await changeProfilePicture(),
        // child: GeneralText('Change profile picture', context: context),
        child: GeneralText('Change profile picture', context: context),
      );

  SizedBox _userImage(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(.2),
      child: ValueListenableBuilder(
        valueListenable: userImageFile,
        builder: (context, value, child) {
          if (value != null) {
            final File file = File(value.path);
            return UserImageWithRadius.file(file: file, context: context);
          }
          return UserImageWithRadius.network(imageUrl: loggedInUser.imageUrl, context: context);
        },
      ),
    );
  }

  ValueListenableBuilder<bool> _saveButton() {
    return ValueListenableBuilder(
      valueListenable: isProfileChangedNotifier,
      builder: (context, value, child) {
        if (value) {
          return GeneralButton(onPressed: () => saveChanges(), title: 'Save Changes', context: context);
        }
        if (!value) {
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
