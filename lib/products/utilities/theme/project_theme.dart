import 'package:flutter/material.dart';

final class ProjectTheme {
  const ProjectTheme._();
  static ThemeData get light => ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(centerTitle: true),
      );

  static ThemeData get dark => ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(centerTitle: true),
      );
}
