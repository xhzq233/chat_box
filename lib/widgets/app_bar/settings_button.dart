/// chat_box - settings_button
/// Created by xhz on 29/05/2022
import 'package:flutter/material.dart';

class SettingsAppBarButton extends StatelessWidget {
  const SettingsAppBarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      tooltip: 'Settings',
      onPressed: () => Navigator.pushNamed(context, '/settings'),
    );
  }
}
