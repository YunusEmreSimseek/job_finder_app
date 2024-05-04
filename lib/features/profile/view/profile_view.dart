import 'package:flutter/material.dart';
import 'package:job_finder_app/features/profile/mixin/profile_mixin.dart';
import 'package:job_finder_app/products/enums/font_size.dart';
import 'package:job_finder_app/products/enums/text_field_type.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/image_picker_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/user_mixin.dart';
import 'package:job_finder_app/products/utilities/padding/project_padding.dart';
import 'package:job_finder_app/products/widgets/buttons/general_button.dart';
import 'package:job_finder_app/products/widgets/fields/form_field_with_valid.dart';
import 'package:job_finder_app/products/widgets/loading/loading_without_child.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';
import 'package:kartal/kartal.dart';

final class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with BaseViewMixin, ImageMixin, UserMixin, ProfileMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [LoadingWithoutChild()],
      ),
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

                  // _CompanyDropDownButton(
                  //   selectedCompany: selectedCompany,
                  //   items: items,
                  //   changeCompany: (company) => changeCompany(company),
                  // ),
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
      style: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSize.lowMid.value),
      onTap: () async => await selectDate(context),
      onChanged: (value) => updateBirthdayValue(),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.all(context.border.normalRadius)),
        prefixIcon: const Icon(Icons.calendar_today),
      ),
    );
  }

  InkWell _changeProfilePictureButton(BuildContext context) => InkWell(
      onTap: () async => await changeProfilePicture(), child: GeneralText('Change profile picture', context: context));

  SizedBox _userImage(BuildContext context) {
    return SizedBox(
      height: context.sized.dynamicHeight(.175),
      child: ClipRRect(
        borderRadius: BorderRadius.all(context.border.normalRadius),
        child: Image.network(
          userImageUrl,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.no_photography_outlined),
          height: context.sized.dynamicHeight(.15),
          width: context.sized.dynamicWidth(.5),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  ValueListenableBuilder<bool> _saveButton() {
    return ValueListenableBuilder(
      valueListenable: isProfileChangedNotifier,
      builder: (context, value, child) {
        if (value) {
          return GeneralButton(onPressed: () => saveChanges(), title: 'Kaydet', context: context);
        }
        if (!value) {
          return const SizedBox.shrink();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
