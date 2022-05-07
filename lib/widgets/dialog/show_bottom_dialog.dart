/// chat_box - show_bottom_dialog
/// Created by xhz on 07/05/2022
import 'package:flutter/material.dart';

void showBottomDialog(BuildContext context) async {
  Navigator.push(
      context,
      PageRouteBuilder(transitionsBuilder:
          (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, child) {
        // final scaleValue = 0.3 * animation.value;
        //
        // final trans = Matrix4.identity(); //from 0.7 to 1
        // trans.translate(_imageCenterInGlobal.dx, _imageCenterInGlobal.dy);
        // trans.scale(0.7 + scaleValue);
        // trans.translate(_imageCenterInGlobal.dx, _imageCenterInGlobal.dy - Global.screenHeight / 2);
        // log('$_imageCenterInGlobal,${Global.screenSize}');
        return child;
      }, pageBuilder: (BuildContext ctx, Animation<double> animation, Animation<double> secondaryAnimation) {
        return Container(
          color: Colors.transparent,
          child: const Text('data'),
        );
      }));
}
