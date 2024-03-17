import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/utilities/states/is_obscure/is_obscure_cubit.dart';

mixin IsObscureMixin {
  void changeObscure(BuildContext context) {
    context.read<IsObscureCubit>().changeObscure();
  }
}
