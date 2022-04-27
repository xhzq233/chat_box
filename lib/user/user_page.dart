/// chat_box - user
/// Created by xhz on 26/04/2022
import 'package:flutter/material.dart';

import '../global.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key, required this.name,required this.hero}) : super(key: key);
  final String name;
  final String hero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: Center(
        child: Hero(
          tag: hero,
          child: ClipOval(
            child: Container(
              height: 128,
              width: 128,
              color: Global.cbPrimaryColor,
              child: Center(
                child: Text(
                  name,
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
      ),
    );
  }
}
