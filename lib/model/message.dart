import 'package:chat_box/global.dart';

/// chat_box - message
/// Created by xhz on 23/04/2022

class ChatMessage {
  bool get owned => Global.sender == sender;
  final String content;
  final String sender;
  final DateTime time;
  final bool isImage; //is image
  final int repTo;

  bool get isHint => id == 0;
  final int id;

  const ChatMessage(
      {required this.content,
      required this.sender,
      required this.id,
      required this.time,
      this.repTo = 0, // 0 表示plain text
      this.isImage = false});

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
      content: json['Content'],
      sender: json['Sender'],
      id: json['ID'],
      time: DateTime.parse(json['Time']).toLocal(),
      repTo: json['RepTo'],
      isImage: json['IsImage']);

  Map toMap() => {
        //只需要接受这三个，sender服务器那边有，time和id在存数据库时提供
        'Content': content,
        'RepTo': repTo,
        'IsImage': isImage,
      };
}
