/// chat_box - main_view
/// Created by xhz on 20/05/2022
import 'package:chat_box/controller/account/account_controller.dart';
import 'package:chat_box/widgets/app_bar/add_group.dart';
import 'package:chat_box/widgets/group/group_row.dart';
import 'package:flutter/material.dart';
import '../controller/message/message_controller.dart';
import '../widgets/app_bar/settings_button.dart';

class ChatGroupsMainPage extends StatefulWidget {
  const ChatGroupsMainPage({Key? key}) : super(key: key);

  @override
  State<ChatGroupsMainPage> createState() => _ChatGroupsMainPageState();
}

class _ChatGroupsMainPageState extends State<ChatGroupsMainPage> {
  @override
  void initState() {
    super.initState();
    ChatMessagesController.shared
      ..startListen()
      ..bindObserver(context);
  }

  @override
  void dispose() {
    ChatMessagesController.shared
      ..close()
      ..removeObserver();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AccountController.shared.mainAccount!.friendlyName),
          actions: const [SettingsAppBarButton(), AddMoreGroupAppBarButton()],
        ),
        body: RefreshIndicator(
          onRefresh: ChatMessagesController.shared.fetchGroups,
          child: ChatMessagesController.shared.messages.isEmpty
              ? ListTile(
                  leading: const Icon(Icons.group_add),
                  title: const Text('No groups here.'),
                  subtitle: const Text('Tap to add more.'),
                  onTap: () async {
                    await Navigator.pushNamed(context, '/add_group');
                    (context as Element).markNeedsBuild();
                  },
                )
              : ListView.builder(
                  itemCount: ChatMessagesController.shared.messages.length,
                  itemExtent: 72,
                  itemBuilder: (BuildContext context, int index) {
                    return GroupRow(source: ChatMessagesController.shared.messages.values.elementAt(index));
                  },
                ),
        ));
  }
}