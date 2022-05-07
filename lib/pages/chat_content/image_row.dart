import 'dart:developer';
import 'dart:math' hide log;

import 'package:chat_box/model/message.dart';
import 'package:extended_image/extended_image.dart';
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
            child: _TransImage(
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
            _TransImage(
              msg: msg,
            )
          ],
        ),
      );
    }
  }
}

class _TransImage extends StatefulWidget {
  const _TransImage({Key? key, required this.msg}) : super(key: key);
  final ChatMessage msg;

  @override
  State<_TransImage> createState() => _TransImageState();
}

class _TransImageState extends State<_TransImage> {
  ChatMessage get msg => widget.msg;
  Offset _imageCenterInGlobal = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final url = Global.https + Global.imageHost + msg.content;
    final width = Global.screenWidth * 0.7;
    //转义 不然 '/' 被当成路径会报错
    Widget img = ExtendedImage.network(
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
                      heroTag: '$hashCode',
                    ))),
        onLongPress: () {},
        child: Hero(
          tag: '$hashCode',
          child: img,
        ));
  }
}
