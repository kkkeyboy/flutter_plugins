import 'dart:ffi';

import 'package:flutter/material.dart';

class DimensHelper {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double rpx;
  static late double px;

  static void initialize(BuildContext context, {double standardWidth = 750}) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    rpx = screenWidth / standardWidth;
    px = screenWidth / standardWidth * 2;
  }

  // 按照像素来设置
  static double setPx(double size) {
    return DimensHelper.rpx * size * 2;
  }

  // 按照rxp来设置
  static double setRpx(double size) {
    return DimensHelper.rpx * size;
  }

}
