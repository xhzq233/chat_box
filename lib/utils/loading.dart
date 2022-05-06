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
        child: const Center(
          child: CircularProgressIndicator(),
        )),
  );

  static void show() {
    GlobalOverlayContext.overlayState!.insert(_entry);
  }

  static void hide() {
    _entry.remove();
  }
}
