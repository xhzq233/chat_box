/// chat_box - chat_row
/// Created by xhz on 22/04/2022
import 'package:chat_box/widgets/user/avatar.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/model/message.dart';

import 'package:chat_box/global.dart';

class ChatRow extends StatelessWidget {
  const ChatRow({Key? key, required this.msg}) : super(key: key);
  final ChatMessage msg;

  @override
  Widget build(BuildContext context) {
    final Widget bubble;
    bubble = Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 9),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: msg.owned ? Global.cbMyBubbleBackground : Global.cbOthersBubbleBackground,
        ),
        child: SelectableText(
          msg.content,
          selectionControls: materialTextSelectionControls,
          style: TextStyle(color: msg.owned ? Global.cbOnMyBubble : Global.cbOnOthersBubble),
        ));
    if (msg.owned) {
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Theme(
              child: bubble,
              data: ThemeData(colorScheme: Global.cbDarkScheme.copyWith(primary: Global.cbOnBackground)),
            )),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAvatar(account: msg.account),
            Flexible(child: bubble),
          ],
        ),
      );
    }
  }
}
