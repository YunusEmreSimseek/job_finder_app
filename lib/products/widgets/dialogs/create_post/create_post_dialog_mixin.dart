import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/models/post_model.dart';
import 'package:job_finder_app/products/utilities/enums/work_styles.dart';
import 'package:job_finder_app/products/utilities/mixins/notification_mixin.dart';
import 'package:job_finder_app/products/utilities/mixins/views/post_dialog_mixin.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';
import 'package:job_finder_app/products/widgets/dialogs/create_post/create_post_dialog.dart';
import 'package:logger/logger.dart';

mixin CreatePostDialogMixin on PostDialogMixin<CreatePostDialog>, NotificationMixin<CreatePostDialog> {
  Future<void> getCreatePost() async {
    if (selectedCompany != null &&
        selectedWorkStyle != null &&
        selectedJobSkillsValueNotifier.value.isNotEmpty &&
        workTitleController.text.isNotEmpty &&
        contentController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        pricePerHourController.text.isNotEmpty) {
      final PostModel post = PostModel(
        companyId: selectedCompany!.id,
        content: contentController.text,
        date: DateTime.now(),
        isFullTime: selectedWorkStyle == WorkStyles.FullTime,
        jobSkills: selectedJobSkillsValueNotifier.value.map((e) => e.name).toList(),
        location: locationController.text,
        pricePerHour: pricePerHourController.text,
        title: workTitleController.text,
        userId: context.read<UserCubit>().state.loggedInUser!.id,
      );
      final response = await createPost(post);
      if (response) {
        Logger().i('Post has been created');
        safeOperation(() async {
          Navigator.pop(context);
          showTextDialog('Your post has been created successfully');
        });

        return;
      }
      Logger().e('Ad has not been created');
      safeOperation(() async {
        Navigator.pop(context);
        showTextDialog('Your post has not been created');
      });
      changeLoading();
      return;
    }
    Logger().e('Please fill all fields');
  }
}
