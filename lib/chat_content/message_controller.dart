/// xhzq_test - wss_controller
/// Created by xhz on 26/04/2022
import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

  final List<ChatMessage> _messages = [];

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
    final schedulerPhase = SchedulerBinding.instance!.schedulerPhase;
    log('$schedulerPhase');

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
    _messages.clear();
    _messages.add(ChatMessage(sender: '', id: 0, time: DateTime.now(), content: '${Global.sender} joined the chat'));
    socket.listen(_receive, onError: (e) {
      toast('error while listening: $e');
      Navigator.pop(context);
    }, onDone: () {
      toast('connection is done');
    }, cancelOnError: true);
  }

  Future<bool> connect() async {
    try {
      socket = await WebSocket.connect(Global.wss + Global.wsHost, headers: {'Auth': token});
      return true;
    } catch (e) {
      toast('Error');
      return false;
    }
  }

  void send(String str, [bool isImage = false, int repTo = 0]) {
    if (str.isEmpty) return;
    socket.add(jsonEncode({
      //只需要接受这三个，sender服务器那边有，time和id在存数据库时提供
      'Content': str,
      'RepTo': repTo,
      'IsImage': isImage,
    }));
  }

  void request() async {
    if (_getting) return;
    _getting = true;
    final res = await http.get(Uri.parse(Global.https + Global.wsHost),
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

  //only called by dispose method
  void close() {
    socket.close(1001, 'client closed socket');
    _messages.clear();
  }

  bool _isOnBackground = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _isOnBackground = false; //前台
        break;
      case AppLifecycleState.paused:
        _isOnBackground = true; //后台
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }
}
