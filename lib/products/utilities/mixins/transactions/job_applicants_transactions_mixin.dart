import 'package:job_finder_app/products/models/job_applicants_model.dart';
import 'package:job_finder_app/products/models/post_model.dart';
import 'package:job_finder_app/products/services/post/post_manager.dart';
import 'package:job_finder_app/products/services/queries/get_user_by_id_query.dart';
import 'package:job_finder_app/products/services/user/user_manager.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';
import 'package:job_finder_app/products/view_models/job_applicants_view_model.dart';
import 'package:logger/logger.dart';

mixin JobApplicantsTransactionsMixin {
  late final UserManager userServiceManager = UserManager(UserService.instance);
  late final PostManager postServiceManager = PostManager(PostService.instance);

  Future<JobApplicantsViewModel> toJobApplicantsViewModel(JobApplicantsModel jobApplicantsModel) async {
    final query = GetUserByIdQuery(jobApplicantsModel.userId!);
    final user = await userServiceManager.getUserById(query);
    if (user == null) throw Exception('User not found');
    return JobApplicantsViewModel(user: user, cvUrl: jobApplicantsModel.cvUrl!);
  }

  Future<void> getAddApplicants({required PostModel post, required String cvUrl}) async {
    final JobApplicantsModel jobApplicant = JobApplicantsModel(
      userId: UserCubit.instance.state.loggedInUser!.id,
      cvUrl: cvUrl,
    );
    if (post.jobApplicants == null) {
      final newPost = post.copyWith(jobApplicants: [jobApplicant]);
      await postServiceManager.updatePost(newPost);
      return;
    }
    post.jobApplicants!.add(jobApplicant);
    await postServiceManager.updatePost(post);
    return;
  }

  Future<void> getRemoveApplicants({required PostModel post, required String cvUrl}) async {
    if (post.jobApplicants == null) {
      Logger().d('No applicants found');
      return;
    }
    post.jobApplicants!.removeWhere((element) => element.cvUrl == cvUrl);
    await postServiceManager.updatePost(post);
    Logger().d('Applicants removed');
  }
}
