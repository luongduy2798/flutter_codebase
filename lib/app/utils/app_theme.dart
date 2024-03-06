import 'package:flutter/material.dart';
import 'package:turtle/gen/colors.gen.dart';
import '../../gen/fonts.gen.dart';

class AppThemes {
  ThemeData themData(BuildContext context) {
    return ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
      seedColor: ColorName.primary,
    )).copyWith(
      textTheme: Theme.of(context).textTheme.apply(
            fontFamily: FontFamily.notoSansKR,
            bodyColor: Colors.black,
          ),
    );
  }
}
