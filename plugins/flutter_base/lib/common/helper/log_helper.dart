import 'package:flutter/cupertino.dart';

class LogUtil {
  static const String _defTag = "UuU";
  static bool _debugMode = isInDebugMode; //是否是debug模式,true: log v 不输出.
  static int _maxLen = 128;
  static String _tagValue = _defTag;

  static void init({
    String tag = _defTag,
    int maxLen = 128,
    bool? isDebug,
  }) {
    _tagValue = tag;
    _debugMode = isDebug ?? isInDebugMode;
    _maxLen = maxLen;
  }

  static void e(Object object, {String? tag}) {
    _printLog(tag, ' e ', object);
  }

  static void v(Object object, {String? tag}) {
    if (_debugMode) {
      _printLog(tag, ' v ', object);
    }
  }

  static void _printLog(String? tag, String stag, Object object) {
    String da = object.toString();
    tag = tag ?? _tagValue;
    if (da.length <= _maxLen) {
      debugPrint("$tag$stag $da");
      return;
    }
    debugPrint('$tag$stag — — — — — — — — — — — — — — — — st — — — — — — — — — — — — — — — —');
    while (da.isNotEmpty) {
      if (!da.contains('\n') && da.length > _maxLen) {
        debugPrint("${da.substring(0, _maxLen)}");
        da = da.substring(_maxLen, da.length);
      } else {
        debugPrint("$da");
        da = "";
      }
    }
    debugPrint('$tag$stag — — — — — — — — — — — — — — — — ed — — — — — — — — — — — — — — — —');
  }

  static bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true); //如果debug模式下会触发赋值
    return inDebugMode;
  }
}
