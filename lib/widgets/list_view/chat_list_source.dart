/// chat_box - chat_list_source
/// Created byxhz on 28/05/2022
import 'dart:developer';

import 'package:chat_box/controller/api/api_client.dart';
import 'package:chat_box/controller/message/message_controller.dart';
import 'package:chat_box/model/group.dart';
import 'package:chat_box/model/message.dart';
import 'package:chat_box/utils/toast.dart';

mixin ChatListSourceContainer {}

class ChatListSource {
  ChatListSource({required this.group});

  int get len => _list.length;
  final Group group;

  bool get inThisGroup => ChatMessagesController.shared.currentGroupID == group.id;
  final List<ChatMessage> _list = [];
  bool _getting = false;
  bool noMore = false;

  void Function()? onAddedMessage;

  void add(ChatMessage message) {
    _list.add(message);
    onAddedMessage?.call();
  }

  //must call to init data
  Future<void> initData() async {
    if (_getting) return;
    _getting = true;
    try {
      _list.addAll(await ApiClient.getMessageListBefore(DateTime.now(), group.id));
    } catch (e) {
      toast('initData message error $e');
      log('initData message error $e');
    }
    _getting = false;
  }

  ChatMessage get last => _list.last;

  ChatMessage operator [](int index) {
    return _list[index];
  }

  void loadMore() async {
    if (_getting) return;
    _getting = true;
    final res = [];
    try {
      res.addAll(await ApiClient.getMessageListBefore(_list.first.time, group.id));
    } catch (e) {
      toast('fetch message error $e');
      log('fetch message error $e');
    }
    if (res.isEmpty) {
      noMore = true;
    } else {
      for (int i = res.length - 1; i >= 0; --i) {
        final _i = res[i];
        if (_list.first.time
            .difference(_i.time)
            .inMinutes > 10) {
          final dateTime = _list.first.time;
          _list.insert(
              0,
              ChatMessage(
                  sender: 0,
                  id: 0,
                  group: 0,
                  time: DateTime.now(),
                  content: '${dateTime.month}.${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}'));
        }
        _list.insert(0, _i);
      }
    }
    onAddedMessage?.call();
    _getting = false;
  }
}
