import 'package:flutter_test/flutter_test.dart';
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
    final response = await userServiceManager.getUserById('1');
    expect(response, isNotNull);
  });
}
