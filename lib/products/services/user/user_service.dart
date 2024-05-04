part of 'user_service_manager.dart';

abstract class IUserService {
  Future<UserModel?> getUserById(String id);
  Future<UserModel?> getUserByEmail(String email);
  Future<void> updateUserImage({required String userId, required String imageUrl});
  Future<void> updateUser(UserModel user);
}

final class UserService implements IUserService {
  // Singleton
  static UserService? _instance;
  static UserService get instance {
    _instance ??= UserService._init();
    return _instance!;
  }

  UserService._init();

  final _userReference = FirebaseCollections.user.reference;

  @override
  Future<UserModel?> getUserById(String id) async {
    final response = await _userReference
        .where('id', isEqualTo: id)
        .withConverter(
          fromFirestore: (snapshot, options) => UserModel().fromFirebase(snapshot),
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    if (response.docs.isNotEmpty) {
      final user = response.docs.map((e) => e.data()).first;
      return user;
    }
    return null;
  }

  @override
  Future<UserModel?> getUserByEmail(String email) async {
    Logger().i('Getting user by email: $email');
    final response = await _userReference
        .where('email', isEqualTo: email)
        .withConverter(
          fromFirestore: (snapshot, options) => UserModel().fromFirebase(snapshot),
          toFirestore: (value, options) => value.toJson(),
        )
        .get();

    if (response.docs.isNotEmpty) {
      final user = response.docs.map((e) => e.data()).first;
      Logger().i('User found: $user');
      return user;
    }
    Logger().i('User not found');
    return null;
  }

  @override
  Future<void> updateUserImage({required String userId, required String imageUrl}) async {
    await _userReference.doc(userId).update({'imageUrl': imageUrl}).onError((error, stackTrace) {
      Logger().e('Error updating user image: $error');
      return;
    });
    Logger().i('User image updated');
  }

  @override
  Future<void> updateUser(UserModel user) async {
    await _userReference.doc(user.id).update(user.toJson());
  }
}
