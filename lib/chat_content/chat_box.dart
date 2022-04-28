/// chat_box - chat_box
/// Created by xhz on 22/04/2022

import 'dart:developer';
import 'dart:io';
import 'package:chat_box/chat_content/hint_row.dart';
import 'package:chat_box/chat_content/message_controller.dart';
import 'package:chat_box/global.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/chat_content/chat_row.dart';
import 'package:chat_box/utils/auto_request_node.dart';
import 'package:chat_box/utils/toast.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({Key? key, required this.socket}) : super(key: key);

  final WebSocket socket;

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  late final ChatMessagesController chatMessagesController = ChatMessagesController()
    ..socket = widget.socket
    ..context = context
    ..startListen()
    ..bindObserver();

  final TextEditingController _textEditingController = TextEditingController();
  final _node = FocusNode();

  bool get _end => chatMessagesController.end;

  int get len => chatMessagesController.len;

  @override
  void dispose() {
    log('call dispose');
    chatMessagesController.close();
    chatMessagesController.removeObserver();
    super.dispose();
  }

  Widget get _textField => Padding(
        padding: const EdgeInsets.all(10),
        child: TextField(
          style: const TextStyle(color: Global.cbOnBackground),
          focusNode: _node,
          controller: _textEditingController,
          autocorrect: false,
          decoration: InputDecoration(
              fillColor: Global.cbPrimaryColor,
              hintText: "Message",
              prefixIcon: const Icon(Icons.message),
              suffix: ElevatedButton(
                onPressed: () {
                  chatMessagesController.send(_textEditingController.text.trim());
                  _textEditingController.clear();
                },
                child: const Text('send'),
              )),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Group'),
      ),
      body: Column(
        children: [
          Expanded(
            child: AutoUnFocusWrap(
                focusNode: _node,
                child: ListView.builder(
                    itemCount: len + 1,
                    reverse: true, //double reverse
                    itemBuilder: (ctx, index) {
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
                          return Container();
                        } else {
                          return ChatRow(
                            msg: msg,
                          );
                        }
                      }
                      //double reverse
                    })),
          ),
          _textField
        ],
      ),
    );
  }
}
