/// xhzq_test - msg_bubble
/// Created by xhz on 26/04/2022
import 'package:flutter/material.dart';

import '../global.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key,
      required this.content,
      this.backgroundColor = Global.cbMyBubbleBackground,
      this.textColor = Global.cbOnMyBubble})
      : super(key: key);

  const MessageBubble.others(
      {Key? key,
      required this.content,
      this.backgroundColor = Global.cbOthersBubbleBackground,
      this.textColor = Global.cbOnOthersBubble})
      : super(key: key);

  final String content;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 9),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      child: SelectableText(
        content,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
