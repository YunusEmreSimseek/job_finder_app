import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/models/user_model.dart';
import 'package:job_finder_app/products/utilities/states/base/base_state.dart';

part 'user_state.dart';

final class UserCubit extends Cubit<UserState> {
  static UserCubit? _instance;
  static UserCubit get instance {
    _instance ??= UserCubit._init();
    return _instance!;
  }

  UserCubit._init() : super(const UserState());

  void setUser(UserModel loggedInUser) {
    emit(state.copyWith(loggedInUser: loggedInUser));
  }
}
