part of 'user_manager.dart';

abstract class IUserService {
  Future<UserModel?> getUserById(GetUserByIdQuery query);
  Future<UserModel?> getUserByEmail(GetUserByEmailQuery query);
  Future<bool> updateUser(UpdateUserCommand command);
  Future<bool> createUser(CreateUserCommand command);
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
  Future<bool> createUser(CreateUserCommand command) async {
    try {
      final doc = await _userReference.add({
        'name': command.name,
        'email': command.email,
        'password': command.password,
      });
      await addIdIntoUser(doc);
      Logger().i('User service : user created');
      return true;
    } catch (e) {
      Logger().e('User service : user creation failed: $e');
      return false;
    }
  }

  Future<void> addIdIntoUser(DocumentReference docRef) async {
    await docRef.update({'id': docRef.id});
    Logger().i('AddIdIntoUser Success');
  }

  @override
  Future<bool> updateUser(UpdateUserCommand command) async {
    try {
      await _userReference.doc(command.userId).update({
        'name': command.name,
        'email': command.email,
        'password': command.password,
        'imageUrl': command.imageUrl,
        'birthday': command.birthDate,
        'phoneNo': command.phone
      });
      Logger().i('User service : user updated');
      return true;
    } catch (e) {
      Logger().e('User service : user update failed: $e');
      return false;
    }
  }

  @override
  Future<UserModel?> getUserById(GetUserByIdQuery query) async {
    try {
      final doc = await _userReference
          .doc(query.userId)
          .withConverter(
            fromFirestore: (snapshot, options) => UserModel().fromFirebase(snapshot),
            toFirestore: (value, options) => value.toJson(),
          )
          .get();
      if (doc.exists) {
        Logger().d('User Service: User found by id, id: ${query.userId}');
        return doc.data();
      }
    } catch (e) {
      Logger().e('User Service: Error getting user by id: $e');
    }
    return null;
  }

  @override
  Future<UserModel?> getUserByEmail(GetUserByEmailQuery query) async {
    try {
      final doc = await _userReference
          .where('email', isEqualTo: query.email)
          .withConverter(
            fromFirestore: (snapshot, options) => UserModel().fromFirebase(snapshot),
            toFirestore: (value, options) => value.toJson(),
          )
          .get();
      if (doc.docs.isNotEmpty) {
        Logger().d('User Service: User found by email, email: ${query.email}');
        return doc.docs.first.data();
      }
    } catch (e) {
      Logger().e('User Service: Error getting user by email: $e');
    }
    return null;
  }
}
