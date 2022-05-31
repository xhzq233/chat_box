/// chat_box - chat_list_source
/// Created byxhz on 28/05/2022
import 'dart:developer';

import 'package:chat_box/controller/api/api_client.dart';
import 'package:chat_box/controller/message/message_controller.dart';
import 'package:chat_box/model/group.dart';
import 'package:chat_box/model/message.dart';
import 'package:chat_box/utils/toast.dart';

//message list which sorted by time from large to small
class ChatListSource {
  ChatListSource({required this.group});

  int get len => _list.length;
  final Group group;

  bool get userIsInThisGroup => ChatMessagesController.shared.currentGroupID == group.id;
  final List<ChatMessage> _list = [];
  bool _getting = false;
  bool noMore = false;

  void Function()? onAddedMessage;

  void add(ChatMessage message) {
    _list.add(message);
    onAddedMessage?.call();
  }

  //must call and only call once
  Future<void> initData() async {
    if (_getting) return;
    _getting = true;
    try {
      _list.addAll((await ApiClient.getMessageListBefore(DateTime.now(), group.id)).reversed);
      if (_list.isEmpty) noMore = true;
    } catch (e) {
      toast('init message error $e');
      log('init message error $e');
    }
    _getting = false;
  }

  ChatMessage get newest => _list.first;

  ChatMessage operator [](int index) {
    return _list[index];
  }

  Future<void> loadMore() async {
    if (_getting) return;
    _getting = true;
    final List<ChatMessage> res = [];
    try {
      res.addAll(await ApiClient.getMessageListBefore(_list.last.time, group.id));
    } catch (e) {
      toast('fetch message error $e');
      log('fetch message error $e');
    }
    if (res.isEmpty) {
      noMore = true;
    } else {
      _list.addAll(res.reversed);
    }
    onAddedMessage?.call();
    _getting = false;
  }
}
