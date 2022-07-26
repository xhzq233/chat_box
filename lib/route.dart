/// chat_box - route
/// Created by xhz on 02/06/2022
import 'dart:math';
import 'package:chat_box/global.dart';
import 'package:flutter/material.dart';

PageRouteBuilder<T> buildWaveTransitionRoute<T>(Widget widget, Offset offset) {
  final Size size = Global.screenSize;
  final double circleRadius;
  if (offset.dx > size.width / 2) {
    if (offset.dy > size.height / 2) {
      circleRadius = sqrt(pow(offset.dx, 2) + pow(offset.dy, 2));
    } else {
      circleRadius = sqrt(pow(offset.dx, 2) + pow(size.height - offset.dy, 2));
    }
  } else {
    if (offset.dy > size.height / 2) {
      circleRadius = sqrt(pow(size.width - offset.dx, 2) + pow(offset.dy, 2));
    } else {
      circleRadius = sqrt(pow(size.width - offset.dx, 2) + pow(size.height - offset.dy, 2));
    }
  }
  return PageRouteBuilder<T>(
    transitionDuration: const Duration(seconds: 1),
    pageBuilder: (_, __, ___) => widget,
    opaque: false,
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> _,
      Widget child,
    ) {
      final r = circleRadius * animation.value;
      final d = r * 2;
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: offset.dy - r,
            left: offset.dx - r,
            child: SizedBox(
              height: d,
              width: d,
              child: ClipOval(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: r - offset.dy,
                        left: r - offset.dx,
                        width: size.width,
                        height: size.height,
                        child: Center(
                          child: child,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
