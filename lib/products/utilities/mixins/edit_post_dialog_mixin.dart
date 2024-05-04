import 'package:flutter/material.dart';
import 'package:job_finder_app/products/enums/job_skills.dart';
import 'package:job_finder_app/products/enums/work_styles.dart';
import 'package:job_finder_app/products/models/post_model.dart';
import 'package:job_finder_app/products/utilities/mixins/post_dialog_mixin.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';
import 'package:job_finder_app/products/widgets/dialogs/edit_post_dialog.dart';
import 'package:logger/logger.dart';

mixin EditPostDialogMixin on PostDialogMixin<EditPostDialog> {
  @override
  void initState() {
    super.initState();
    setPostItems();
  }

  void setPostItems() {
    workTitleController.text = widget.post.title!;
    contentController.text = widget.post.content!;
    locationController.text = widget.post.location!;
    pricePerHourController.text = widget.post.pricePerHour!;
    selectedCompany = widget.post.company;
    companyItemsValueNotifier.value = [DropdownMenuItem(value: selectedCompany, child: Text(selectedCompany!.title!))];
    selectedWorkStyle = widget.post.isFullTime! ? WorkStyles.FullTime : WorkStyles.PartTime;
    selectedJobSkillsValueNotifier.value =
        widget.post.jobSkills!.map((e) => JobSkills.values.firstWhere((element) => element == e)).toList();
    mapJobSkillsToDropDownItems();
  }

  Future<void> saveChanges() async {
    final oldPost = widget.post.toPostModel();
    final PostModel newPost = PostModel(
      id: oldPost.id,
      date: oldPost.date,
      usersWhoAddedFavourites: oldPost.usersWhoAddedFavourites,
      companyId: selectedCompany!.id,
      content: contentController.text,
      isFullTime: selectedWorkStyle == WorkStyles.FullTime,
      jobSkills: selectedJobSkillsValueNotifier.value.map((e) => e.name).toList(),
      location: locationController.text,
      pricePerHour: pricePerHourController.text,
      title: workTitleController.text,
      userId: getCubit<UserCubit>().state.loggedInUser!.id,
    );
    if (widget.post.toPostModel() == newPost) return;
    await updatePost(newPost);
    Logger().i('Ad has been updated');
  }
}
