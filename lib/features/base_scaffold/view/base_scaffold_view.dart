import 'package:flutter/material.dart';
import 'package:job_finder_app/features/base_scaffold/mixin/base_scaffold_mixin.dart';
import 'package:kartal/kartal.dart';

final class BaseScaffoldView extends StatefulWidget {
  const BaseScaffoldView({super.key});
  @override
  State<BaseScaffoldView> createState() => _BaseScaffoldViewState();
}

class _BaseScaffoldViewState extends State<BaseScaffoldView> with BaseScaffoldMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: currentIndex,
        onTap: (index) => changeCurrentIndex(index),
        unselectedItemColor: context.general.colorScheme.outlineVariant,
      ),
    );
  }
}
