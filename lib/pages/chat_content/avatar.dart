/// xhzq_test - avatar
/// Created by xhz on 26/04/2022
import 'package:chat_box/global.dart';
import 'package:chat_box/pages/user/user_page.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserPage(
                      name: name,
                      hero: '$name$hashCode',
                    )));
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
                name[0],
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
