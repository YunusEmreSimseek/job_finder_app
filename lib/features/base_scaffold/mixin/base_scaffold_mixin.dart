import 'package:flutter/material.dart';
import 'package:job_finder_app/features/base_scaffold/view/base_scaffold_view.dart';
import 'package:job_finder_app/features/home/view/home_view.dart';
import 'package:job_finder_app/features/posts/view/posts_view.dart';
import 'package:job_finder_app/features/settings/view/settings_view.dart';
import 'package:job_finder_app/products/constants/string_constant.dart';
import 'package:job_finder_app/products/enums/icon_size.dart';

mixin BaseScaffoldMixin on State<BaseScaffoldView> {
  final List<Widget> pages = [
    const HomeView(),
    const PostsView(),
    const SettingsView(),
  ];

  int currentIndex = 0;
  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.home, size: IconSize.mid.value), label: StringConstant.home),
    BottomNavigationBarItem(
        icon: Icon(Icons.align_vertical_bottom_outlined, size: IconSize.mid.value), label: StringConstant.posts),
    BottomNavigationBarItem(icon: Icon(Icons.settings, size: IconSize.mid.value), label: StringConstant.settings),
  ];

  void changeCurrentIndex(int value) {
    setState(() {
      currentIndex = value;
    });
  }
}
