/// chat_box - url_image
/// Created by xhz on 03/05/2022
import 'package:chat_box/chat_content/image_detail_page.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageFromUrl extends StatelessWidget {
  final String url;

  final Color? color;

  final double? width;

  final double? height;

  final Alignment alignment;

  final Widget Function(Widget imageWidget)? imageBuilder;

  const ImageFromUrl(
    this.url, {
    Key? key,
    this.alignment = Alignment.centerRight,
    this.color,
    this.width,
    this.height,
    this.imageBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //转义 不然 '/' 被当成路径会报错
    final cacheUrlPath = Uri.parse(url).path.replaceAll('/', '%2F');
    final img = ExtendedImage.network(
      url,
      cacheKey: cacheUrlPath,
      printError: false,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return const Padding(
              padding: EdgeInsets.all(5),
              child: Center(child: CircularProgressIndicator()),
            );
          case LoadState.completed:
            return imageBuilder?.call(state.completedWidget);
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
      color: color,
      // enableMemoryCache: false,
      alignment: alignment,
      width: width,
      height: height,
      fit: BoxFit.scaleDown, //尽量保持原有分辨率
    );
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) {
        return ImageDetailPage(url: url);
      })),
      child: Hero(
        tag: url,
        child: img,
      ),
    );
  }
}
