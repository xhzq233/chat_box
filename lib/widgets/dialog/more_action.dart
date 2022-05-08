/// chat_box - more_action
/// Created by xhz on 08/05/2022
import 'package:chat_box/global.dart';
import 'package:flutter/material.dart';

class MoreActionWidget extends AnimatedWidget {
  const MoreActionWidget(
      {Key? key, required Animation animation, required this.actions, this.width = 111.2, this.height = 180})
      : super(key: key, listenable: animation);
  final double height;
  final double width; //prefer 0.618 * height
  final List<Widget> actions;

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    final len = actions.length;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Global.cbOthersBubbleBackground,
      ),
      width: width * 0.8 + animation.value * 0.2 * width,
      height: height * 0.4 + animation.value * height * 0.6,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (int i = 0; i < len; i++)
            Positioned(top: height * i / len * animation.value, width: width, child: actions[i])
        ],
      ),
    );
  }
}
