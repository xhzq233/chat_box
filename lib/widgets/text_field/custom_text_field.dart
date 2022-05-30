/// chat_box - custom_text_field
/// Created by xhz on 30/05/2022
import 'package:flutter/material.dart';
import '../../global.dart';

class CBTextField extends StatelessWidget {
  const CBTextField({Key? key, this.controller, this.onChanged, this.focusNode, required this.hintText})
      : super(key: key);
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Global.cbPrimaryColor, width: 3.0), borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        autocorrect: false,
        focusNode: focusNode,
        onChanged: onChanged,
        decoration: InputDecoration.collapsed(hintText: hintText),
      ),
    );
  }
}
