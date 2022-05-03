/// chat_box - image_detail_page
/// Created by xhz on 03/05/2022
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageDetailPage extends StatelessWidget {
  const ImageDetailPage({Key? key, required this.url, required this.heroTag}) : super(key: key);
  final String url;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    final cacheUrlPath = Uri.parse(url).path.replaceAll('/', '%2F');
    final size = MediaQuery.of(context).size;
    final img = ExtendedImage.network(
      url,
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
      width: size.width,
      height: size.height,
      fit: BoxFit.scaleDown, //尽量保持原有分辨率
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Detail'),
      ),
      body: Hero(
        tag: url,
        child: img,
      ),
    );
  }
}
