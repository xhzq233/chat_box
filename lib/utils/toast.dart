/// chat_box - toast
/// Created by xhz on 22/04/2022
///
import 'dart:async';
import 'dart:io';
import 'package:chat_box/global.dart';
import 'package:chat_box/utils/platform_api/platform_api.dart';
import 'package:flutter/material.dart';
import 'loading.dart';

class Pair<T, Y> {
  final T first;
  final Y second;

  const Pair(this.first, this.second);
}

toast(String str, {int delay = 4}) {
  if (str.isEmpty) return;

  if (Platform.isAndroid) {
    PlatformApi.toast(str, isLong: delay > 4);
    return;
  }

  OverlayEntry _overlayEntry = OverlayEntry(
      builder: (_) => Align(
            alignment: const Alignment(0, 0.69),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Text(
                  str,
                  style: const TextStyle(color: Global.cbOnBackground),
                ),
              ),
            ),
          ));
  ToastQueue.push(Pair(delay, _overlayEntry));
}

typedef ToastQueueValue = Pair<int, OverlayEntry>;

class ToastQueue {
  static final List<ToastQueueValue> _queue = [];
  static bool _isRunning = false;

  static void push(ToastQueueValue value) {
    _queue.add(value);
    if (!_isRunning) _boost();
  }

  static void _boost() async {
    _isRunning = true;
    while (_queue.isNotEmpty) {
      final i = _queue.removeAt(0);
      GlobalOverlayContext.overlayState!.insert(i.second);
      await Future.delayed(Duration(seconds: i.first));
      i.second.remove();
    }
    _isRunning = false;
  }
}
