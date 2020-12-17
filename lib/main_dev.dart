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

import 'package:codes/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info/package_info.dart';

import 'common/ProviderManager.dart';
import 'common/StorageManager.dart';
import 'common/base/vm/LocaleModel.dart';
import 'common/base/vm/ThemeModel.dart';
import 'common/router/RouterHelper.dart';
import 'common/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();

  //强制竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final packageInfo = await PackageInfo.fromPlatform();
  runApp(MyApp(appName: packageInfo.appName ?? "App"));

  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.dark));
}

class MyApp extends StatelessWidget {
  final String appName;
  const MyApp({Key key, @required this.appName});
  
  @override
  Widget build(BuildContext context) {
    return Text("233333${appName}");
  }
}
