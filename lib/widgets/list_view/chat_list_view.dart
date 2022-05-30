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
    if (index == data.len) {
      if (data.noMore) {
        return const Center(
          child: Text('no more history'),
        );
      } else {
        data.loadMore();
        return const Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    } else {
      final msg = data[data.len - 1 - index]; //reverse again
      if (msg.isHint) {
        return HintRow(content: msg.content);
      } else if (msg.isImage) {
        return ImageRow(msg: msg);
      } else {
        return ChatRow(
          msg: msg,
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    data.onAddedMessage =
        () {
      final ele = context as Element;
      if (!ele.dirty) {
        ele.markNeedsBuild();
      }
    };
    return ListView.builder(
      itemCount: data.len + 1,
      itemBuilder: _itemBuilder,
      reverse: true,
    );
  }
}

