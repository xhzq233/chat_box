/// chat_box - url_image
/// Created by xhz on 09/05/2022
import 'package:chat_box/controller/api/api.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
class UrlImage extends StatelessWidget {
  const UrlImage({Key? key, required this.name, required this.alignment, this.width}) : super(key: key);
  final String name;
  final Alignment alignment;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      Api.getImageUrl + name,
      cacheKey: name,
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
      alignment: alignment,
      width: width,
      fit: BoxFit.scaleDown, //尽量保持原有分辨率
    );
  }
}
