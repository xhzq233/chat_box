/// chat_box - verify_pop_up_view
/// Created by xhz on 29/05/2022
import 'package:chat_box/global.dart';
import 'package:chat_box/utils/utils.dart';
import 'package:chat_box/widgets/text_field/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyView extends StatefulWidget {
  const VerifyView({Key? key, required this.onPressVerify, this.focusNode}) : super(key: key);
  final void Function(String) onPressVerify;
  final FocusNode? focusNode;

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  final controller = TextEditingController();

  late final FocusNode focusNode = widget.focusNode ?? FocusNode();

  String get wrongHint => Validators.code(controller.text);

  bool get isPassed => wrongHint.isEmpty;
  final passed = ValueNotifier(false);
  final isShowHint = ValueNotifier(false);

  @override
  void initState() {
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        //当键盘消失时，再rebuild一遍
        ///没有初始文本，没有通过，键盘收起情况下为真
        isShowHint.value = controller.text.isNotEmpty && !isPassed && !focusNode.hasFocus;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CBTextField(
            controller: controller,
            focusNode: focusNode,
            onChanged: (_) {
              passed.value = isPassed;
            },
            hintText: 'input verification code'),
        ValueListenableBuilder<bool>(
          valueListenable: isShowHint,
          child: Text('*' + wrongHint, style: Global.tsWarning),
          builder: (_, value, c) => Visibility(
            child: c!,
            visible: value, //没有键盘的时候
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: passed,
          builder: (BuildContext context, bool value, _) => CupertinoButton(
              onPressed: value ? () => widget.onPressVerify(controller.text) : null, child: const Text('Login')),
        ),
      ],
    );
  }
}
