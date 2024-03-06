import 'package:flutter/material.dart';
import '../../gen/assets.gen.dart';
import '../utils/app_style.dart';

class AppButton extends StatefulWidget {
  String? title;
  Function? onSubmit;
  Color? backgroundColor;
  double height;
  double? width;
  TextStyle? titleStyle;
  AppButton({
    Key? key,
    this.backgroundColor,
    this.title,
    this.onSubmit,
    this.height = 48,
    this.width,
    this.titleStyle,
  }) : super(key: key) {}

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onSubmit != null) {
          widget.onSubmit!();
        }
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          // image: widget.backgroundColor == null
          //     ? DecorationImage(
          //         image: AssetImage(Assets.images.buttonBg.path),
          //         fit: BoxFit.fill,
          //       )
          //     : null,
        ),
        child: Center(
          child: Text(widget.title ?? '',
              style: widget.titleStyle ??
                  AppStyle.medium16.copyWith(color: Colors.white, height: 1)),
        ),
      ),
    );
  }
}
