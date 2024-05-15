import 'package:flutter/material.dart';
import 'package:job_finder_app/products/models/user_model.dart';
import 'package:job_finder_app/products/utilities/extensions/date_to_string_extension.dart';
import 'package:job_finder_app/products/widgets/buttons/close_dialog_button.dart';
import 'package:job_finder_app/products/widgets/dialogs/base_dialog.dart';
import 'package:job_finder_app/products/widgets/images/user_image_with_radius.dart';
import 'package:job_finder_app/products/widgets/texts/general_text.dart';
import 'package:job_finder_app/products/widgets/texts/semi_title_text.dart';
import 'package:kartal/kartal.dart';

final class UserDialog extends StatefulWidget {
  const UserDialog({super.key, required this.user});
  final UserModel user;

  static Future<bool> show({required BuildContext context, required UserModel user}) async {
    await BaseDialog.show<bool>(
        context: context, builder: (context) => UserDialog(user: user), barrierDismissible: true);
    return true;
  }

  @override
  State<UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        titlePadding: EdgeInsets.zero,
        title: Column(
          children: [
            CloseDialogButton(context: context),
            SemiTitleText(widget.user.name ?? '', context: context),
          ],
        ),
        content: SizedBox(
          height: context.sized.dynamicHeight(.35),
          child: Column(
            children: [
              SizedBox(
                  height: context.sized.dynamicHeight(.2),
                  width: context.sized.dynamicWidth(.5),
                  child: UserImageWithRadius.network(imageUrl: widget.user.imageUrl, context: context)),
              context.sized.emptySizedHeightBoxLow3x,
              _userFieldRow(context: context, hintText: 'Email:', value: widget.user.email),
              context.sized.emptySizedHeightBoxLow,
              _userFieldRow(context: context, hintText: 'Phone:', value: widget.user.phoneNo),
              context.sized.emptySizedHeightBoxLow,
              _userFieldRow(context: context, hintText: 'Birthday:', value: widget.user.birthday?.toDateString()),
              context.sized.emptySizedHeightBoxLow,
            ],
          ),
        ),
      ),
    );
  }

  Row _userFieldRow({required BuildContext context, required String hintText, required String? value}) {
    return Row(
      children: [
        SizedBox(
          width: context.sized.dynamicWidth(.17),
          child: Align(alignment: Alignment.center, child: GeneralText(hintText, context: context)),
        ),
        context.sized.emptySizedWidthBoxLow,
        GeneralText(value ?? '', context: context),
      ],
    );
  }
}
