import 'package:flutter/material.dart';
import 'package:job_finder_app/features/settings/mixin/settings_mixin.dart';
import 'package:job_finder_app/products/utilities/constants/string_constant.dart';
import 'package:job_finder_app/products/utilities/mixins/transactions/post_transactions_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/padding/project_padding.dart';
import 'package:job_finder_app/products/widgets/buttons/general_button.dart';
import 'package:job_finder_app/products/widgets/buttons/settings_item_button.dart';
import 'package:job_finder_app/products/widgets/buttons/settings_item_profile_button.dart';
import 'package:job_finder_app/products/widgets/core/app_bar_with_title.dart';
import 'package:kartal/kartal.dart';

final class SettingsView extends StatefulWidget {
  const SettingsView({super.key});
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with PostTransactionsMixin, BaseViewMixin, SettingsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithTitle.onlyTitle(context: context, titleText: StringConstant.settings),
      body: SingleChildScrollView(
        child: Padding(
          padding: ProjectPadding.allNormalDynamic(context),
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: imageUrlNotifier,
                builder: (context, value, child) {
                  return SettingsItemProfileButton(context: context, imageUrl: value, title: 'Account');
                },
              ),
              context.sized.emptySizedHeightBoxNormal,
              SettingsItemButton(
                context: context,
                title: 'Add Company',
                onTap: () => navigateToAddCompany(),
              ),
              context.sized.emptySizedHeightBoxLow,
              SettingsItemButton(context: context, title: 'Privacy'),
              context.sized.emptySizedHeightBoxLow,
              SettingsItemButton(context: context, title: 'Security'),
              context.sized.emptySizedHeightBoxLow,
              SettingsItemButton(context: context, title: 'Language'),
              context.sized.emptySizedHeightBoxLow3x,
              GeneralButton(onPressed: () => signOut(), title: 'Sign Out', context: context),
            ],
          ),
        ),
      ),
    );
  }
}
