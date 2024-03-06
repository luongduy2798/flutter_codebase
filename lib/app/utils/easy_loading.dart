import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:turtle/gen/colors.gen.dart';

initConfigLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.black
    ..indicatorSize = 24.0
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..userInteractions = false
    ..dismissOnTap = false;
}

initConfigLoadingData() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.clear
    ..indicatorSize = 50.0
    ..backgroundColor = Colors.transparent
    ..indicatorColor = ColorName.primary
    ..textColor = Colors.white
    ..userInteractions = true
    ..dismissOnTap = false;
}

dismissLoading() {
  EasyLoading.dismiss();
}

showLoadingData() {
  initConfigLoadingData();
  EasyLoading.show();
}

showLoading() {
  initConfigLoading();
  EasyLoading.show();
}
