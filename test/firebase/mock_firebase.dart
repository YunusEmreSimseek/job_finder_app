// Firestore servisini soyutlamak için arayüz tanımlayın
import 'package:job_finder_app/products/models/user_model.dart';
import 'package:job_finder_app/products/services/user/user_manager.dart';
import 'package:mockito/mockito.dart';
import 'package:vexana/vexana.dart';

// abstract class FirestoreService implements IPostService {
//   @override
//   Future<List<Map<String, dynamic>>> getAllPosts();
// }

// // Firestore servisini sahte (mock) olarak uygulayan sınıfı oluşturun
// class MockFirestoreService extends Mock implements FirestoreService {
//   @override
//   Future<List<Map<String, dynamic>>> getAllPosts() async {
//     // Sahte veri döndürme
//     return [
//       {'id': '1', 'title': 'Sample Post 1'},
//       {'id': '2', 'title': 'Sample Post 2'},
//       // Buraya istediğiniz kadar sahte veri ekleyebilirsiniz
//     ];
//   }
// }

final class MockFirebaseService extends Mock implements IUserService {
  @override
  Future<UserModel?> getUserById(String userId) async {
    return UserModel(
        id: '1',
        name: 'John Doe',
        email: 'john@test.com',
        password: '123456',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/jobsearchapp-3da0a.appspot.com/o/User%20Images%2Femre%40test.com-Emre%20%C5%9Eim%C5%9Fek?alt=media&token=be5968bb-2e3b-4eac-8f70-cddaab8dc635');
  }

  MockNetworkModel getMockUser() => MockNetworkModel();
}

final class MockNetworkModel extends INetworkModel<MockNetworkModel> {
  final String id = '1';
  final String name = 'John Doe';
  final String email = 'john@test.com';
  final String password = '123456';
  final String imageUrl =
      'https://firebasestorage.googleapis.com/v0/b/jobsearchapp-3da0a.appspot.com/o/User%20Images%2Femre%40test.com-Emre%20%C5%9Eim%C5%9Fek?alt=media&token=be5968bb-2e3b-4eac-8f70-cddaab8dc635';
  @override
  MockNetworkModel fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson() {
    throw UnimplementedError();
  }
}
