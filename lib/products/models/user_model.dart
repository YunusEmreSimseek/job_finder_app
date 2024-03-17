import 'package:equatable/equatable.dart';
import 'package:job_finder_app/products/models/base_firebase_model.dart';

final class UserModel with EquatableMixin, IdModel, BaseFirebaseModel<UserModel> {
  final String? name;
  final String? email;
  final String? password;
  final String? imageUrl;
  final String? location;
  final String? phoneNo;
  final String? companyId;
  @override
  final String? id;

  UserModel(
      {this.name, this.email, this.password, this.imageUrl, this.location, this.phoneNo, this.companyId, this.id});

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      imageUrl: json['imageUrl'] as String?,
      location: json['location'] as String?,
      phoneNo: json['phoneNo'] as String?,
      companyId: json['companyId'] as String?,
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
      'location': location,
      'phoneNo': phoneNo,
      'companyId': companyId,
      'id': id,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? imageUrl,
    String? location,
    String? phoneNo,
    String? companyId,
    String? id,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      phoneNo: phoneNo ?? this.phoneNo,
      companyId: companyId ?? this.companyId,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [name, email, password, imageUrl, location, phoneNo, companyId, id];
}
