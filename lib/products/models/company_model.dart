import 'package:equatable/equatable.dart';
import 'package:job_finder_app/products/models/base_firebase_model.dart';

final class CompanyModel with EquatableMixin, IdModel, BaseFirebaseModel<CompanyModel> {
  final String? content;
  final String? imageUrl;
  final String? title;
  @override
  final String? id;

  CompanyModel({this.content, this.title, this.imageUrl, this.id});

  @override
  CompanyModel fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      content: json['content'] as String?,
      title: json['title'] as String?,
      imageUrl: json['imageUrl'] as String?,
      id: json['id'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'title': title,
      'imageUrl': imageUrl,
      'id': id,
    };
  }

  CompanyModel copyWith({
    String? content,
    String? title,
    String? imageUrl,
    String? id,
  }) {
    return CompanyModel(
      content: content ?? this.content,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [content, title, imageUrl, id];
}
