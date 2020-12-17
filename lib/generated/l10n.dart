// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `跟随系统`
  String get autoBySystem {
    return Intl.message(
      '跟随系统',
      name: 'autoBySystem',
      desc: '',
      args: [],
    );
  }

  /// `加载失败`
  String get viewStateMessageError {
    return Intl.message(
      '加载失败',
      name: 'viewStateMessageError',
      desc: '',
      args: [],
    );
  }

  /// `网络连接异常,请检查网络或稍后重试`
  String get viewStateMessageNetworkError {
    return Intl.message(
      '网络连接异常,请检查网络或稍后重试',
      name: 'viewStateMessageNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `空空如也`
  String get viewStateMessageEmpty {
    return Intl.message(
      '空空如也',
      name: 'viewStateMessageEmpty',
      desc: '',
      args: [],
    );
  }

  /// `未登录`
  String get viewStateMessageUnAuth {
    return Intl.message(
      '未登录',
      name: 'viewStateMessageUnAuth',
      desc: '',
      args: [],
    );
  }

  /// `刷新一下`
  String get viewStateButtonRefresh {
    return Intl.message(
      '刷新一下',
      name: 'viewStateButtonRefresh',
      desc: '',
      args: [],
    );
  }

  /// `重试`
  String get viewStateButtonRetry {
    return Intl.message(
      '重试',
      name: 'viewStateButtonRetry',
      desc: '',
      args: [],
    );
  }

  /// `重试`
  String get retry {
    return Intl.message(
      '重试',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `跳过`
  String get splashSkip {
    return Intl.message(
      '跳过',
      name: 'splashSkip',
      desc: '',
      args: [],
    );
  }

  /// `--`
  String get emptyTxtPlace {
    return Intl.message(
      '--',
      name: 'emptyTxtPlace',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}