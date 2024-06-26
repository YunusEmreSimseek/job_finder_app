import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_finder_app/products/utilities/states/company/company_cubit.dart';
import 'package:job_finder_app/products/utilities/states/is_obscure/is_obscure_cubit.dart';
import 'package:job_finder_app/products/utilities/states/loading/loading_cubit.dart';
import 'package:job_finder_app/products/utilities/states/post/post_cubit.dart';
import 'package:job_finder_app/products/utilities/states/user/user_cubit.dart';

/// That is going to initialize the blocs for the application.
final class BlocInitialize extends MultiBlocProvider {
  BlocInitialize({required super.child, super.key})
      : super(
          providers: [
            BlocProvider<LoadingCubit>(create: (context) => LoadingCubit.instance),
            BlocProvider<IsObscureCubit>(create: (context) => IsObscureCubit.instance),
            BlocProvider<UserCubit>(create: (context) => UserCubit.instance),
            BlocProvider<PostCubit>(create: (context) => PostCubit.instance),
            BlocProvider<CompanyCubit>(create: (context) => CompanyCubit.instance),
          ],
        );
}
