/// chat_box - send_image_btn
/// Created by xhz on 29/04/2022
import 'dart:developer';
import 'package:chat_box/utils/toast.dart';
import 'package:flutter/material.dart';
import '../global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';

class SendImageButton extends StatelessWidget {
  const SendImageButton({Key? key}) : super(key: key);

  //return img url
  void _selectAndUploadImage() async {
    final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (null == picker) {
      toast("Something went wrong");
      return;
    }
    toast(picker.path);
    var result = await FlutterImageCompress.compressWithFile(
      picker.path,
      minWidth: 1200,
      minHeight: 1200,
      quality: 88,
    );
    if (null == result) {
      toast("Compress Image went wrong");
      return;
    }
    final res = await http.post(Uri.parse(Global.https + Global.imageHost),
        headers: {'content-type': 'image/' + picker.name.split('.').last}, body: result);
    if (res.statusCode == 200) {
      //body 是储存file的名字
      Global.chatMessagesController.send(res.body, true);
    } else {
      toast('Error code: ${res.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ClipOval(
          child: GestureDetector(
            onTap: _selectAndUploadImage,
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
