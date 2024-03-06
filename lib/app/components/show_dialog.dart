import 'package:flutter/material.dart';
import 'package:turtle/app/utils/extensions/extension_context.dart';
import '../../gen/assets.gen.dart';
import '../utils/app_style.dart';
import 'button.dart';

void showAppDialog(BuildContext context,
    {String? title,
    String? message,
    TextStyle? messageStyle,
    Function? callback,
    bool barrierDismissible = true}) {
  showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: context.width - 32 * 2,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  barrierDismissible
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                  padding: const EdgeInsets.all(16),
                                  child: Assets.icons.icClose.image(width: 24)),
                            )
                          ],
                        )
                      : Container(padding: const EdgeInsets.all(16)),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Column(
                      crossAxisAlignment: (title ?? '').isNotEmpty
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        (title ?? '').isNotEmpty
                            ? Column(
                                children: [
                                  Text(title ?? '',
                                      style: AppStyle.medium18,
                                      textAlign: TextAlign.left),
                                  const SizedBox(height: 10),
                                ],
                              )
                            : Container(),
                        Text(message ?? 'Something went wrong',
                            style: messageStyle ?? AppStyle.medium18,
                            textAlign: (title ?? '').isNotEmpty
                                ? TextAlign.left
                                : TextAlign.center),
                        const SizedBox(height: 20),
                        AppButton(
                          onSubmit: () {
                            Navigator.of(context).pop();
                            callback!();
                          },
                          title: '확인',
                        ),
                        const SizedBox(height: 10)
                      ],
                    ),
                  ),
                  // AppButton(
                  //   onSubmit: () => Navigator.of(context).pop(),
                  //   title: 'OK',
                  // ),
                ],
              ),
            ),
          ],
        );
      });
}