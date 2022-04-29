import 'dart:developer';

import 'package:chat_box/global.dart';
import 'package:chat_box/utils/platform_api/platform_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/utils/global_loading.dart';
import 'package:chat_box/welcome_page.dart';

void main() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  }
  PlatformApi.setSelectNotificationCallback((payload) {
    log('$payload');
  });

  runApp(MaterialApp(
    title: 'Chat Box',
    theme: Global.theme,
    initialRoute: '/',
    routes: {
      '/': (ctx) {
        GlobalOverlayContext.overlayState ??= Overlay.of(ctx);
        return WelcomePage();
      }
    },
    locale: const Locale('en', 'US'),
  ));
}
