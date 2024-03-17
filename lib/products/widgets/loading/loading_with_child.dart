import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/utilities/states/loading/loading_cubit.dart';

/// LoadingWithChild is a widget that shows a loading indicator with a child.
final class LoadingWithChild extends StatelessWidget {
  const LoadingWithChild({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocSelector<LoadingCubit, LoadingState, bool>(
        selector: (state) {
          return state.isLoading;
        },
        builder: (context, state) {
          if (!state) {
            return child;
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
