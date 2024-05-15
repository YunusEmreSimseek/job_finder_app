import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:job_finder_app/products/models/base_firebase_model.dart';
import 'package:job_finder_app/products/models/job_applicants_model.dart';

final class PostModel with EquatableMixin, IdModel, BaseFirebaseModel<PostModel> {
  final String? companyId;
  final String? userId;
  final String? title;
  final String? content;
  final DateTime? date;
  final String? location;
  final String? pricePerHour;
  final bool? isFullTime;
  final List<String>? jobSkills;
  final List<String>? usersWhoAddedFavourites;
  final List<JobApplicantsModel>? jobApplicants;
  @override
  final String? id;

  const PostModel({
    this.id,
    this.companyId,
    this.userId,
    this.title,
    this.content,
    this.date,
    this.location,
    this.pricePerHour,
    this.isFullTime,
    this.jobSkills,
    this.usersWhoAddedFavourites,
    this.jobApplicants,
  });

  @override
  PostModel fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      companyId: json['companyId'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      date: (json['date'] as Timestamp?)?.toDate(),
      location: json['location'] as String,
      pricePerHour: json['pricePerHour'] as String,
      isFullTime: json['isFullTime'] as bool,
      jobSkills: (json['jobSkills'] as List?)?.map((e) => e as String).toList(),
      usersWhoAddedFavourites: (json['usersWhoAddedFavourites'] as List?)?.map((e) => e as String).toList(),
      jobApplicants: (json['jobApplicants'] as List?)
          ?.map((e) => JobApplicantsModel().fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  PostModel copyWith({
    String? id,
    String? companyId,
    String? userId,
    String? title,
    String? content,
    DateTime? date,
    String? location,
    String? pricePerHour,
    bool? isFullTime,
    List<String>? jobSkills,
    List<String>? usersWhoAddedFavourites,
    List<JobApplicantsModel>? jobApplicants,
  }) {
    return PostModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      location: location ?? this.location,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      isFullTime: isFullTime ?? this.isFullTime,
      jobSkills: jobSkills ?? this.jobSkills,
      usersWhoAddedFavourites: usersWhoAddedFavourites ?? this.usersWhoAddedFavourites,
      jobApplicants: jobApplicants ?? this.jobApplicants,
    );
  }

  @override
  List<Object?> get props => [
        id,
        companyId,
        userId,
        title,
        content,
        date,
        location,
        pricePerHour,
        isFullTime,
        jobSkills,
        usersWhoAddedFavourites,
        jobApplicants,
      ];

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyId': companyId,
      'userId': userId,
      'title': title,
      'content': content,
      'date': date,
      'location': location,
      'pricePerHour': pricePerHour,
      'isFullTime': isFullTime,
      'jobSkills': jobSkills,
      'usersWhoAddedFavourites': usersWhoAddedFavourites,
      'jobApplicants': jobApplicants?.map((e) => e.toJson()).toList(),
    };
  }
}
