/// chat_box - cb_tf_with_button
/// Created by xhz on 30/05/2022
import 'package:chat_box/widgets/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';

class CBTextFieldWithTrailingButton extends CBTextField {
  const CBTextFieldWithTrailingButton(
      {Key? key,
      TextEditingController? controller,
      void Function(String)? onChanged,
      FocusNode? focusNode,
      required this.buttonTitle,
      required String hintText,
      required this.onPressed})
      : super(key: key, controller: controller, focusNode: focusNode, onChanged: onChanged, hintText: hintText);

  final VoidCallback onPressed;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(child: super.build(context),),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            child: ElevatedButton(onPressed: onPressed, child: Text(buttonTitle)),
            padding: const EdgeInsets.only(right: 15, top: 5, bottom: 5),
          ),
        )
      ],
    );
  }
}
