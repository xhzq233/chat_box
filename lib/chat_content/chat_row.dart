/// chat_box - chat_row
/// Created by xhz on 22/04/2022
import 'package:chat_box/chat_content/avatar.dart';
import 'package:chat_box/chat_content/msg_bubble.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/model/message.dart';

class ChatRow extends StatelessWidget {
  const ChatRow({Key? key, required this.msg}) : super(key: key);
  final ChatMessage msg;

  @override
  Widget build(BuildContext context) {
    if (msg.owned) {
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: MessageBubble(
            content: msg.content,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAvatar(name: msg.sender),
            Flexible(
                child: MessageBubble.others(
              content: msg.content,
            )),
          ],
        ),
      );
    }
  }
}
