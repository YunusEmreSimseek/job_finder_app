import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/utilities/states/base/base_state.dart';

part 'is_obscure_state.dart';

final class IsObscureCubit extends Cubit<IsObscureState> {
  static IsObscureCubit? _instance;
  static IsObscureCubit get instance {
    _instance ??= IsObscureCubit._init();
    return _instance!;
  }

  IsObscureCubit._init() : super(const IsObscureState());

  void changeObscure() {
    emit(state.copyWith(isObscure: !state.isObscure));
  }
}
