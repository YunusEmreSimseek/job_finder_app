import 'package:equatable/equatable.dart';
import 'package:job_finder_app/products/models/base_firebase_model.dart';

final class JobApplicantsModel with EquatableMixin, IdModel, BaseFirebaseModel<JobApplicantsModel> {
  final String? userId;
  final String? cvUrl;
  @override
  final String? id;

  JobApplicantsModel({this.userId, this.cvUrl, this.id});

  JobApplicantsModel copyWith({String? userId, String? cvUrl, String? id}) {
    return JobApplicantsModel(
      userId: userId ?? this.userId,
      cvUrl: cvUrl ?? this.cvUrl,
      id: id ?? this.id,
    );
  }

  @override
  JobApplicantsModel fromJson(Map<String, dynamic> json) {
    return JobApplicantsModel(
      userId: json['userId'] as String,
      cvUrl: json['cvUrl'] as String,
    );
  }

  @override
  List<Object?> get props => [userId, cvUrl, id];

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'cvUrl': cvUrl,
    };
  }
}
