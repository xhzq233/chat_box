/// chat_box - settings_page
/// Created by xhz on 06/05/2022
import 'package:chat_box/global.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDark = Global.themeModeNotifier.value == ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(isDark ? 'DarkMode' : 'LightMode'),
              Switch.adaptive(
                  value: isDark,
                  onChanged: (to) {
                    isDark = to;
                    Global.changeTheme(isDark);
                    (context as Element).markNeedsBuild();
                  })
            ],
          )
        ],
      ),
    );
  }
}
