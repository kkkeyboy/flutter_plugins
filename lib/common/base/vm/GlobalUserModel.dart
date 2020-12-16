import 'package:flutter/material.dart';
import 'package:flutter_base/common/helper/log_helper.dart';
import 'package:codes/common/StorageManager.dart';
import 'package:flutter_base/flutter_base.dart';


class GlobalUserModel extends ChangeNotifier {
  static GlobalUserModel _current = GlobalUserModel._internal();
  factory GlobalUserModel() => _current;

  GlobalUserModel._internal();

  // UserInfoData _userInfo;

  // UserInfoData get userInfo {
  //   if (_userInfo == null) {
  //     try {
  //       final cacheData = StorageManager.sharedPreferences.getString("userInfo");
  //       if (cacheData?.isNotEmpty == true) {
  //         _userInfo = UserInfoData.fromJson(jsonDecode(cacheData));
  //       }
  //       // _userInfo = UserInfoData();
  //     } catch (e) {
  //       LogUtil.e(e);
  //     }
  //   }
  //   return _userInfo;
  // }

  // set userInfo(UserInfoData value) {
  //   if (_userInfo?.hashCode != value?.hashCode) {
  //     _userInfo = value;
  //     notifyListeners();
  //     StorageManager.sharedPreferences.setString("userInfo", value == null ? "" : jsonEncode(value.toJson()));
  //     _walletList.clear();
  //   }
  // }

 

  void needNotify() {
    notifyListeners();
  }
}
