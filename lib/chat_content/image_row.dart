import 'package:chat_box/model/message.dart';
import 'package:flutter/material.dart';
import '../global.dart';
import 'avatar.dart';

class ImageRow extends StatelessWidget {
  const ImageRow({Key? key, required this.msg}) : super(key: key);
  final ChatMessage msg;

  @override
  Widget build(BuildContext context) {
    final img = Image.network(
      Global.https + Global.imageHost + msg.content,
      width: MediaQuery.of(context).size.width * 0.7,
    );
    if (msg.owned) {
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(padding: const EdgeInsets.all(10), child: img),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAvatar(name: msg.sender),
            const SizedBox(width: 6,),
            img
          ],
        ),
      );
    }
  }
}
