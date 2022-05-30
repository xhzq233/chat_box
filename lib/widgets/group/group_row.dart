/// chat_box - group_row
/// Created by xhz on 29/05/2022
import 'package:chat_box/widgets/group/group_avatar.dart';
import 'package:chat_box/widgets/list_view/chat_list_source.dart';
import 'package:flutter/material.dart';

import '../../controller/message/message_controller.dart';

class GroupRow extends StatelessWidget {
  const GroupRow({Key? key, required this.source}) : super(key: key);
  final ChatListSource source;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GroupAvatar(
        group: source.group,
      ),
      onTap: () async {
        ChatMessagesController.shared.currentGroupID = source.group.id; //更改当前群组id
        await Navigator.pushNamed(context, '/box');
        (context as Element).markNeedsBuild();
      },
      title: Text(source.group.name),
      subtitle: Text(source.last.content),
    );
  }
}
