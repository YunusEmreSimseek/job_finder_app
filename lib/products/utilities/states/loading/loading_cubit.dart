import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/utilities/states/base/base_state.dart';

part 'loading_state.dart';

final class LoadingCubit extends Cubit<LoadingState> {
  static LoadingCubit? _instance;
  static LoadingCubit get instance {
    _instance ??= LoadingCubit._init();
    return _instance!;
  }

  LoadingCubit._init() : super(const LoadingState());

  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }
}
