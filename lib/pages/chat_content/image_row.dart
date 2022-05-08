import 'dart:ui';

import 'package:chat_box/model/message.dart';
import 'package:chat_box/utils/utils.dart';
import 'package:chat_box/widgets/dialog/more_action.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/global.dart';
import 'avatar.dart';
import 'image_detail_page.dart';

class ImageRow extends StatelessWidget {
  const ImageRow({Key? key, required this.msg}) : super(key: key);
  final ChatMessage msg;

  @override
  Widget build(BuildContext context) {
    if (msg.owned) {
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: _ContextFloatableImage(
              msg: msg,
            )),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAvatar(name: msg.sender),
            const SizedBox(
              width: 6,
            ),
            _ContextFloatableImage(
              msg: msg,
            )
          ],
        ),
      );
    }
  }
}

class _ContextFloatableImage extends StatelessWidget {
  const _ContextFloatableImage({Key? key, required this.msg}) : super(key: key);
  final ChatMessage msg;

  Color _generateColor(double value) {
    //0-1 -> 8-78
    return Color.fromARGB((value * 70 + 8).toInt(), 0, 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    final url = Global.https + Global.imageHost + msg.content;
    final width = Global.screenWidth * 0.7;
    //转义 不然 '/' 被当成路径会报错
    Widget img = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: ExtendedImage.network(
        url,
        cacheKey: msg.content,
        //以名字为key
        printError: false,
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
        // enableMemoryCache: false,
        alignment: msg.owned ? Alignment.centerRight : Alignment.centerLeft,
        width: width,
        fit: BoxFit.scaleDown, //尽量保持原有分辨率
      ),
    );

    return GestureDetector(
        onTap: () => Navigator.push(
            context,
            PageRouteBuilder(
                transitionsBuilder: (_, Animation<double> animation, ___, child) {
                  return Stack(
                    children: [
                      Opacity(
                        opacity: animation.value,
                        child: Container(
                          color: Colors.black,
                        ),
                      ),
                      child
                    ],
                  );
                },
                pageBuilder: (_, __, ___) => ImageDetailPage(
                      name: msg.content,
                      heroTag: hashCode,
                    ))),
        onLongPress: () {
          final box = context.findRenderObject() as RenderBox?;
          final imageSize = box?.size ?? Size.zero;
          final imageOriginInGlobal = box?.localToGlobal(Offset.zero) ?? Offset.zero;
          Navigator.push(
              context,
              RawDialogRoute(
                  barrierColor: Colors.transparent,
                  transitionDuration: const Duration(milliseconds: 300),
                  transitionBuilder: (_, animation, __, child) {
                    animation = CurvedAnimation(parent: animation, curve: Curves.ease);
                    final gussValue = 2 + 3 * animation.value;
                    final scaleValue = 1 + animation.value * 0.12;
                    final trans = Matrix4(scaleValue, 0, 0, 0, 0, scaleValue, 0, 0, 0, 0, 1, 0, imageOriginInGlobal.dx,
                        imageOriginInGlobal.dy, 0, 1);
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: gussValue, sigmaY: gussValue),
                            child: Container(
                              color: _generateColor(animation.value),
                            ),
                          ),
                        ),
                        Transform(
                          transform: trans,
                          alignment: Alignment.center,
                          child: child,
                        ),
                        Positioned(
                            top: imageOriginInGlobal.dy + imageSize.height * 1.06, //1+0.12/2
                            right: Global.screenWidth - (imageOriginInGlobal.dx + imageSize.width * 1.06), //这个是据屏幕右边的距离
                            child: MoreActionWidget(
                              animation: animation,
                              height: 100,
                              actions: [
                                CupertinoButton(
                                  child: const FittedBox(
                                    child: Text(
                                      'Save',
                                      maxLines: 1,
                                    ),
                                  ),
                                  onPressed: () async {
                                    PlatformApi.saveImage((await get(Uri.parse(url))).bodyBytes, msg.content);
                                  },
                                ),
                                CupertinoButton(
                                  child: const FittedBox(
                                    child: Text(
                                      'Share',
                                      maxLines: 1,
                                    ),
                                  ),
                                  onPressed: () {
                                    toast('Not support yet');
                                  },
                                ),
                              ],
                            ))
                      ],
                    );
                  },
                  pageBuilder: (BuildContext context, __, ___) => img));
        },
        child: Hero(
          tag: hashCode,
          child: img,
        ));
  }
}
