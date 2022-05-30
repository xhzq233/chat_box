/// chat_box - group_detail
/// Created by xhz on 30/05/2022
import 'package:flutter/material.dart';
import 'package:chat_box/global.dart';

class GroupDetailPage extends StatelessWidget {
  const GroupDetailPage({Key? key, required this.name, required this.hero}) : super(key: key);
  final String name;
  final String hero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Detail'),
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
      ),
    );
  }
}
