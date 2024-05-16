import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_finder_app/products/services/commands/create_user_command.dart';
import 'package:logger/logger.dart';

abstract class IAuthService {
  Future<bool> loginWithEmailAndPassword({required String email, required String password});
  Future<bool> register(CreateUserCommand command);
  Future<bool> changePassword(String newPassword);
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
  // final _userCollectionReference = FirebaseCollections.user.reference;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> loginWithEmailAndPassword({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      Logger().d('Login Success');
      return true;
    } catch (e) {
      Logger().e('Login Failed: $e');
      return false;
    }
  }

  @override
  Future<bool> register(CreateUserCommand command) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: command.email, password: command.password);
      Logger().d('Auth Service : Register Success');
      return true;
    } catch (e) {
      Logger().e('Auth Service : Register Failed: $e');
      return false;
    }
    // final responseAuth =
    //     await _firebaseAuth.createUserWithEmailAndPassword(email: user.email!, password: user.password!);
    // if (responseAuth.user == null) {
    //   Logger().e('Register FirebaseAuth Failed');
    //   return false;
    // }
    // Logger().d('Register FirebaseAuth Success');
    // final responseFirestore = await _userCollectionReference.add(user.toJson());
    // if (responseFirestore.id.isEmpty) {
    //   Logger().e('Register Firestore Failed');
    //   return false;
    // }
    // Logger().i('Register Firestore Success');
    // await addIdIntoUser(responseFirestore);
    // return true;
  }

  @override
  Future<bool> changePassword(String newPassword) async {
    if (_firebaseAuth.currentUser == null) {
      Logger().e('User is not logged in');
      return false;
    }
    try {
      await _firebaseAuth.currentUser!.updatePassword(newPassword);
      Logger().d('Auth Password changed');
      await _firebaseAuth.currentUser!.reload();
      return true;
    } catch (e) {
      Logger().e('Error while changing auth password: $e');
      return false;
    }
  }

  Future<void> addIdIntoUser(DocumentReference docRef) async {
    await docRef.update({'id': docRef.id});
    Logger().i('AddIdIntoUser Success');
  }
}
