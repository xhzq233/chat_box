/// chat_box - add_group
/// Created by xhz on 30/05/2022
import 'package:flutter/material.dart';

class AddMoreGroupAppBarButton extends StatelessWidget {
  const AddMoreGroupAppBarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.group_add),
      tooltip: 'Add',
      onPressed: () => Navigator.pushNamed(context, '/add_group'),
    );
  }
}