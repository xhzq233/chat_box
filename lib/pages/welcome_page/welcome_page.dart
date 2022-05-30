/// chat_box - welcome_page
/// Created by xhz on 22/04/2022
import 'package:chat_box/utils/auto_request_node.dart';
import 'package:chat_box/pages/welcome_page/controller.dart';
import 'package:chat_box/widgets/app_bar/settings_button.dart';
import 'package:chat_box/widgets/text_field/cb_tf_with_button.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/global.dart';
import '../../widgets/verify/verify_pop_up_view.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late final _controller = WelcomePageController()..context = context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        actions: const [SettingsAppBarButton()],
      ),
      body: Column(
        children: [
          Global.defaultSpacing,
          const Text.rich(TextSpan(text: "Press ", children: [
            TextSpan(text: 'SendCode', style: Global.tsWarning),
            TextSpan(text: ' to save ur account Locally'),
          ])),
          CBTextFieldWithTrailingButton(
            buttonTitle: 'SendCode',
            hintText: 'Input ur QQ number',
            onPressed: _controller.onPressSendCode,
            controller: _controller.controller,
            focusNode: _controller.focusNode,
          ),
          Expanded(
            child: AutoUnFocusWrap(
                focusNodes: [_controller.focusNode, _controller.codeNode],
                child: Column(
                  children: [
                    ValueListenableBuilder<bool>(
                        valueListenable: _controller.showVerify,
                        builder: (_, value, __) => Visibility(
                            visible: value,
                            child: VerifyView(
                              onPressVerify: _controller.onPressVerify,
                              focusNode: _controller.codeNode,
                            ))),
                    const Spacer(
                      flex: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text.rich(TextSpan(
                          text: "An email will be sent to ur QQ email to confirm your account\n"
                              "The interval of sending each verification code must be greater than ten minutes, ",
                          children: [
                            TextSpan(text: 'or the consequences will be borne by yourself\n', style: Global.tsWarning),
                            TextSpan(
                                text: 'Unregistered accounts will be created automatically', style: Global.tsWarning)
                          ])),
                    ),
                    const Spacer(),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
