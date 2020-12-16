import 'PageRouteAnim.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:codes/module/index.dart';

class RouteName {
  static const String SPLASH = 'splash';
  static const String MAIN = 'main';
}

class RouterHelper {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.SPLASH:
        return NoAnimRouteBuilder(Text("SplashPage()"));
      case RouteName.MAIN:
        return CupertinoPageRoute(builder: (_) => Text("MainPage()"));

      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('''
            404
No route defined for ${settings.name}
                    '''),
                  ),
                ));
    }
  }
}

/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
