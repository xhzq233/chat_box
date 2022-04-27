/// xhzq_test - wss_controller
/// Created by xhz on 26/04/2022
import 'dart:io';
import 'dart:isolate';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import '../global.dart';
import '../model/message.dart';
import 'package:http/http.dart' as http;
import 'package:chat_box/utils/loading.dart';

import '../utils/toast.dart';

class ChatMessagesController {
  WebSocket socket;
  final BuildContext context;

  String get token => Global.token;

  ChatMessagesController({required this.socket, required this.context}) {
    Uint8List;
    socket.listen(receive, onError: (e) {
      toast('error while listening: $e');
      Navigator.pop(context);
    }, onDone: () {
      toast('connection is done');
    }, cancelOnError: true);
  }

  late final List<ChatMessage> _messages = [
    ChatMessage(sender: '', id: 0, time: DateTime.now(), content: '${Global.sender} joined the chat')
  ];

  ChatMessage messageOf(int index) => _messages[index];

  int get len => _messages.length;

  bool end = false;
  bool _getting = false;

  void receive(dynamic data) {
    if (data is String) {
      if (data.startsWith('{')) {
        _messages.add(ChatMessage.fromJson(jsonDecode(data)));
      } else {
        //hint
        _messages.add(ChatMessage(sender: '', id: 0, time: DateTime.now(), content: data));
      }
      (context as Element).markNeedsBuild();
    } else {
      log('unknown data: $data');
    }
  }

  void reconnect() async {
    toast('connection interrupted, reconnecting...');
    Loading.show();
    try {
      socket = await WebSocket.connect('wss://${Global.host}', headers: {'Auth': token});
      socket.listen(receive, onError: (e) {
        toast('error while listening: $e');
        Navigator.pop(context);
      }, onDone: () {
        toast('connection is done');
      }, cancelOnError: true);
      Loading.hide();
    } catch (e) {
      Loading.hide();
      toast('reconnection err with $e');
      Navigator.pop(context);
    }
  }

  void send(String str) {
    socket.add(str);
  }

  void request() async {
    if (_getting) return;
    _getting = true;
    final res = await http.get(Uri.parse('https://${Global.host}'),
        headers: {'hist': _messages.first.time.toIso8601String(), 'Auth': token});
    final list = (jsonDecode(res.body) as List).map((e) => ChatMessage.fromJson(e)).toList();
    if (list.isEmpty) {
      end = true;
    } else {
      for (int i = 0; i < list.length; ++i) {
        final _i = list[i];
        if (_messages.first.time.difference(_i.time).inMinutes > 10) {
          final dateTime = _messages.first.time;
          _messages.insert(
              0,
              ChatMessage(
                  sender: '',
                  id: 0,
                  time: DateTime.now(),
                  content: '${dateTime.month}.${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}'));
        }
        _messages.insert(0, _i);
      }

      (context as Element).markNeedsBuild();
    }
    _getting = false;
  }

  void close() {
    socket.close(1001, 'client closed socket');
  }
}
