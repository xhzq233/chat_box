/// chat_box - group_avatar
/// Created by xhz on 29/05/2022
import 'package:chat_box/model/group.dart';
import 'package:chat_box/pages/groups/group_detail.dart';
import 'package:flutter/material.dart';

import '../../global.dart';

class GroupAvatar extends StatelessWidget {
  const GroupAvatar({Key? key, required this.group}) : super(key: key);
  final Group group;

  String get name => group.name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GroupDetailPage(
                      name: name,
                      hero: '$name$hashCode',
                    )));
      },
      child: LayoutBuilder(
          builder: (ctx, con) => Hero(
              tag: '$name$hashCode',
              child: ClipOval(
                child: Container(
                  height: con.maxHeight,
                  width: con.maxHeight,
                  color: Global.cbPrimaryColor,
                  child: Center(
                    child: Text(
                      String.fromCharCode(group.name.runes.first),
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
              ))),
    );
  }
}
