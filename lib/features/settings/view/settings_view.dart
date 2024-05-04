import 'package:flutter/material.dart';
import 'package:job_finder_app/features/profile/view/profile_view.dart';
import 'package:job_finder_app/features/settings/mixin/settings_mixin.dart';
import 'package:job_finder_app/products/constants/string_constant.dart';
import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
import 'package:job_finder_app/products/utilities/padding/project_padding.dart';
import 'package:job_finder_app/products/widgets/buttons/general_button.dart';
import 'package:job_finder_app/products/widgets/buttons/settings_item_button.dart';
import 'package:job_finder_app/products/widgets/loading/loading_without_child.dart';
import 'package:job_finder_app/products/widgets/texts/app_bar_title_text.dart';
import 'package:kartal/kartal.dart';

final class SettingsView extends StatefulWidget {
  const SettingsView({super.key});
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> with BaseViewMixin, SettingsMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitleText(StringConstant.settings, context: context),
        actions: const [LoadingWithoutChild()],
      ),
      body: Padding(
        padding: ProjectPadding.allNormalDynamic(context),
        child: Column(
          children: [
            context.sized.emptySizedHeightBoxNormal,
            SettingsItemButton(
              context: context,
              title: 'Account',
              imageUrl: 'assets/icons/ic_user.png',
              onTap: () => context.route.navigateToPage(const ProfileView()),
            ),
            context.sized.emptySizedHeightBoxNormal,
            SettingsItemButton(context: context, title: 'Notification'),
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
    );
  }
}
