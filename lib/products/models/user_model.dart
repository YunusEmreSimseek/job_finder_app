import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:job_finder_app/products/models/base_firebase_model.dart';

final class UserModel with EquatableMixin, IdModel, BaseFirebaseModel<UserModel> {
  final String? name;
  final String? email;
  final String? password;
  final String? imageUrl;
  final String? phoneNo;
  final DateTime? birthday;

  @override
  final String? id;

  UserModel({this.name, this.email, this.password, this.imageUrl, this.phoneNo, this.birthday, this.id});

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      imageUrl: json['imageUrl'] as String?,
      phoneNo: json['phoneNo'] as String?,
      birthday: (json['birthday'] as Timestamp?)?.toDate(),
      id: json['id'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
      'phoneNo': phoneNo,
      'birthday': birthday,
      'id': id,
    };
  }

  // String? birthdayToString() {
  //   if (birthday == null) return null;
  //   return '${birthday!.day}/${birthday!.month}/${birthday!.year}';
  // }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? imageUrl,
    String? phoneNo,
    DateTime? birthday,
    String? id,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNo: phoneNo ?? this.phoneNo,
      birthday: birthday ?? this.birthday,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [name, email, password, imageUrl, phoneNo, birthday, id];
}
