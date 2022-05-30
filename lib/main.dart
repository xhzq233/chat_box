import 'dart:developer';
import 'package:chat_box/controller/account/account_controller.dart';
import 'package:chat_box/pages/chat_content/chat_box.dart';
import 'package:chat_box/global.dart';
import 'package:chat_box/pages/main_page.dart';
import 'package:chat_box/pages/settings/settings_page.dart';
import 'package:chat_box/pages/update/update_page.dart';
import 'package:chat_box/pages/user/connect_page.dart';
import 'package:chat_box/pages/groups/join_group.dart';
import 'package:chat_box/utils/theme/theme_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/utils/utils.dart';
import 'package:chat_box/pages/welcome_page/welcome_page.dart';
import 'controller/api/api.dart';

void checkV(BuildContext context) async {
  final v = await PlatformApi.appVersion;
  Api.latestTag.then((value) {
    if (v != value) {
      toast('Plz update');
      Navigator.of(context).pushNamed('/update');
    }
  }, onError: (_) => toast('check version failed'));
}

void main() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  }
  PlatformApi.setSelectNotificationCallback((payload) {
    log('$payload');
  });

  await AccountController.shared.init();
  await ThemeNotifier.initThemeMode();

  runApp(ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeNotifier.shared,
      builder: (_, mode, __) => MaterialApp(
            title: 'Chat Box',
            theme: Global.lightTheme,
            darkTheme: Global.darkTheme,
            themeMode: mode,
            initialRoute: '/',
            routes: {
              '/': (_) => const MainEntry(),
              '/update': (_) => const UpdatePage(),
              '/settings': (_) => const SettingsPage(),
              '/box': (_) => const ChatBox(),
              '/main': (_) => const ChatGroupsMainPage(),
              '/connect': (_) => const ConnectPage(),
              '/add_account': (_) => const WelcomePage(),
              '/add_group': (_) => const JoinGroupsPage(),
            },
            locale: const Locale('en', 'US'),
          )));
}

class MainEntry extends StatefulWidget {
  const MainEntry({Key? key}) : super(key: key);

  @override
  State<MainEntry> createState() => _MainEntryState();
}

class _MainEntryState extends State<MainEntry> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      GlobalOverlayContext.overlayState ??= Overlay.of(context);
      checkV(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('build');
    if (AccountController.shared.haveAccount) {
      return const ConnectPage();
    }
    return const WelcomePage();
  }
}
