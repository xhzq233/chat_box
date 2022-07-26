/// chat_box - settings_page
/// Created by xhz on 06/05/2022
import 'package:chat_box/global.dart';
import 'package:chat_box/route.dart';
import 'package:chat_box/utils/theme/theme_notifier.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  bool get isDark => ThemeNotifier.shared.value == ThemeMode.dark;

  bool get isSys => ThemeNotifier.shared.value == ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Follow System Theme Mode'),
            subtitle: Text('Current: ' + (isSys ? 'System' : 'Custom')),
            trailing: Builder(
              builder: (ctx) => Switch.adaptive(
                  value: isSys,
                  onChanged: (to) async {
                    ThemeNotifier.shared.value = to ? ThemeMode.system : ThemeMode.dark;
                    (context as Element).markNeedsBuild();
                  }),
            ),
          ),
          ListTile(
            title: const Text('Use Dark Appearance'),
            subtitle: Text('Current: ' + ThemeNotifier.shared.toString()),
            trailing: Builder(
                builder: (ctx) => Switch.adaptive(
                    value: isDark,
                    onChanged: isSys
                        ? null
                        : (to) {
                            ThemeNotifier.shared.value = to ? ThemeMode.dark : ThemeMode.light;
                            (context as Element).markNeedsBuild();
                          })),
          ),
        ],
      ),
    );
  }
}
