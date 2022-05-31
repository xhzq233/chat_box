/// xhzq_test - avatar
/// Created by xhz on 26/04/2022
import 'package:chat_box/global.dart';
import 'package:chat_box/pages/user/user_page.dart';
import 'package:flutter/material.dart';
import '../../model/account.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key, required this.account, this.onSuccessfullyChanged}) : super(key: key);
  final Account account;
  final void Function(BuildContext)? onSuccessfullyChanged;

  String get name => account.friendlyName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final res = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserPage(
                      account: account,
                      hero: '$name$hashCode',
                    )));
        if (res == true) {
          onSuccessfullyChanged?.call(context);
        }
      },
      child: Hero(
        tag: '$name$hashCode',
        child: ClipOval(
          child: Container(
            height: 32,
            width: 32,
            color: Global.cbPrimaryColor,
            child: Center(
              child: Text(
                String.fromCharCode(name.runes.first),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    debugLabel: 'blackCupertino bodyMedium',
                    fontFamily: '.SF UI Text',
                    color: Colors.black87,
                    fontSize: 16,
                    decoration: TextDecoration.none),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
