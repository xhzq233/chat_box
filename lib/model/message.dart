import 'package:chat_box/global.dart';

/// chat_box - message
/// Created by xhz on 23/04/2022

class ChatMessage {
  bool get owned => Global.sender == sender;
  final String content;
  final String sender;
  final DateTime time;
  final bool isImage = false;

  bool get isHint => id == 0;
  final int id;

  const ChatMessage({required this.content, required this.sender, required this.id, required this.time});

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
      content: json['Content'], sender: json['Sender'], id: json['ID'], time: DateTime.parse(json['Time']).toLocal());
}
