import 'package:flutter_test/flutter_test.dart';
import 'package:job_finder_app/products/services/queries/get_user_by_id_query.dart';
import 'package:job_finder_app/products/services/user/user_manager.dart';

import 'mock_firebase.dart';

Future<void> main() async {
  late final MockFirebaseService service;
  late final UserManager userServiceManager;

  setUp(() async {
    service = MockFirebaseService();
    userServiceManager = UserManager(service);
  });
  test('Sample Test', () async {
    final query = GetUserByIdQuery('1');
    final response = await userServiceManager.getUserById(query);
    expect(response, isNotNull);
  });
}
