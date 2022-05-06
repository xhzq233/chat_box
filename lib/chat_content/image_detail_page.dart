/// chat_box - image_detail_page
/// Created by xhz on 03/05/2022
import 'package:chat_box/utils/toast.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageDetailPage extends StatefulWidget {
  const ImageDetailPage({Key? key, required this.url, required this.heroTag}) : super(key: key);
  final String url;
  final String heroTag;

  @override
  State<ImageDetailPage> createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
  late void Function() _animationListener;
  Animation<double>? _animation;
  static const Pair _tween = Pair(1.0, 1.5);

  @override
  void initState() {
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
    final cacheUrlPath = Uri.parse(widget.url).path.replaceAll('/', '%2F');
    final size = MediaQuery.of(context).size;
    final img = ExtendedImage.network(
      widget.url,
      cacheKey: cacheUrlPath,
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

        //remove old
        _animation?.removeListener(_animationListener);

        //stop pre
        _animationController.stop();

        //reset to use
        _animationController.reset();

        if (begin == _tween.first) {
          //如果当前为正常缩放1.0
          end = _tween.second; //放大
        } else {
          end = _tween.first; //如果不是就变回原型
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
      width: size.width,
      height: size.height,
      fit: BoxFit.scaleDown, //尽量保持原有分辨率
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Detail'),
      ),
      body: Hero(
        tag: widget.heroTag,
        child: img,
      ),
    );
  }
}
