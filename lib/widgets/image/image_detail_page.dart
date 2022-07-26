/// chat_box - image_detail_page
/// Created by xhz on 03/05/2022
import 'dart:developer';
import 'package:chat_box/controller/api/api.dart';
import 'package:chat_box/utils/toast.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chat_box/global.dart';

class ImageDetailPage extends StatefulWidget {
  const ImageDetailPage({Key? key, required this.name, required this.heroTag}) : super(key: key);
  final String name;
  final Object heroTag;

  @override
  State<ImageDetailPage> createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late void Function() _animationListener;
  Animation<double>? _animation;

  final threeStage = [Global.screenHeight * 1.0, Global.screenHeight * 0.618, Global.screenHeight * 0.382];

  double _top = Global.screenHeight;
  double _dragStartPoint = 0;
  double _dragEndPoint = 0;

  void _onDragEnd(double dy, [Velocity? velocity]) {
    // log('$dy, $velocity');
    if (dy == 0) return;
    _animationController.removeListener(_animationListener);
    _animationController.stop();
    _animationController.reset();
    final double end; //最后停留位置
    if (dy > 0) {
      if ((dy > 15 && (velocity?.pixelsPerSecond.dy ?? 0) > 1000) || (dy > 80)) {
        end = threeStage[0];
      } else {
        end = threeStage[2];
      }
    } else {
      if ((dy < -15 && (velocity?.pixelsPerSecond.dy ?? 0) < -1000) || (dy < -80)) {
        end = threeStage[2];
      } else {
        end = threeStage[0];
      }
    }
    final begin = _top;
    _animationListener = () {
      _top = _animationController.value * (end - begin) + begin;
      (context as Element).markNeedsBuild();
    };
    _animationController.addListener(_animationListener);
    _animationController.forward();
  }

  @override
  void initState() {
    ScrollView;
    _animationController = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
    _animationListener = () {};
    super.initState();
  }

  @override
  void dispose() {
    _animation?.removeListener(_animationListener);
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mx = Matrix4(
        1,
        0,
        0,
        0,
        0,
        1,
        0,
        0,
        0,
        0,
        1,
        0.0008,
        //表示每1000个pixel, 1/scale=1/(scale+1)
        0,
        0,
        0,
        1)
      ..scale(_top / Global.screenHeight * 0.3 + 0.7, _top / Global.screenHeight * 0.3 + 0.7)
      ..rotateX(0.5 - _top / Global.screenHeight / 2)
      ..translate(0.0, (_top / Global.screenHeight - 1) * 100);

    final img = ExtendedImage.network(
      Api.getImageUrl + widget.name,
      cacheKey: widget.name,
      printError: false,
      mode: ExtendedImageMode.gesture,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return const Padding(
              padding: EdgeInsets.all(5),
              child: Center(child: CircularProgressIndicator()),
            );
          case LoadState.completed:
            return state.completedWidget;
          case LoadState.failed:
            return Center(
              child: IconButton(
                icon: const Icon(Icons.refresh_sharp),
                iconSize: 35,
                onPressed: state.reLoadImage,
              ),
            );
        }
      },
      onDoubleTap: (ExtendedImageGestureState state) {
        ///you can use define pointerDownPosition as you can,
        ///default value is double tap pointer down position.
        var pointerDownPosition = state.pointerDownPosition;
        double? begin = state.gestureDetails?.totalScale;
        double end;

        _animation?.removeListener(_animationListener);
        _animationController.stop();
        _animationController.reset();

        if (begin == 1.0) {
          //如果当前为正常缩放1.0
          end = 1.5; //放大
        } else {
          end = 1.0; //如果不是就变回原型
        }
        _animationListener = () {
          state.handleDoubleTap(scale: _animation?.value, doubleTapPosition: pointerDownPosition);
        };
        _animation = Tween<double>(begin: begin, end: end).animate(_animationController);

        _animation?.addListener(_animationListener);

        _animationController.forward();
      },
      initGestureConfigHandler: (state) {
        return GestureConfig(
          minScale: 0.9,
          animationMinScale: 0.7,
          maxScale: 3.0,
          animationMaxScale: 3.5,
          speed: 1.0,
          inertialSpeed: 100.0,
          initialScale: 1.0,
          inPageView: false,
          initialAlignment: InitialAlignment.center,
        );
      },
      width: Global.screenWidth,
      height: Global.screenHeight,
      fit: BoxFit.fitWidth, //尽量保持原有分辨率
    );

    return GestureDetector(
        onTap: () async {
          Navigator.pop(context);
        },
        onVerticalDragStart: (detail) {
          _dragStartPoint = detail.globalPosition.dy;
        },
        onVerticalDragUpdate: (detail) {
          if (_top < threeStage[2] && detail.delta.dy < 0) return;
          _top += detail.delta.dy;
          _dragEndPoint = detail.globalPosition.dy;
          (context as Element).markNeedsBuild();
        },
        onVerticalDragEnd: (detail) {
          _onDragEnd(_dragEndPoint - _dragStartPoint, detail.velocity);
        },
        onVerticalDragCancel: () {
          _onDragEnd(_dragEndPoint - _dragStartPoint);
        },
        child: Stack(
          children: [
            Transform(
              transform: mx,
              alignment: FractionalOffset.center,
              child: Hero(tag: widget.heroTag, child: img),
            ),
            Positioned(
                top: _top - 15,
                left: 0,
                right: 0,
                height: threeStage[1] + 64,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                      color: Global.cbOthersBubbleBackground,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CupertinoContextMenuAction(
                        child: const Text('Save this image'),
                        onPressed: () {},
                        trailingIcon: CupertinoIcons.tray_arrow_down,
                      ),
                      CupertinoContextMenuAction(
                        child: const Text('Forward'),
                        onPressed: () {
                          toast('Forward');
                        },
                        trailingIcon: CupertinoIcons.arrowshape_turn_up_right,
                      ),
                      CupertinoContextMenuAction(
                        child: const Text('Delete'),
                        isDestructiveAction: true,
                        onPressed: () {},
                        trailingIcon: CupertinoIcons.trash,
                      ),
                      CupertinoContextMenuAction(
                        child: const Text('Report sensitive content'),
                        isDestructiveAction: true,
                        onPressed: () {},
                        trailingIcon: CupertinoIcons.exclamationmark_triangle,
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }
}
