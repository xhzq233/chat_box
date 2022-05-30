/// chat_box - join_group
/// Created by xhz on 30/05/2022
import 'dart:developer';

import 'package:chat_box/controller/api/api_client.dart';
import 'package:chat_box/model/group.dart';
import 'package:chat_box/utils/toast.dart';
import 'package:chat_box/widgets/app_bar/add_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_bar/settings_button.dart';
import '../../widgets/group/group_avatar.dart';

class JoinGroupsPage extends StatefulWidget {
  const JoinGroupsPage({Key? key}) : super(key: key);

  @override
  State<JoinGroupsPage> createState() => _JoinGroupsPageState();
}

class _JoinGroupsPageState extends State<JoinGroupsPage> {
  final List<Group> groups = [];

  Future<void> _fetchGroups() async {
    try {
      groups.clear();
      groups.addAll(await ApiClient.getAllGroups());
      final ele = context as Element;
      if (!ele.dirty) {
        ele.markNeedsBuild();
      }
    } catch (_) {
      log('init groups err');
    }
  }

  @override
  void initState() {
    _fetchGroups();
    super.initState();
  }

  void _joinGroup(int id) async {
    try {
      ApiClient.joinGroup(id);
      toast('joined successfully');
      Navigator.pop(context);
    } catch (e) {
      log('join group err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Popular Groups'),
          actions: const [SettingsAppBarButton(), AddMoreAppBarButton()],
        ),
        body: RefreshIndicator(
          onRefresh: _fetchGroups,
          child: ListView.builder(
            itemCount: groups.length,
            itemExtent: 72,
            itemBuilder: (BuildContext context, int index) {
              final g = groups[index];
              return ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(5),
                  child: GroupAvatar(
                    group: g,
                  ),
                ),
                onTap: () => _joinGroup(g.id),
                title: Text(g.name),
              );
            },
          ),
        ));
  }
}
