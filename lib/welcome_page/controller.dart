/// chat_box - controller
/// Created by xhz on 06/05/2022
import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global.dart';
import '../utils/utils.dart';

class WelcomePageController {
  WelcomePageController(this.context) {
    focusNode.addListener(() async {
      if (focusNode.hasFocus) {
        _saved.addAll(await recentlyUsed);
        _entry = _overlay;
        // GlobalOverlayContext.overlayState?.insert(_entry);
        Overlay.of(context)?.insert(_entry);
      } else {
        _entry.remove();
        _saved.clear();
      }
    });
  }

  final textFieldKey = GlobalKey();

  final BuildContext context;
  final controller = TextEditingController();
  final focusNode = FocusNode();

  static const spKey = 'RecentlyUsed';

  Future<List<String>> get recentlyUsed async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(spKey)) {
      await prefs.setStringList(spKey, ['毛泽东', '徐浩志', '习近平','xhzq']);
    }
    return prefs.getStringList(spKey)!;
  }

  final List<String> _saved = [];

  void _saveRecentlyUsed(String name) async {
    final list = await recentlyUsed;
    list.add(name);
    final prefs = await SharedPreferences.getInstance();
    if (!await prefs.setStringList(spKey, list)) {
      toast('Error while saving used name');
    }
  }

  Future<void> _deleteRecentlyUsed(String name) async {
    final list = await recentlyUsed;
    _saved.remove(name);
    if (!list.remove(name)) {
      toast('Error while deleting used name');
    }
    final prefs = await SharedPreferences.getInstance();
    if (!await prefs.setStringList(spKey, list)) {
      toast('Error while deleting used name');
    }
  }

  late OverlayEntry _entry;

  OverlayEntry get _overlay {
    RenderBox renderBox = textFieldKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final globalOffset = renderBox.localToGlobal(Offset.zero); //relative coordinate system
    final height = _saved.length > 3 ? 150.0 : null;
    return OverlayEntry(
        builder: (ctx) => Positioned(
              top: globalOffset.dy + size.height,
              //间隔
              left: globalOffset.dx,
              width: size.width,
              height: height,
              child: Card(
                child: RepaintBoundary(
                  child: Builder(
                      builder: (bCtx) => ListView.builder(
                          itemCount: _saved.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (ctx, index) {
                            return Card(
                              child: ListTile(
                                title: Text(_saved[index]),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    await _deleteRecentlyUsed(_saved[index]);
                                    (bCtx as Element).markNeedsBuild();
                                  },
                                ),
                                onTap: () {
                                  controller.text = _saved[index];
                                },
                              ),
                            );
                          })),
                ),
              ),
            ));
  }

  void onPressConnect() async {
    // debugDumpApp();
    Loading.show();
    final v = await PlatformApi.appVersion;
    if (v != await Global.latestTag) {
      Loading.hide();
      toast('Plz update');
      Navigator.of(context).pushNamed('/update');
    } else {
      Global.sender = controller.text.trim();
      Global.token = md5.convert(utf8.encode(Global.sender)).toString(); //转换
      final res = await Global.chatMessagesController.connect();
      //success
      _saveRecentlyUsed(Global.sender);
      Loading.hide();
      if (res) {
        await Navigator.pushNamed(context, '/box');
      }
    }
  }
}
