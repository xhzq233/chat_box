/// chat_box - welcome_page
/// Created by xhz on 22/04/2022
import 'package:chat_box/utils/auto_request_node.dart';
import 'package:chat_box/pages/welcome_page/controller.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/global.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late final _controller = WelcomePageController(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            key: _controller.textFieldKey,
            decoration: BoxDecoration(
                border: Border.all(color: Global.cbPrimaryColor, width: 3.0),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: TextField(
              controller: _controller.controller,
              autocorrect: false,
              focusNode: _controller.focusNode,
              decoration: const InputDecoration.collapsed(hintText: 'Input ur Name'),
            ),
          ),
          Expanded(
            child: AutoUnFocusWrap(
                focusNode: _controller.focusNode,
                child: Center(
                  child: ElevatedButton(onPressed: _controller.onPressConnect, child: const Text('connect')),
                )),
          ),
        ],
      ),
    );
  }
}
