/// xhzq_test - simple_text_field
/// Created by xhz on 24/04/2022
import 'package:chat_box/global.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key, required this.focusNode, required this.controller}) : super(key: key);
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Global.cbSendButtonBackground, width: 3.0),
          color: Global.cbPrimaryColor,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        autocorrect: false,
        focusNode: focusNode,
        decoration: const InputDecoration.collapsed(hintText: 'Input ur Name'),
      ),
    );
  }
}
