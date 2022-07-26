/// chat_box - chat_box
/// Created by xhz on 22/04/2022
import 'dart:developer';
import 'dart:io';

import 'package:chat_box/controller/message/message_controller.dart';
import 'package:chat_box/widgets/list_view/chat_list_view.dart';
import 'package:chat_box/widgets/text_field/send_text_field.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/utils/auto_request_node.dart';
import 'package:chat_box/widgets/app_bar/settings_button.dart';
import 'package:chat_box/widgets/list_view/chat_list_source.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({Key? key}) : super(key: key);

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final TextEditingController _textEditingController = TextEditingController();
  final _node = FocusNode();
  final _notifier = ValueNotifier(false);

  late final _listView = ChatListView(data: source);

  ChatListSource get source => ChatMessagesController.shared.currentChatListSource!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(source.group.name),
        actions: const [SettingsAppBarButton()],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: AutoUnFocusWrap(focusNodes: [_node], child: _listView),
          ),
          TextInputField(controller: _textEditingController, node: _node, notifier: _notifier)
        ],
      ),
    );
  }
}
