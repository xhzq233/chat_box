/// chat_box - add_botton
/// Created by xhz on 29/05/2022
import 'package:flutter/material.dart';

class AddMoreAppBarButton extends StatelessWidget {
  const AddMoreAppBarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.person_add_sharp),
      tooltip: 'Add',
      onPressed: () => Navigator.pushNamed(context, '/add_account'),
    );
  }
}