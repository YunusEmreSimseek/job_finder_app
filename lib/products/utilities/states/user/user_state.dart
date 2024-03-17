part of 'user_cubit.dart';

final class UserState extends Equatable implements BaseState {
  const UserState({this.loggedInUser});

  final UserViewModel? loggedInUser;

  UserState copyWith({UserViewModel? loggedInUser}) {
    return UserState(loggedInUser: loggedInUser ?? this.loggedInUser);
  }

  @override
  List<Object?> get props => [loggedInUser];
}
