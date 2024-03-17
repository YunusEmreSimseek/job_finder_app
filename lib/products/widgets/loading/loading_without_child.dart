import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/utilities/states/loading/loading_cubit.dart';

/// LoadingWithoutChild is a widget that shows a loading indicator without a child.
final class LoadingWithoutChild extends StatelessWidget {
  const LoadingWithoutChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocSelector<LoadingCubit, LoadingState, bool>(
        selector: (state) {
          return state.isLoading;
        },
        builder: (context, state) {
          if (!state) {
            return const SizedBox.shrink();
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
