/// chat_box - chat_box
/// Created by xhz on 22/04/2022
import 'package:chat_box/pages/chat_content/hint_row.dart';
import 'package:chat_box/pages/chat_content/message_controller.dart';
import 'package:chat_box/pages/chat_content/send_image_btn.dart';
import 'package:chat_box/global.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/pages/chat_content/chat_row.dart';
import 'package:chat_box/utils/auto_request_node.dart';

import 'image_row.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({Key? key}) : super(key: key);
  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  ChatMessagesController get chatMessagesController => Global.chatMessagesController;

  final TextEditingController _textEditingController = TextEditingController();
  final _node = FocusNode();

  bool get _end => chatMessagesController.end;

  int get len => chatMessagesController.len;

  @override
  void initState() {
    super.initState();
    chatMessagesController
      ..context = context
      ..startListen()
      ..bindObserver();
  }

  @override
  void dispose() {
    chatMessagesController.close();
    chatMessagesController.removeObserver();
    super.dispose();
  }

  Widget get _textField => Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: SendImageButton()),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              flex: 8,
              child: TextField(
                style: const TextStyle(color: Global.cbOnBackground),
                focusNode: _node,
                controller: _textEditingController,
                autocorrect: false,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Message",
                    suffix: ElevatedButton(
                      onPressed: () {
                        chatMessagesController.send(_textEditingController.text.trim());
                        _textEditingController.clear();
                      },
                      child: const Text('send'),
                    )),
                onSubmitted: (_) {
                  chatMessagesController.send(_textEditingController.text.trim());
                  _textEditingController.clear();
                },
              )),
        ],
      ));

  Widget _itemBuilder(BuildContext ctx, int index) {
    if (index == len) {
      if (_end) {
        return const Text('no more history');
      } else {
        chatMessagesController.request();
        return const Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    } else {
      final msg = chatMessagesController.messageOf(len - 1 - index);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Group'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: AutoUnFocusWrap(
                focusNode: _node,
                child: ListView.builder(
                    itemCount: len + 1,
                    reverse: true, //double reverse
                    itemBuilder: _itemBuilder)),
          ),
          _textField
        ],
      ),
    );
  }
}
