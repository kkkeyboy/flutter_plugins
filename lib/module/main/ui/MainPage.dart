import 'package:codes/common/http/DataRepo.dart';
import 'package:codes/common/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/flutter_base.dart';

class MainPage extends BasePage {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends BasePageState<MainPage> {
  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: ThemeDimens.pageLRMargin, vertical: ThemeDimens.pageVerticalMargin),
      children: [
        OutlineButton(
            onPressed: () {
              DataRepo.sendEmail();
            },
            child: Text("SendEmail")),
        RaisedButton(
            onPressed: () {
              DataRepo.login();
            },
            child: Text("Login")),
        OutlineButton(
            onPressed: () {
              DataRepo.regist();
            },
            child: Text("Register")),
      ],
    );
  }
}
