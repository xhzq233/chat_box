/// chat_box - more_action
/// Created by xhz on 08/05/2022
import 'package:chat_box/global.dart';
import 'package:flutter/cupertino.dart';

//must be placed in stack view
class MoreActionsPopUpView extends StatefulWidget {
  const MoreActionsPopUpView(
      {Key? key,
      required this.animation,
      required this.actions,
      this.width = 111.2,
      this.height,
      required this.preferredPosition})
      : super(key: key);
  final Animation<double> animation;
  final double? height;
  final Offset preferredPosition;
  final double width; //prefer 0.618 * height
  final Map<String, VoidCallback> actions;

  @override
  State<MoreActionsPopUpView> createState() => _MoreActionsPopUpViewState();
}

class _MoreActionsPopUpViewState extends State<MoreActionsPopUpView> {
  late final len = widget.actions.length;

  double get width => widget.width;

  late final double height = widget.height ?? len * 45;
  late final Offset position;

  Animation get animation => widget.animation;

  bool get _horizontalOverflow => widget.preferredPosition.dx + width > Global.screenWidth;

  bool get _verticalOverflow => widget.preferredPosition.dy + height > Global.screenHeight;

  @override
  void initState() {
    super.initState();
    position = widget.preferredPosition.translate(_horizontalOverflow ? -width : 0, _verticalOverflow ? -height : 0);
    widget.animation.addListener(_handleChange);
  }

  @override
  void didUpdateWidget(MoreActionsPopUpView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (animation != oldWidget.animation) {
      oldWidget.animation.removeListener(_handleChange);
      animation.addListener(_handleChange);
    }
  }

  @override
  void dispose() {
    widget.animation.removeListener(_handleChange);
    super.dispose();
  }

  void _handleChange() {
    (context as Element).markNeedsBuild();
  }

  Widget _buildItem(String title, VoidCallback action) => CupertinoButton(
        child: FittedBox(
          child: Text(
            title,
            maxLines: 1,
          ),
        ),
        onPressed: action,
      );

  @override
  Widget build(BuildContext context) {
    final animatedWidth = width * 0.8 + animation.value * 0.2 * width;
    int index = 0;
    return Positioned(
        top: position.dy,
        left: position.dx,
        width:animatedWidth ,
        height: height * 0.4 + animation.value * height * 0.6,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Global.cbOthersBubbleBackground,
          ),
          child: Stack(alignment: Alignment.center, children: [
            for (final item in widget.actions.entries)
              Positioned(
                  top: height * (index++) / len * animation.value,
                  width: width,
                  child: _buildItem(item.key, item.value))
          ]),
        ));
  }
}
