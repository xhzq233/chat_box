/// xhzq_test - wss_controller
/// Created by xhz on 26/04/2022
import 'dart:io';
import 'dart:isolate';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../global.dart';
import '../model/message.dart';
import 'package:http/http.dart' as http;
import 'package:chat_box/utils/loading.dart';
import '../utils/platform_api/platform_api.dart';
import '../utils/toast.dart';

class ChatMessagesController extends WidgetsBindingObserver {
  late WebSocket socket;
  late BuildContext context;

  String get token => Global.token;

  late final List<ChatMessage> _messages = [
    ChatMessage(sender: '', id: 0, time: DateTime.now(), content: '${Global.sender} joined the chat')
  ];

  ChatMessage messageOf(int index) => _messages[index];

  int get len => _messages.length;

  bool end = false;
  bool _getting = false;

  void bindObserver() {
    WidgetsBinding.instance?.addObserver(this);
  }

  void removeObserver() {
    WidgetsBinding.instance?.removeObserver(this);
  }

  void _receive(dynamic data) {
    if (data is String) {
      if (data.startsWith('{')) {
        final msg = ChatMessage.fromJson(jsonDecode(data));
        _messages.add(msg);
        if (_isOnBackground) {
          PlatformApi.notification(msg.id, msg.sender, msg.content, 'haha');
        }
      } else {
        //hint
        _messages.add(ChatMessage(sender: '', id: 0, time: DateTime.now(), content: data));
      }
      (context as Element).markNeedsBuild();
    } else {
      log('unknown data: $data');
    }
  }

  void startListen() {
    socket.listen(_receive, onError: (e) {
      toast('error while listening: $e');
      Navigator.pop(context);
    }, onDone: () {
      toast('connection is done');
    }, cancelOnError: true);
  }

  void connect() async {
    Loading.show();
    try {
      socket = await WebSocket.connect('wss://${Global.host}', headers: {'Auth': token});
      startListen();
      Loading.hide();
    } catch (e) {
      Loading.hide();
      toast('connection err with $e');
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

  bool _isOnBackground = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        print("应用进入前台======");
        _isOnBackground = false;
        break;
      case AppLifecycleState.paused:
        print("应用处于不可见状态 后台======");
        _isOnBackground = true;
        break;
      case AppLifecycleState.inactive:
        print("应用处于闲置状态，这种状态的应用应该假设他们可能在任何时候暂停 切换到后台会触发======");
        break;
      case AppLifecycleState.detached:
        print("当前页面即将退出======");
        break;
    }
  }
}
