/// chat_box - send_image_btn
/// Created by xhz on 29/04/2022
import 'dart:developer';
import 'package:chat_box/utils/loading.dart';
import 'package:chat_box/utils/toast.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import '../global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class SendImageButton extends StatelessWidget {
  const SendImageButton({Key? key}) : super(key: key);

  Future<bool> _checkServerImageExist(String name) async {
    final res = await http.post(Uri.parse(Global.https + Global.imageHost + "check/" + name));
    if (res.statusCode == 200 && res.body == "ok") {
      return true;
    } else {
      return false;
    }
  }

  //return img url
  void _selectAndUploadImage(bool gif) async {
    final picker = await ImagePicker().pickImage(maxWidth: gif ? null : 1200, source: ImageSource.gallery);

    if (null == picker) {
      toast("Something went wrong");
      return;
    }
    Loading.show();
    final bytes = await picker.readAsBytes();
    final featBuf = bytes.sublist(0, 1024); //取前1kb
    final hash = sha1.convert(featBuf);
    final ex = picker.name.split('.').last;
    final hashName = '$hash.$ex';
    final exist = await _checkServerImageExist(hashName);
    if (exist) {
      toast('Server already holds this image');
      Global.chatMessagesController.send(hashName, true);
    } else {
      final res = await http.post(Uri.parse(Global.https + Global.imageHost),
          headers: {'content-type': 'image/' + ex}, body: bytes); //upload
      if (res.statusCode == 200) {
        //body 是储存file的名字
        Global.chatMessagesController.send(res.body, true);
      } else {
        toast('Error code: ${res.statusCode}');
      }
    }
    Loading.hide();
  }

  void _chooseType(BuildContext context) async {
    final res = await showDialog<bool>(
        context: context,
        builder: (ctx) {
          return AlertDialog(content: const Text('Please choose the type of image'), actions: [
            TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('GIF')),
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Other'))
          ]);
        });
    if (res != null) {
      _selectAndUploadImage(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ClipOval(
          child: GestureDetector(
            onTap: () => _chooseType(context),
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
