/// chat_box - message
/// Created by xhz on 23/04/2022
import 'package:chat_box/controller/account/account_controller.dart';
import 'package:chat_box/controller/message/message_controller.dart';

import 'account.dart';

class ChatMessage {
  bool get owned => AccountController.shared.mainAccount?.id == sender;

  static const unknownAccount = Account(name: 'unknown', id: -1, email: 'None', token: 'None', banned: true);

  Account get account => ChatMessagesController.shared.initializedAccounts[sender] ?? unknownAccount;

  final int id;
  final String content;
  final DateTime time;
  final int group;
  final int sender;
  final bool isImage;
  final int repTo;

  const ChatMessage(
      {required this.content,
      required this.sender,
      required this.group,
      required this.id,
      required this.time,
      this.repTo = 0, // 0 表示plain text
      this.isImage = false});

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
      content: json['Content'],
      sender: json['Sender'],
      group: json['Group'],
      id: json['ID'],
      time: DateTime.parse(json['Time']).toLocal(),
      repTo: json['RepTo'],
      isImage: json['IsImage']);

  Map toMap() => {
        //sender服务器那边有，time和id在存数据库时提供
        'Content': content,
        'RepTo': repTo,
        'Group': group,
        'IsImage': isImage,
      };
}
