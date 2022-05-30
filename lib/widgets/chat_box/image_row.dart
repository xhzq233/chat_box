import 'dart:ui';

import 'package:chat_box/controller/api/api.dart';
import 'package:chat_box/model/message.dart';
import 'package:chat_box/utils/utils.dart';
import 'package:chat_box/widgets/dialog/more_action.dart';
import 'package:chat_box/widgets/image/url_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:chat_box/global.dart';
import '../../controller/message/message_controller.dart';
import '../user/avatar.dart';
import '../image/image_detail_page.dart';

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
            UserAvatar(account: msg.account),
            Global.defaultSpacing,
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
    final url = Api.getImageUrl + msg.content;
    final width = Global.screenWidth * 0.7;
    Widget img = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: UrlImage(
        name: msg.content,
        width: width,
        alignment: msg.owned ? Alignment.centerRight : Alignment.centerLeft,
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
                    final gussValue = 2 + 3 * animation.value;
                    // final scaleValue = 1 + animation.value * 0.12;
                    // final trans = Matrix4(scaleValue, 0, 0, 0, 0, scaleValue, 0, 0, 0, 0, 1, 0, imageOriginInGlobal.dx,
                    //     imageOriginInGlobal.dy, 0, 1);
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(_),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: gussValue, sigmaY: gussValue),
                            child: Container(
                              color: _generateColor(animation.value),
                            ),
                          ),
                        ),
                        child
                      ],
                    );
                  },
                  pageBuilder: (_, animation, ___) {
                    animation = CurvedAnimation(parent: animation, curve: Curves.ease);
                    return Stack(
                      children: [
                        ScaleTransition(
                          scale: Tween(begin: 1.0, end: 1.2).animate(animation),
                          child: img,
                        ),
                        MoreActionsPopUpView(
                            animation: animation,
                            actions: [
                              Pair('Save', () async {
                                PlatformApi.saveImage((await get(Uri.parse(url))).bodyBytes, msg.content);
                              }),
                              Pair('Share', () async {
                                toast('Not support yet');
                              }),
                            ],
                            preferredPosition: Offset(imageOriginInGlobal.dy + imageSize.height * 1.06,
                                imageOriginInGlobal.dx + imageSize.width * 1.06)),
                      ],
                    );
                  }));
        },
        child: Hero(
          tag: hashCode,
          child: img,
        ));
  }
}
