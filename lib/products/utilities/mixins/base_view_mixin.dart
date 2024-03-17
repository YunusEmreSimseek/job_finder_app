import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/utilities/states/base/base_state.dart';
import 'package:job_finder_app/products/utilities/states/loading/loading_cubit.dart';

/// BaseViewMixin for [StatefulWidget] to separate the logic from the view
mixin BaseViewMixin<T extends StatefulWidget> on State<T> {
  /// Get the current state
  R getCubit<R extends Cubit<BaseState>>() => context.read<R>();

  /// Change loading state
  void changeLoading() => getCubit<LoadingCubit>().changeLoading();

  /// Safe operation for async operations
  Future<void> safeOperation(AsyncCallback callback) async {
    if (!mounted) return;
    await callback.call();
  }

  /// Safe operation for direct operations
  void directSafeOperarion(VoidCallback callback) {
    if (!mounted) return;
    callback.call();
  }
}
