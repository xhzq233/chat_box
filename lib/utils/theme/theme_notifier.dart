/// chat_box - theme_notifier
/// Created by xhz on 30/05/2022

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier implements ValueListenable<ThemeMode> {
  static ThemeNotifier get shared => _instance!;
  static ThemeNotifier? _instance;
  static const _themeSPKey = 'theme';
  static late final SharedPreferences _sp;

  static Future<void> initThemeMode() async {
    _sp = await SharedPreferences.getInstance();
    if (_sp.containsKey(_themeSPKey)) {
      _instance = ThemeNotifier._(_sp.getString(_themeSPKey)!);
    } else {
      _instance = ThemeNotifier._('dark');
      _sp.setString(_themeSPKey, _instance.toString());
    }
  }

  ThemeNotifier._(String str) {
    switch (str) {
      case 'Dark':
        _value = ThemeMode.dark;
        break;
      case 'Light':
        _value = ThemeMode.light;
        break;
      case 'System':
        _value = ThemeMode.system;
        break;
      default:
        _value = ThemeMode.dark;
    }
  }

  @override
  ThemeMode get value => _value;
  late ThemeMode _value;

  set value(ThemeMode newValue) {
    if (_value == newValue) return;
    _value = newValue;
    _sp.setString(_themeSPKey, _instance.toString());
    notifyListeners();
  }

  @override
  String toString() {
    switch (value) {
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.system:
        return 'System';
      default:
        return 'Dark';
    }
  }
}
