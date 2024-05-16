import 'package:job_finder_app/products/services/commands/create_user_command.dart';
import 'package:job_finder_app/products/services/commands/update_user_command.dart';
import 'package:job_finder_app/products/services/queries/get_user_by_email_query.dart';
import 'package:job_finder_app/products/services/user/user_manager.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';

mixin UserTransactionMixin {
  late final UserManager _userServiceManager = UserManager(UserService.instance);

  Future<void> getAndSetLoggedInUser(String email) async {
    final query = GetUserByEmailQuery(email);
    final response = await _userServiceManager.getUserByEmail(query);
    if (response != null) {
      UserCubit.instance.setUser(response);
    }
  }

  Future<bool> checkEmailUsing(String email) async {
    final query = GetUserByEmailQuery(email);
    final response = await _userServiceManager.getUserByEmail(query);
    if (response != null) return true;
    return false;
  }

  Future<bool> createUser(CreateUserCommand command) async {
    final response = await _userServiceManager.createUser(command);
    return response;
  }

  Future<bool> updateUser(UpdateUserCommand command) async {
    final response = await _userServiceManager.updateUser(command);
    return response;
  }
}
