import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_finder_app/products/models/user_model.dart';
import 'package:job_finder_app/products/services/commands/create_user_command.dart';
import 'package:job_finder_app/products/services/commands/update_user_command.dart';
import 'package:job_finder_app/products/services/queries/get_user_by_email_query.dart';
import 'package:job_finder_app/products/services/queries/get_user_by_id_query.dart';
import 'package:job_finder_app/products/utilities/enums/firebase_collections.dart';
import 'package:logger/logger.dart';

part 'user_service.dart';

final class UserManager {
  final IUserService _userService;

  UserManager(this._userService);

  Future<UserModel?> getUserByEmail(GetUserByEmailQuery query) async {
    final user = await _userService.getUserByEmail(query);
    return user;
  }

  Future<UserModel?> getUserById(GetUserByIdQuery query) async {
    final user = await _userService.getUserById(query);
    return user;
  }

  Future<bool> updateUser(UpdateUserCommand command) async {
    final response = await _userService.updateUser(command);
    return response;
  }

  Future<bool> createUser(CreateUserCommand command) async {
    final response = await _userService.createUser(command);
    return response;
  }
}
