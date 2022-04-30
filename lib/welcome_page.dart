/// chat_box - welcome_page
/// Created by xhz on 22/04/2022
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:chat_box/global.dart';
import 'package:chat_box/simple_text_field.dart';
import 'package:chat_box/utils/auto_request_node.dart';
import 'package:chat_box/utils/platform_api/platform_api.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:chat_box/utils/loading.dart';
import 'package:chat_box/utils/toast.dart';
import 'chat_content/chat_box.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key);

  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Column(
        children: [
          CustomTextField(
            controller: _controller,
            focusNode: _focusNode,
          ),
          Expanded(
            child: AutoUnFocusWrap(
                focusNode: _focusNode,
                child: Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        // debugDumpApp();
                        Loading.show();
                        final v = await PlatformApi.appVersion;
                        final res = await http.get(Uri.parse('https://images.xhzq.xyz/version'));
                        if (v != res.body) {
                          Loading.hide();
                          toast('Plz update');
                          Navigator.of(context).pushNamed('/update');
                        } else {
                          Global.sender = _controller.text.trim();
                          Global.token = md5.convert(utf8.encode(Global.sender)).toString(); //转换
                          final res = await Global.chatMessagesController.connect();
                          Loading.hide();
                          if (res) {
                            await Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatBox()));
                          }
                        }
                      },
                      child: const Text('connect')),
                )),
          ),
        ],
      ),
    );
  }
}
