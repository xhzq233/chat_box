import 'dart:developer';

import 'package:chat_box/chat_content/chat_box.dart';
import 'package:chat_box/global.dart';
import 'package:chat_box/settings/settings_page.dart';
import 'package:chat_box/update/update_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/utils/utils.dart';
import 'package:chat_box/welcome_page/welcome_page.dart';

void main() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  }
  PlatformApi.setSelectNotificationCallback((payload) {
    log('$payload');
  });

  runApp(ValueListenableBuilder<ThemeMode>(
      valueListenable: Global.notifier,
      builder: (_, mode, __) => MaterialApp(
            title: 'Chat Box',
            theme: Global.lightTheme,
            darkTheme: Global.darkTheme,
            themeMode: mode,
            initialRoute: '/',
            routes: {
              '/': (ctx) {
                GlobalOverlayContext.overlayState ??= Overlay.of(ctx);
                return const WelcomePage();
              },
              '/update': (_) => const UpdatePage(),
              '/settings': (_) => const SettingsPage(),
              '/box': (_) => const ChatBox(),
            },
            locale: const Locale('en', 'US'),
          )));
}
