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
                        final v = await PlatformApi.appVersion;
                        final res = await http.get(Uri.parse('https://images.xhzq.xyz/version'));
                        if (v != res.body) {
                          toast('Plz update');
                        } else {
                          Loading.show();
                          final sender = _controller.text.trim();
                          final bytes = utf8.encode(sender);
                          final encrypted = md5.convert(bytes).toString();
                          try {
                            final socket =
                                await WebSocket.connect(Global.wss + Global.wsHost, headers: {'Auth': encrypted});
                            Global.sender = sender; //登陆成功
                            Global.token = encrypted;
                            Loading.hide();
                            await Navigator.push(
                                context, MaterialPageRoute(builder: (context) => ChatBox(socket: socket)));
                          } catch (e) {
                            Loading.hide();
                            toast('Error');
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
