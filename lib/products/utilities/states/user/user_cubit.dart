import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/utilities/states/base/base_state.dart';
import 'package:job_finder_app/products/view_models/user_view_model.dart';

part 'user_state.dart';

final class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  void setUser(UserViewModel loggedInUser) {
    emit(state.copyWith(loggedInUser: loggedInUser));
  }
}
