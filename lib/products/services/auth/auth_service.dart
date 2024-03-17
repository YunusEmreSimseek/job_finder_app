import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_finder_app/products/enums/firebase_collections.dart';
import 'package:job_finder_app/products/models/user_model.dart';
import 'package:logger/logger.dart';

abstract class IAuthService {
  Future<bool> login({required String email, required String password});
  Future<bool> register({required UserModel user});
  Future<void> addIdIntoUser({required String email});
}

final class AuthService implements IAuthService {
  final _userCollectionReference = FirebaseCollections.user.reference;

  @override
  Future<bool> login({required String email, required String password}) async {
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
    await addIdIntoUser(email: user.email!);
    return true;
  }

  @override
  Future<void> addIdIntoUser({required String email}) async {
    final response = await _userCollectionReference
        .where("email", isEqualTo: email)
        .withConverter(
          fromFirestore: (snapshot, options) => UserModel().fromFirebase(snapshot),
          toFirestore: (value, options) {
            return value.toJson();
          },
        )
        .get();
    if (response.docs.isNotEmpty) {
      final user = response.docs.map((e) => e.data()).first;
      await _userCollectionReference.doc(user.id).update(user.toJson());
      Logger().i('AddIdIntoUser Success');
      return;
    }
    Logger().e('AddIdIntoUser Failed');
  }
}
