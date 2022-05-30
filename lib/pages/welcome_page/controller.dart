/// chat_box - controller
/// Created by xhz on 06/05/2022
import 'package:chat_box/controller/api/api_client.dart';
import 'package:chat_box/utils/toast.dart';
import 'package:chat_box/utils/validators.dart';
import 'package:flutter/material.dart';

class WelcomePageController {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  late final BuildContext context;
  final codeNode = FocusNode();

  void onPressSendCode() async {
    final number = controller.text.trim();
    final res = Validators.qqNumber(number);
    if (res != '') {
      toast(res);
      return;
    }
    // debugDumpApp();
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (
    //       ctx,
    //     ) =>
    //             const ImageDetailPage(
    //               name: "ff9c1dbbf12d5c4c824c07297945d09af3f9b7b3.jpg",
    //               heroTag: 1,
    //             )));
    email = number + '@qq.com';
    try {
      await ApiClient.sendCode(email);
      showVerify.value = true;
    } catch (_) {}
  }

  String email = '';
  final showVerify = ValueNotifier(false);

  void onPressVerify(String code) async {
    try {
      await ApiClient.register(email, code);
      Navigator.pushNamedAndRemoveUntil(context, '/connect',(_) => false);
    } catch (_) {}
  }
}
