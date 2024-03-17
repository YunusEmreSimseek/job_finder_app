part of 'is_obscure_cubit.dart';

final class IsObscureState extends Equatable implements BaseState {
  const IsObscureState({this.isObscure = true});
  final bool isObscure;

  IsObscureState copyWith({bool? isObscure}) {
    return IsObscureState(
      isObscure: isObscure ?? this.isObscure,
    );
  }

  @override
  List<Object> get props => [isObscure];
}
