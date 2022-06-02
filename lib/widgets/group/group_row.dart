/// chat_box - group_row
/// Created by xhz on 29/05/2022
import 'package:chat_box/utils/toast.dart';
import 'package:chat_box/widgets/group/group_avatar.dart';
import 'package:chat_box/widgets/list_view/chat_list_source.dart';
import 'package:flutter/material.dart';

import '../dialog/more_action.dart';

class GroupRow extends StatelessWidget {
  const GroupRow({Key? key, required this.source, required this.onTap, this.onTriggerLeaveGroup}) : super(key: key);
  final ChatListSource source;
  final void Function(ChatListSource) onTap;
  final void Function(ChatListSource)? onTriggerLeaveGroup;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: ((details) => Navigator.push(
          context,
          RawDialogRoute(
              barrierColor: Colors.transparent,
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (_, animation, ___) => Stack(
                    children: [
                      MoreActionsPopUpView(
                          animation: CurvedAnimation(parent: animation, curve: Curves.ease),
                          actions: {
                            'Leave': () => onTriggerLeaveGroup?.call(source),
                            'Mute': () => toast('not supported yet'),
                            'UnMute': () => toast('not supported yet'),
                          },
                          preferredPosition: details.globalPosition),
                    ],
                  )))),
      child: ListTile(
        leading: GroupAvatar(
          group: source.group,
        ),
        onTap: () => onTap(source),
        title: Text(source.group.name),
        subtitle: Text(source.newest.content),
      ),
    );
  }
}
