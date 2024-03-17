// import 'package:flutter/material.dart';
// import 'package:job_finder_app/features/job_detail/view/job_detail_view.dart';
// import 'package:job_finder_app/products/models/post_model.dart';
// import 'package:job_finder_app/products/models/user_model.dart';
// import 'package:job_finder_app/products/services/user/user_service.dart';
// import 'package:job_finder_app/products/utilities/mixins/base_view_mixin.dart';
// import 'package:logger/logger.dart';

// mixin JobDetailMixin on State<JobDetailView>, BaseViewMixin<JobDetailView> {
//   late final UserModel user;
//   late final PostModel job;
//   late final IUserService _userService;

//   @override
//   void initState() {
//     super.initState();
//     _userService = UserService();
//     job = widget.post;
//     fetchUserFromJob();
//   }

//   Future<void> fetchUserFromJob() async {
//     final response = await _userService.getUserById(job.ownerId);
//     if (response == null) {
//       Logger().e('User not found');
//       return;
//     }
//     user = response;
//   }
// }
