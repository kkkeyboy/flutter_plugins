import 'package:flutter/material.dart';

export 'package:codes/common/extension/WidgetEx.dart';

class ThemeColors {
  //前景色
  static const Color accentColor = Color(0xffFF9800);
  //主色，决定导航栏颜色
  static const Color primaryColor = Color(0xffFFBF60);
  //按钮颜色
  static const Color buttonColor = Color(0xFF003D53);
  //label
  static const Color labelThemeColor = Color(0xFFFFBF60);
  //label高亮
  static const Color labelLightColor = Color(0xFFA69E94);
  //次级标题背景
  static const Color accentDartColor = Color(0xFF082E41);
  //次级标题前景
  static const Color accentDartFgColor = Color(0xFF3FA0B3);

  static const List<Color> btnNormalColors = const [Color(0xffFFBF60), Color(0xffFFBF60)];
  static const Color btnPressedColor = const Color(0xffFF9800);
  static const Color btnDisableColor = const Color(0xffA69E94);
  static const Color btnHollowColor = const Color(0xffFFBF60);
  static const Color btnFgColor = const Color(0xffFFFFFF);

//推荐前景色（着重色
  static const Color primaryFgColor = Color(0xFF00FF99);

  static const Color red = Color(0xFFFF0077);
  static const Color green = primaryFgColor;

  static const Color bg = Color(0xFFFFFFFF);
  static const Color bgCell = Color(0xffF5F5F5);
}

class ThemeDimens {
  static const double btnBorderRadius = 10;
  //页面左右边距
  static const double pageLRMargin = 15;
  //页面竖直方向间距
  static const double pageVerticalMargin = 6;
  //内容竖向间距
  static const double contentVerticalMargin = 10;
  //底部操作区距离底部边距
  static const double pageBottomMargin = 35;
//文本 大字号
  static const double txtLarge = 17;

  static const double headline4 = 16;
}

class ThemeStyles {
  static TextStyle getLarge(BuildContext context) {
    return Theme.of(context).textTheme.headline1!.copyWith(fontSize: 38, fontWeight: FontWeight.bold);
  }

  static TextStyle getSubtitle1lLight(BuildContext context) {
    return Theme.of(context).textTheme.subtitle1!.copyWith(color: ThemeColors.labelLightColor);
  }

  static TextStyle getHeadline4lLight(BuildContext context) {
    return Theme.of(context).textTheme.headline4!.copyWith(color: ThemeColors.labelLightColor);
  }

  static TextStyle getSubtitle2lLight(BuildContext context) {
    return Theme.of(context).textTheme.subtitle2!.copyWith(color: ThemeColors.accentDartFgColor);
  }
}
