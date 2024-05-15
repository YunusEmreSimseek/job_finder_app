import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

mixin KeyboardScrollMixin {
  final ScrollController scrollController = ScrollController();
  void scrollToBottomOnKeyboardOpen(BuildContext context) {
    if (context.general.isKeyBoardOpen) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }
  }

  void disposeScrollController() {
    scrollController.dispose();
  }
}
