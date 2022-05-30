/// chat_box - text_field
/// Created by xhz on 29/05/2022
import 'package:chat_box/controller/message/message_controller.dart';
import 'package:flutter/material.dart';
import '../chat_box/send_image_btn.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({Key? key, required this.controller, required this.node, required this.notifier})
      : super(key: key);
  final TextEditingController controller;
  final FocusNode node;
  final ValueNotifier<bool> notifier;

  void _send() {
    ChatMessagesController.shared.send(controller.text.trim());
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: SendImageButton()),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                flex: 8,
                child: TextField(
                  // style: const TextStyle(color: Global.cbOnBackground),
                  focusNode: node,
                  controller: controller,
                  autocorrect: false,
                  onChanged: (_) {
                    notifier.value = controller.text.isNotEmpty;
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Message",
                      suffix: ValueListenableBuilder<bool>(
                          valueListenable: notifier,
                          builder: (BuildContext context, value, Widget? child) => ElevatedButton(
                                onPressed: value ? _send : null,
                                child: const Text('send'),
                              ))),
                  onSubmitted: (_) {
                    _send.call();
                  },
                )),
          ],
        ));
  }
}
