import 'package:job_finder_app/products/models/user_model.dart';

final class JobApplicantsViewModel {
  final UserModel user;
  final String cvUrl;

  JobApplicantsViewModel({required this.user, required this.cvUrl});
}
