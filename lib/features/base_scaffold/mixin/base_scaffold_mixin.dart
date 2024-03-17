import 'package:flutter/material.dart';
import 'package:job_finder_app/features/base_scaffold/view/base_scaffold_view.dart';
import 'package:job_finder_app/features/home/view/home_view.dart';
import 'package:job_finder_app/features/search/view/search_view.dart';
import 'package:job_finder_app/features/settings/view/settings_view.dart';
import 'package:job_finder_app/products/constants/string_constant.dart';
import 'package:job_finder_app/products/enums/icon_size.dart';

mixin BaseScaffoldMixin on State<BaseScaffoldView> {
  final List<Widget> pages = [
    const HomeView(),
    const SearchView(),
    const SettingsView(),
  ];

  int currentIndex = 0;
  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.home, size: IconSize.mid.value), label: StringConstant.home),
    BottomNavigationBarItem(icon: Icon(Icons.search, size: IconSize.mid.value), label: StringConstant.search),
    BottomNavigationBarItem(icon: Icon(Icons.settings, size: IconSize.mid.value), label: StringConstant.settings),
  ];

  void changeCurrentIndex(int value) {
    setState(() {
      currentIndex = value;
    });
  }
}
