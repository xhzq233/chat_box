/// chat_box - group_row
/// Created by xhz on 29/05/2022
import 'package:chat_box/widgets/group/group_avatar.dart';
import 'package:chat_box/widgets/list_view/chat_list_source.dart';
import 'package:flutter/material.dart';

class GroupRow extends StatelessWidget {
  const GroupRow({Key? key, required this.source, required this.onTap}) : super(key: key);
  final ChatListSource source;
  final void Function(ChatListSource) onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GroupAvatar(
        group: source.group,
      ),
      onTap: () => onTap(source),
      title: Text(source.group.name),
      subtitle: Text(source.last.content),
    );
  }
}
