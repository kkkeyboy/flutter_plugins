import 'package:flutter/material.dart';
import 'package:codes/generated/l10n.dart';

import '../../StorageManager.dart';

import 'package:flutter_base/flutter_base.dart';

class LocaleModel extends ChangeNotifier {
  static const _LocaleCacheKey = '_LocaleCacheKey';

  late Locale _locale;

  Locale get locale => _locale;

  LocaleModel() {
    final cacheLocal = StorageManager.sharedPreferences.getString(_LocaleCacheKey);
    if (!cacheLocal.isNullOrEmpty) {
      final loaclArgArr = cacheLocal!.split(',');
      _locale = Locale.fromSubtags(languageCode: loaclArgArr[0], countryCode: loaclArgArr.length > 1 ? loaclArgArr[1] : null);
    } else {
      _locale = Locale('en');
    }
  }

  switchLocale(Locale locale) {
    _locale = locale;
    S.load(_locale);
    notifyListeners();
    StorageManager.sharedPreferences.setString(_LocaleCacheKey, "${locale.languageCode},${locale.countryCode}");
  }

  static String localeName(Locale? locale) {
    if (locale != null) {
      if ('en'.equals(locale.languageCode, ignoreCase: true)) return 'English';
      if ('jp'.equals(locale.languageCode, ignoreCase: true)) return '日本語の表記';
      if ('zh'.equals(locale.languageCode, ignoreCase: true) && 'TW'.equals(locale.countryCode, ignoreCase: true)) return '中文（繁體）';
      if ('zh'.equals(locale.languageCode, ignoreCase: true)) return '中文';
    }
    return S.current.autoBySystem;
  }
}
