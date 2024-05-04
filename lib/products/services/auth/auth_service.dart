part of 'auth_service_manager.dart';

abstract class IAuthService {
  Future<bool> loginWithEmailAndPassword({required String email, required String password});
  Future<bool> register({required UserModel user});
}

// AuthRepository
final class AuthService implements IAuthService {
  // Singleton
  static AuthService? _instance;
  static AuthService get instance {
    _instance ??= AuthService._init();
    return _instance!;
  }

  AuthService._init();
  final _userCollectionReference = FirebaseCollections.user.reference;

  @override
  Future<bool> loginWithEmailAndPassword({required String email, required String password}) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

    if (FirebaseAuth.instance.currentUser != null) {
      Logger().i('Login Success');
      return true;
    }
    Logger().e('Login Failed');
    return false;
  }

  @override
  Future<bool> register({required UserModel user}) async {
    final responseAuth =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email!, password: user.password!);
    if (responseAuth.user == null) {
      Logger().e('Register FirebaseAuth Failed');
      return false;
    }
    Logger().i('Register FirebaseAuth Success');
    final responseFirestore = await _userCollectionReference.add(user.toJson());
    if (responseFirestore.id.isEmpty) {
      Logger().e('Register Firestore Failed');
      return false;
    }
    Logger().i('Register Firestore Success');
    await _addIdIntoUser(responseFirestore);
    return true;
  }

  Future<void> _addIdIntoUser(DocumentReference docRef) async {
    await docRef.update({'id': docRef.id});
    Logger().i('AddIdIntoUser Success');
  }
}
