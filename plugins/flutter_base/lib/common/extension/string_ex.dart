import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

import 'package:flutter/material.dart';
import 'package:flutter_base/common/helper/Rational.dart';
import 'package:flutter_base/common/helper/date_helper.dart';
import 'package:flutter_base/common/helper/log_helper.dart';
import 'package:flutter_base/common/message_event.dart';

extension StringEx on String? {
  showLoading({bool canCancel: true}) {
    eventBus.fire(LoadingPopupEvent(isShow: true, canCancel: canCancel, msg: this));
  }

  hideLoading() {
    eventBus.fire(LoadingPopupEvent(isShow: false));
  }

  showToast({
    bool canCancel: true,
    String? tipImg,
  }) {
    eventBus.fire(ToastPopupEvent(tipImg: tipImg, canCancel: canCancel, msg: this));
  }

  log([String? tag]) {
    LogUtil.v(this??"", tag: tag);
  }

  Color toColor() {
    if (this!.startsWith("#")) {
      var colorValue = this!.split("#").last;
      if (colorValue.length == 3) {
        colorValue = "FF${colorValue[0]}${colorValue[0]}${colorValue[1]}${colorValue[1]}${colorValue[2]}${colorValue[2]}";
      }
      if (colorValue.length == 5) {
        colorValue =
            "${colorValue[0]}${colorValue[1]}${colorValue[2]}${colorValue[2]}${colorValue[3]}${colorValue[3]}${colorValue[4]}${colorValue[4]}";
      }
      if (colorValue.length == 6) {
        colorValue = "FF$colorValue";
      }
      final a = colorValue.substring(0, 2);
      final r = colorValue.substring(2, 4);
      final g = colorValue.substring(4, 6);
      final b = colorValue.substring(6, 8);
      return Color.fromARGB(int.parse(a, radix: 16), int.parse(r, radix: 16), int.parse(g, radix: 16), int.parse(b, radix: 16));
    }
    return Color(int.parse(this!, radix: 16));
  }

  bool equals(
    String? other, {
    bool ignoreCase = false,
  }) {
    if (this == null) return other == null;
    return other != null && this!.length == other.length && (!ignoreCase ? this == other : this!.toUpperCase() == other.toUpperCase());
  }

  bool get isNullOrEmpty => this == null || this?.isEmpty==true;

  String formatDateTime({String emptyPlace = "", bool? isUtc, String? format}) {
    return this.isNullOrEmpty ? emptyPlace : DateUtil.formatDateStr(this??"", isUtc: isUtc, format: format);
  }

  String toDecimalString() {
    return Rational.parse(this??"").toDecimalString();
  }

  num? tryToNum() => this == null ? null : num.tryParse(this!);

  // md5 加密
  String generateMd5() {
    var content = Utf8Encoder().convert(this!);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  String hidePhoneNumber({int start = 3, int end = 7, String replacement = '****'}) {
    return (((this?.length ?? 0) > start && (this?.length ?? 0) >= end) ? this?.replaceRange(start, end, replacement) : this)??"";
  }
}
