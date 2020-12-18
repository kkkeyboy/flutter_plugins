/*
 *
 *   █████▒█    ██  ▄████▄   ██ ▄█▀        ██╗   ██╗   ██╗
 * ▓██   ▒ ██  ▓██▒▒██▀ ▀█   ██▄█▒         ██║   ██║   ██║
 * ▒████ ░▓██  ▒██░▒▓█    ▄ ▓███▄░         ██║   ██║   ██║
 * ░▓█▒  ░▓▓█  ░██░▒▓▓▄ ▄██▒▓██ █▄         ██║   ██║   ██║
 * ░▒█░   ▒▒█████▓ ▒ ▓███▀ ░▒██▒ █▄        ╚██████╔╝   ██║
 *  ▒ ░   ░▒▓▒ ▒ ▒ ░ ░▒ ▒  ░▒ ▒▒ ▓▒         ╚═════╝    ══╝
 *  ░     ░░▒░ ░ ░   ░  ▒   ░ ░▒ ▒░
 *  ░ ░    ░░░ ░ ░ ░        ░ ░░ ░
 *           ░     ░ ░      ░  ░
 */

import 'package:codes/common/ProviderManager.dart';
import 'package:codes/common/base/vm/LocaleModel.dart';
import 'package:codes/common/base/vm/ThemeModel.dart';
import 'package:codes/common/router/RouterHelper.dart';
import 'package:codes/common/themes.dart';
import 'package:codes/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  final String appName;
  const App({Key key, @required this.appName});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer2<ThemeModel, LocaleModel>(builder: (context, themeModel, localeModel, child) {
        return RefreshConfiguration(
          hideFooterWhenNotFull: false, //列表数据不满一页,不触发加载更多
          headerBuilder: () => MaterialClassicHeader(), // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
          footerBuilder: () => ClassicFooter(), // 配置默认底部指示器
          // footerBuilder: ()=>BallPulseFooter(),
          headerTriggerDistance: 80.0, // 头部触发刷新的越界距离
          springDescription: SpringDescription(stiffness: 170, damping: 16, mass: 1.9), // 自定义回弹动画,三个属性值意义请查询flutter api
          maxOverScrollExtent: 100, //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
          maxUnderScrollExtent: 0, // 底部最大可以拖动的范围
          enableScrollWhenRefreshCompleted: true, //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
          enableLoadingWhenFailed: true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
          enableBallisticLoad: true,
          child: ViewStateConfig(
            child: BasePageConfig(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeModel.themeData(),
                darkTheme: themeModel.themeData(platformDarkMode: true),
                locale: localeModel.locale,
                localizationsDelegates: const [
                  S.delegate,
                  RefreshLocalizations.delegate, //下拉刷新
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate
                ],
                // supportedLocales: S.delegate.supportedLocales,
                supportedLocales: [
                  // const Locale('en', ''), // English, no country code
                  const Locale('zh', ''), // Chinese, no country code
                ],
                onGenerateRoute: RouterHelper.generateRoute,
                initialRoute: RouteName.SPLASH,
                title: appName,
              ),
              data: BasePageConfig.of(context).copyWith(
                  bgColor: ThemeColors.bg,
                  appBarBgColor: ThemeColors.bg,
                  appBarFgColor: ThemeColors.accentColor,
                  appBarLabelFgColor: ThemeColors.accentColor),
            ),
            configBuilder: () => ViewStateConfigData().copyWith(
                emptyIconWidget: SizedBox.shrink(), emptyTip: S.current.viewStateMessageEmpty, errorTip: S.current.viewStateMessageError),
          ),
        );
      }),
    );
  }
}