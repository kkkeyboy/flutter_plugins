import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:codes/common/helper/ThemeHelper.dart';

import '../../StorageManager.dart';
import '../../themes.dart';

//const Color(0xFF5394FF),

class ThemeModel with ChangeNotifier {
  static const kThemeColorIndex = 'kThemeColorIndex';
  static const kThemeUserDarkMode = 'kThemeUserDarkMode';
  static const kFontIndex = 'kFontIndex';

  static const fontValueList = ['system', 'kuaile'];

  /// 用户选择的明暗模式
  bool _userDarkMode;

  /// 当前主题颜色
  MaterialColor _themeColor;

  /// 当前字体索引
  int _fontIndex;

  ThemeModel() {
    /// 用户选择的明暗模式
    _userDarkMode = StorageManager.sharedPreferences.getBool(kThemeUserDarkMode) ?? false;

    /// 获取主题色
    _themeColor = Colors.primaries[StorageManager.sharedPreferences.getInt(kThemeColorIndex) ?? 5];

    /// 获取字体
    _fontIndex = StorageManager.sharedPreferences.getInt(kFontIndex) ?? 0;
  }

  int get fontIndex => _fontIndex;

  /// 切换指定色彩
  ///
  /// 没有传[brightness]就不改变brightness,color同理
  void switchTheme({bool userDarkMode, MaterialColor color, bool needSave = true}) {
    _userDarkMode = userDarkMode ?? _userDarkMode;
    _themeColor = color ?? _themeColor;
    notifyListeners();
    if (needSave) {
      saveTheme2Storage(_userDarkMode, _themeColor);
    }
  }

  /// 随机一个主题色彩
  ///
  /// 可以指定明暗模式,不指定则保持不变
  void switchRandomTheme({Brightness brightness}) {
    int colorIndex = Random().nextInt(Colors.primaries.length - 1);
    switchTheme(
      userDarkMode: Random().nextBool(),
      color: Colors.primaries[colorIndex],
    );
  }

  /// 切换字体
  switchFont(int index) {
    _fontIndex = index;
    switchTheme();
    // saveFontIndex(index);
  }

  /// 根据主题 明暗 和 颜色 生成对应的主题
  /// [dark]系统的Dark Mode
  themeData({bool platformDarkMode: false}) {
    var isDark = platformDarkMode || _userDarkMode;
    // var isDark = _userDarkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    var themeColor = _themeColor;
    // var accentColor = isDark ? themeColor[700] : _themeColor;
    var accentColor = ThemeColors.accentColor; //次级色，决定大多数Widget的颜色，如进度条、开关等。
    var colorBodyText = ThemeColors.labelThemeColor;
    var themeData = ThemeData(
      brightness: brightness,
      // 主题颜色属于亮色系还是属于暗色系(eg:dark时,AppBarTitle文字及状态栏文字的颜色为白色,反之为黑色)
      // 这里设置为dark目的是,不管App是明or暗,都将appBar的字体颜色的默认值设为白色.
      // 再AnnotatedRegion<SystemUiOverlayStyle>的方式,调整响应的状态栏颜色
      primaryColorBrightness: isDark ? Brightness.dark : Brightness.light,
      accentColorBrightness: isDark ? Brightness.dark : Brightness.light,
      primarySwatch: themeColor,
      primaryColor: ThemeColors.primaryColor, //主色，决定导航栏颜色
      accentColor: ThemeColors.primaryColor,
      fontFamily: fontValueList[fontIndex],
      buttonColor: ThemeColors.buttonColor,
      iconTheme: IconThemeData(color: accentColor),
      dividerColor: Colors.transparent,
      primaryIconTheme: IconThemeData(color: Colors.white),
      unselectedWidgetColor: ThemeColors.accentColor.withOpacity(0.4),
    );

    final labelColor = ThemeColors.labelLightColor;

    themeData = themeData.copyWith(
      brightness: brightness,
      // accentColor: ThemeColors.primaryColor,
      cupertinoOverrideTheme: CupertinoThemeData(
        // primaryColor: themeColor,
        brightness: brightness,
      ),

      appBarTheme: themeData.appBarTheme.copyWith(
        elevation: 0,
        // color:ThemeColors.primaryColor,
      ),
      splashColor: themeColor.withAlpha(50),
      hintColor: themeData.hintColor.withAlpha(90),
      errorColor: Colors.red,
      cursorColor: accentColor,

      textTheme: themeData.textTheme.copyWith(
          headline1: themeData.textTheme.headline1.copyWith(fontSize: 22, color: accentColor, fontWeight: FontWeight.bold),
          headline2: themeData.textTheme.headline2.copyWith(fontSize: 30, color: ThemeColors.labelLightColor, fontWeight: FontWeight.bold),
          headline3: themeData.textTheme.headline3.copyWith(fontSize: 18, color: accentColor),
          headline4: themeData.textTheme.headline4.copyWith(fontSize: ThemeDimens.headline4, color: labelColor),
          headline5: themeData.textTheme.headline5.copyWith(fontSize: 10, color: accentColor),
          headline6: themeData.textTheme.headline6.copyWith(fontSize: 14, color: ThemeColors.labelThemeColor, fontWeight: FontWeight.bold),

          /// 解决中文hint不居中的问题 https://github.com/flutter/flutter/issues/40248
          subtitle1: themeData.textTheme.subtitle1.copyWith(fontSize: 14, textBaseline: TextBaseline.alphabetic, color: labelColor),
          subtitle2: themeData.textTheme.subtitle2.copyWith(fontSize: 12, color: Color(0xFF9F9F9F)),
          bodyText1: themeData.textTheme.bodyText1.copyWith(fontSize: 16, color: accentColor),
          bodyText2: themeData.textTheme.bodyText2.copyWith(fontSize: 14, color: ThemeColors.labelLightColor),
          caption: themeData.textTheme.caption.copyWith(color: accentColor),
          overline: themeData.textTheme.overline.copyWith(color: accentColor),
          button: themeData.textTheme.button.copyWith(
            fontSize: 17,
            color: labelColor,
            fontWeight: FontWeight.bold,
          )),

      primaryTextTheme: themeData.primaryTextTheme.copyWith(
        //appbar title
        headline6: themeData.textTheme.headline6.copyWith(fontSize: 17, color: ThemeColors.labelLightColor),
      ),

      textSelectionColor: accentColor.withOpacity(0.4),
      textSelectionHandleColor: labelColor.withAlpha(60),
      toggleableActiveColor: accentColor,
      chipTheme: themeData.chipTheme.copyWith(
        pressElevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 10),
        labelStyle: themeData.textTheme.caption,
        backgroundColor: themeData.chipTheme.backgroundColor.withOpacity(0.1),
      ),

      buttonTheme: themeData.buttonTheme.copyWith(height: 44, textTheme: ButtonTextTheme.accent),
//          textTheme: CupertinoTextThemeData(brightness: Brightness.light)
      inputDecorationTheme: ThemeHelper.inputDecorationTheme(themeData),
    );
    return themeData;
  }

  /// 数据持久化到shared preferences
  saveTheme2Storage(bool userDarkMode, MaterialColor themeColor) async {
    var index = Colors.primaries.indexOf(themeColor);
    await Future.wait([
      StorageManager.sharedPreferences.setBool(kThemeUserDarkMode, userDarkMode),
      StorageManager.sharedPreferences.setInt(kThemeColorIndex, index)
    ]);
  }

  /// 根据索引获取字体名称,这里牵涉到国际化
  // static String fontName(index, context) {
  //   switch (index) {
  //     case 0:
  //       return S.of(context).autoBySystem;
  //     case 1:
  //       return S.of(context).fontKuaiLe;
  //     default:
  //       return '';
  //   }
  // }

  // /// 字体选择持久化
  // static saveFontIndex(int index) async {
  //   await StorageManager.sharedPreferences.setInt(kFontIndex, index);
  // }
}
