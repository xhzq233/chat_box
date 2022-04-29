/// chat_box - send_image_btn
/// Created by xhz on 29/04/2022
import 'package:chat_box/utils/toast.dart';
import 'package:flutter/material.dart';
import '../global.dart';

class SendImageButton extends StatelessWidget {
  const SendImageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ClipOval(
          child: GestureDetector(
            onTap: () {
              toast('Not support yet');
            },
            child: Container(
              color: Global.cbPrimaryColor,
              width: constraints.maxWidth,
              height: constraints.maxWidth,
              child: const Center(
                child: Text(
                  "+",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, decoration: TextDecoration.none),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
