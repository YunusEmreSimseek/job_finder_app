import 'package:job_finder_app/products/enums/job_skills.dart';
import 'package:job_finder_app/products/models/company_model.dart';
import 'package:job_finder_app/products/models/post_model.dart';
import 'package:job_finder_app/products/models/user_model.dart';

final class PostViewModel {
  final String? id;
  final String? title;
  final String? content;
  final DateTime? date;
  final String? location;
  final String? pricePerHour;
  final bool? isFullTime;
  final List<JobSkills>? jobSkills;
  final List<UserModel?>? usersWhoAddedFavourites;
  final CompanyModel? company;
  final UserModel? user;

  PostViewModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.location,
    required this.pricePerHour,
    required this.isFullTime,
    required this.jobSkills,
    required this.company,
    required this.user,
    required this.usersWhoAddedFavourites,
  });

  PostModel toPostModel() {
    return PostModel(
      id: id,
      companyId: company!.id,
      userId: user!.id,
      title: title,
      content: content,
      date: date,
      location: location,
      pricePerHour: pricePerHour,
      isFullTime: isFullTime,
      jobSkills: jobSkills?.map((e) => e.name.toString()).toList(),
      usersWhoAddedFavourites: usersWhoAddedFavourites?.map((e) => e!.id!).toList(),
    );
  }

  String toWorkStyle() {
    switch (isFullTime) {
      case true:
        return 'Full Time';
      case false:
        return 'Part Time';
      default:
        return '';
    }
  }
}
