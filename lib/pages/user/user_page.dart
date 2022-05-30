/// chat_box - user
/// Created by xhz on 26/04/2022
import 'dart:developer';
import 'package:chat_box/controller/account/account_controller.dart';
import 'package:chat_box/controller/api/api_client.dart';
import 'package:chat_box/model/account.dart';
import 'package:chat_box/utils/auto_request_node.dart';
import 'package:chat_box/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/global.dart';
import '../../widgets/text_field/cb_tf_with_button.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key, required this.account, required this.hero}) : super(key: key);
  final Account account;
  final String hero;
  late final _controller = TextEditingController(text: account.friendlyName);
  final _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    log('build user page');
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Detail'),
        ),
        body: AutoUnFocusWrap(
          focusNodes: [_node],
          child: Column(
            children: [
              const Spacer(),
              Hero(
                tag: hero,
                child: ClipOval(
                  child: Container(
                    height: 128,
                    width: 128,
                    color: Global.cbPrimaryColor,
                    child: Center(
                      child: Text(
                        account.friendlyName,
                        style: const TextStyle(
                            debugLabel: 'blackCupertino bodyMedium',
                            fontFamily: '.SF UI Text',
                            color: Colors.black87,
                            fontSize: 16,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              if (account.id == AccountController.shared.mainAccount?.id)
                CBTextFieldWithTrailingButton(
                  buttonTitle: 'ChangeName',
                  hintText: 'Input ur new name',
                  onPressed: () async {
                    try {
                      await ApiClient.changeAccountName(_controller.text.trim());
                      toast('success');
                      Navigator.pop(context, true);
                    } catch (_) {}
                  },
                  controller: _controller,
                  focusNode: _node,
                ),
              const Spacer(),
            ],
          ),
        ));
  }
}
