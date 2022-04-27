/// chat_box - auto_request_node
/// Created by xhz on 23/04/2022
import 'package:flutter/material.dart';

class AutoUnFocusWrap extends StatelessWidget {
  const AutoUnFocusWrap({Key? key, required this.focusNode, required this.child}) : super(key: key);
  final Widget child;

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (focusNode.hasFocus) focusNode.unfocus();
        },
        onVerticalDragDown: (_) {
          if (focusNode.hasFocus) focusNode.unfocus();
        },
        child: child);
  }
}
