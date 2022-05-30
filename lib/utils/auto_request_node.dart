/// chat_box - auto_request_node
/// Created by xhz on 23/04/2022
import 'package:flutter/material.dart';

class AutoUnFocusWrap extends StatelessWidget {
  const AutoUnFocusWrap({Key? key, required this.focusNodes, required this.child}) : super(key: key);
  final Widget child;

  final List<FocusNode> focusNodes;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        //如果选择deferToChild, 接受不了事件的地方受到点击就不会执行了(hit_test=>0), 而我们要在包含的全部区域监听点击
        behavior: HitTestBehavior.opaque, //自己处理，不向下传递
        onTap: () {
          //因为opaque会修改hitTestSelf的返回值，让自己通过测试进而让parent结束对其它children的hit_test
          //translucent为自己和child都可以接受事件
          for (final focusNode in focusNodes) {
            if (focusNode.hasFocus) focusNode.unfocus();
          }
        },
        onVerticalDragDown: (_) {
          for (final focusNode in focusNodes) {
            if (focusNode.hasFocus) focusNode.unfocus();
          }
        },
        child: SizedBox.expand(
          child: child,
        )); //这里使用expand布局
  }
}
