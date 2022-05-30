/// xhzq_test - wss_controller
/// Created by xhz on 26/04/2022
import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:chat_box/controller/account/account_controller.dart';
import 'package:chat_box/controller/api/api_client.dart';
import 'package:chat_box/model/group.dart';
import 'package:chat_box/widgets/list_view/chat_list_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../model/account.dart';
import '../../model/message.dart';
import '../../utils/utils.dart';

class ChatMessagesController extends WidgetsBindingObserver {
  static ChatMessagesController? _controller;

  static ChatMessagesController get shared {
    _controller ??= ChatMessagesController._();
    return _controller!;
  }

  ChatMessagesController._();

  WebSocket? get socket => AccountController.shared.socket;

  //group-id bind chat-messages
  final HashMap<int, ChatListSource> messages = HashMap();

  //account-id bind Account
  final HashMap<int, Account> initializedAccounts = HashMap();

  BuildContext? update;

  void bindObserver([BuildContext? update]) {
    this.update = update;
    WidgetsBinding.instance?.addObserver(this);
  }

  void removeObserver() {
    update = null;
    WidgetsBinding.instance?.removeObserver(this);
  }

  void _receive(dynamic data) {
    final msg = ChatMessage.fromJson(jsonDecode(data));
    messages[msg.group]!.add(msg);
    if (_isOnBackground) PlatformApi.notification(msg.id, 'group', msg.content, 'haha');
    final schedulerPhase = SchedulerBinding.instance!.schedulerPhase;
    log('$schedulerPhase');
  }

  Future<void> fetchGroups() async {
    try {
      final List<Group> groups = await ApiClient.getAccountGroups();
      for (final g in groups) {
        messages[g.id] = ChatListSource(group: g);
        for (final a in g.accounts) {
          initializedAccounts[a.id] = a;
        }
      }
    } catch (e) {
      log('Error while init groups&messages: $e');
    }
    (update as Element?)?.markNeedsBuild();
  }

  void onConnectionDone() async {
    if (_closedByUser) return;
    toast('connection is done, reconnecting');
    log('call onConnectionDone');
    final res = await AccountController.shared.login();
    if (!res) {
      toast('reconnection failed');
      log('reconnection failed');
      if (update == null) {
        exit(0);
      } else {
        Navigator.pushNamedAndRemoveUntil(update!, '/connect', (_) => false);
      }
    } else {
      log('call startListen in onConnectionDone');
      startListen();
    }
  }

  void startListen() {
    log('call startListen');
    if (AccountController.shared.isOnline) {
      _closedByUser = false;
      fetchGroups();
      socket!.listen(_receive, onError: (e) {
        toast(e.toString());
        log(e.toString());
      }, onDone: onConnectionDone, cancelOnError: true);
    } else {
      toast('unexpected offline');
      log('unexpected offline');
    }
  }

  int currentGroupID = -1;

  ChatListSource? get currentChatListSource => messages[currentGroupID];

  void send(String content, [bool isImage = false, int repTo = 0]) {
    if (AccountController.shared.isOnline) {
      socket!.add(jsonEncode({
        //sender服务器那边有，time和id在存数据库时提供
        'Content': content,
        'RepTo': repTo,
        'Group': currentGroupID,
        'IsImage': isImage,
      }));
    } else {
      toast('unexpected offline while sending message');
      log('unexpected offline while sending message');
    }
  }
  bool _closedByUser = false;
  void close() {
    if (AccountController.shared.isOnline) {
      _closedByUser = true;
      socket!.close(1001, 'client closed socket');
      // _messages.clear();
    } else {
      toast('unexpected offline while closing');
      log('unexpected offline while closing');
    }
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
