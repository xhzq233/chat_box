/// chat_box - loading
/// Created by xhz on 22/04/2022
import 'package:flutter/material.dart';

class GlobalOverlayContext {
  // static late BuildContext overlayContext;
  static OverlayState? overlayState;
//app -> MediaQuery -> Directionality -> ScaffoldMessenger -> navigator -> overlay -> home
}

class Loading {
  static final _entry = OverlayEntry(
    builder: (_) => Container(
        color: Colors.black12,
        child: const RepaintBoundary(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )),
  );
  static bool _showing = false;

  static void show() {
    if (_showing) return;
    GlobalOverlayContext.overlayState!.insert(_entry);
    _showing = true;
  }

  static void hide() {
    if (!_showing) return;
    _entry.remove();
    _showing = false;
  }
}
