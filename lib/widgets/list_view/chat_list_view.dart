/// chat_box - chat_list_view
/// Created by xhz on 28/05/2022
import 'package:chat_box/widgets/list_view/chat_list_source.dart';
import 'package:flutter/material.dart';
import '../chat_box/chat_row.dart';
import '../chat_box/hint_row.dart';
import '../chat_box/image_row.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({Key? key, required this.data}) : super(key: key);
  final ChatListSource data;

  Widget _itemBuilder(BuildContext ctx, int index) {
    if (index + 1 == (data.len << 1)) {
      if (data.noMore) {
        return const HintRow(content: 'No more history. 0.0');
      } else {
        data.loadMore();
        return const HintRow(content: 'Loading. = =');
      }
    } else {
      final i = index >> 1;
      final msg = data[i]; //reverse again
      if (index % 2 == 0) {
        if (msg.isImage) {
          return ImageRow(msg: msg);
        } else {
          return ChatRow(
            msg: msg,
          );
        }
      } else {
        final lastMsg = data[i + 1];//上一条消息
        if (msg.time.difference(lastMsg.time).inMinutes > 10) {
          return HintRow(
              content: '${msg.time.month}.${msg.time.day} ${msg.time.hour}:${msg.time.minute}:${msg.time.second}');
        } else {
          return const SizedBox(
            height: 0,
            width: 0,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    data.onAddedMessage = () {
      final ele = context as Element;
      if (!ele.dirty) {
        ele.markNeedsBuild();
      }
    };
    return ListView.builder(itemCount: 2 * data.len, itemBuilder: _itemBuilder, reverse: true);
  }
}
