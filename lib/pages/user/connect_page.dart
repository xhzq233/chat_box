/// chat_box - connect_page
/// Created by xhz on 28/05/2022
import 'dart:math';

import 'package:chat_box/controller/account/account_controller.dart';
import 'package:chat_box/utils/toast.dart';
import 'package:chat_box/widgets/app_bar/add_button.dart';
import 'package:chat_box/widgets/user/avatar.dart';
import 'package:chat_box/widgets/user/management_user_avatar.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_bar/settings_button.dart';

class ConnectPage extends StatelessWidget {
  const ConnectPage({Key? key}) : super(key: key);

  void _conn(BuildContext context) async {
    final res = await AccountController.shared.login();
    if (res) {
      Navigator.pushNamed(context, '/main');
    }
  }

  Future<bool> _willPop() async {
    if (null == _lastPopTime || DateTime.now().difference(_lastPopTime!) > const Duration(seconds: 1)) {
      _lastPopTime = DateTime.now();
      toast('return again to exit.');
      return false;
    } else {
      return true;
    }
  }

  static const List<String> sayings = [
    'Ready to Connect?',
    'The proletarians have nothing to lose but their chains.',
    'Let the ruling classes tremble at a Communistic revolution.',
    'xhzq\'s masterpiece.',
    'Long live the Communist Party!',
    'Ready to enter the new world.',
    'Workers of the world, unite!',
    'Proletarier aller Länder vereinigt Euch!',
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: FittedBox(
              child: Text(sayings[Random.secure().nextInt(sayings.length)]),
            ),
            actions: const [SettingsAppBarButton(), AddMoreAppBarButton()],
          ),
          body: Column(
            children: [
              Builder(
                builder: (ctx) => UserAccountsDrawerHeader(
                  currentAccountPicture: UserAvatar(
                    account: AccountController.shared.mainAccount!,
                    onSuccessfullyChanged: (_) => (ctx as Element).markNeedsBuild(),
                  ),
                  otherAccountsPictures: AccountController.shared.otherAccounts
                      ?.map((e) => ManagementUserAvatar(
                            account: e,
                            onSuccessfullyChanged: (popupContext) {
                              Navigator.pop(popupContext);
                              (ctx as Element).markNeedsBuild(); //缩小rebuild
                            },
                          ))
                      .toList(),
                  accountEmail: Text(AccountController.shared.mainAccount!.email),
                  accountName: Text(AccountController.shared.mainAccount!.friendlyName),
                ),
              ),
              const Spacer(),
              ElevatedButton(onPressed: () => _conn(context), child: const Text('Connect')),
              const Spacer(),
            ],
          ),
        ),
        onWillPop: _willPop);
  }
}

DateTime? _lastPopTime;
