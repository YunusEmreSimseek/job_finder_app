import 'package:flutter/material.dart';
import 'package:job_finder_app/features/login/view/login_view.dart';
import 'package:job_finder_app/products/utilities/inits/application_initialize.dart';
import 'package:job_finder_app/products/utilities/inits/bloc_initialize.dart';
import 'package:job_finder_app/products/utilities/theme/project_theme.dart';

Future<void> main() async {
  await ApplicationInitialize.init();
  runApp(BlocInitialize(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ProjectTheme.dark,
      home: const LoginView(),
    );
  }
}
