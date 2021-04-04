import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/common/helper/log_helper.dart';

class ImageHelper {
  static const String baseUrl = 'http://www.meetingplus.cn';
  static const String imagePrefix = '$baseUrl/uimg/';

  static String wrapUrl(String? url) {
    if (LogUtil.isInDebugMode && (url == null || url.isEmpty)) {
      return randomUrl();
    }
    if (url == null) return '';
    if (url.startsWith('http')) {
      return url;
    } else {}
    return imagePrefix + url;
  }

  static String wrapAssets(String url) {
    if (url.startsWith("http") == true) {
      return url;
    }
    return "assets/images/" + url;
  }

  static Widget placeHolder({required double width, double? height}) {
    return SizedBox(width: width, height: height, child: CupertinoActivityIndicator(radius: min(10.0, width / 3)));
  }

  static Widget error({double? width, double? height, double? size}) {
    return SizedBox(
        width: width,
        height: height,
        child: Icon(
          Icons.error_outline,
          size: size,
        ));
  }

  static String randomUrl({int width = 100, int height = 100, Object key = ''}) {
    return 'http://placeimg.com/$width/$height/${key.hashCode.toString() + key.toString()}?timestamp=${DateTime.now().toString()}';
  }
}

class IconFonts {
  IconFonts._();

  /// iconfont:flutter base
  static const String fontFamily = 'icomoon';

  static const IconData failed = IconData(0xea0d, fontFamily: fontFamily);
  static const IconData success = IconData(0xe906, fontFamily: fontFamily);
  static const IconData wait = IconData(0xe94e, fontFamily: fontFamily);
  static const IconData eye = IconData(0xe909, fontFamily: fontFamily);
  static const IconData eye_hiden = IconData(0xe908, fontFamily: fontFamily);
}
