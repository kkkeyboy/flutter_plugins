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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

import 'common/StorageManager.dart';
import 'module/App.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();

  //强制竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final packageInfo = await PackageInfo.fromPlatform();
  runApp(App(appName: packageInfo.appName ?? "App"));

  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.dark));
}