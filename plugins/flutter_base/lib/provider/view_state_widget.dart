import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'view_state.dart';
import 'view_state_model.dart';

/// 加载中
class ViewStateBusyWidget extends StatelessWidget {
  const ViewStateBusyWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitWave(
        type: SpinKitWaveType.start,
        size: 42,
        color: Theme.of(context).accentColor,
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }
}

/// 基础Widget
class ViewStateWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final String? buttonTextData;
  final VoidCallback? onPressed;

  ViewStateWidget({Key? key, this.image, this.title, this.message, this.buttonText, this.onPressed, this.buttonTextData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titleStyle = Theme.of(context).textTheme.headline4!.copyWith(color: Colors.grey);
    var messageStyle = titleStyle.copyWith(color: titleStyle.color!.withOpacity(0.7), fontSize: 14);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        image ?? Icon(Icons.error, size: 80, color: Colors.grey[500]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                title ?? ViewStateConfig.of(context).errorTip,
                style: titleStyle,
              ),
              SizedBox(height: 20),
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 200, minHeight: 50),
                child: SingleChildScrollView(
                  child: Text(message ?? '', style: messageStyle),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: onPressed == null
              ? null
              : ViewStateButton(
                  child: buttonText,
                  textData: buttonTextData,
                  onPressed: onPressed,
                ),
        ),
      ],
    );
  }
}

/// ErrorWidget
class ViewStateErrorWidget extends StatelessWidget {
  final ViewStateError error;
  final String? title;
  final String? message;
  final Widget? image;
  final Widget? buttonWidget;
  final String? buttonText;
  final VoidCallback? onPressed;

  const ViewStateErrorWidget({
    Key? key,
    required this.error,
    this.image,
    this.title,
    this.message,
    this.buttonWidget,
    this.buttonText,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = ViewStateConfig.of(context);
    var defaultImage;
    var defaultTitle;
    var errorMessage = error.message;
    switch (error.errorType) {
      case ViewStateErrorType.networkTimeOutError:
        defaultImage = config.errorNetIconWidget;
        defaultTitle = config.errorNetTip;
        // errorMessage = ''; // 网络异常移除message提示
        break;
      case ViewStateErrorType.defaultError:
        defaultImage = config.errorIconWidget;
        defaultTitle = config.errorTip;
        break;

      case ViewStateErrorType.unauthorizedError:
        return ViewStateUnAuthWidget(
          image: image,
          message: message,
          buttonText: buttonWidget,
          onPressed: config.errorUnauthorizedOnPressed,
        );
    }

    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? defaultImage,
      title: title ?? defaultTitle,
      message: message ?? errorMessage,
      buttonText: buttonWidget ?? config.errorButtonWidget,
      buttonTextData: buttonText ?? config.errorButtonText,
    );
  }
}

/// 页面无数据
class ViewStateEmptyWidget extends StatelessWidget {
  final String? message;
  final Widget? image;
  final Widget? buttonWidget;
  final String? buttonText;
  final VoidCallback? onPressed;

  const ViewStateEmptyWidget({Key? key, this.image, this.message, this.buttonWidget, this.buttonText, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = ViewStateConfig.of(context);
    return ViewStateWidget(
      onPressed: this.onPressed,
      image: image ?? config.emptyIconWidget,
      title: message ?? config.emptyTip,
      buttonText: buttonWidget ?? config.emptyButtonWidget,
      buttonTextData: buttonText ?? config.emptyButtonText,
    );
  }
}

/// 页面未授权
class ViewStateUnAuthWidget extends StatelessWidget {
  final String? message;
  final Widget? image;
  final Widget? buttonText;
  final VoidCallback? onPressed;

  const ViewStateUnAuthWidget({Key? key, this.image, this.message, this.buttonText, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = ViewStateConfig.of(context);
    return ViewStateWidget(
      onPressed: this.onPressed ?? config.errorUnauthorizedOnPressed ?? () => {},
      image: image ?? config.errorUnauthorizedIconWidget,
      title: message ?? config.errorUnauthorizedTip,
      buttonText: buttonText ?? config.errorUnauthorizedButtonWidget,
      buttonTextData: config.errorUnauthorizedButtonText,
    );
  }
}

/// 公用Button
class ViewStateButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final String? textData;

  const ViewStateButton({@required this.onPressed, this.child, this.textData}) : assert(child == null || textData == null);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: child ??
          Text(
            textData ?? ViewStateConfig.of(context).emptyTip,
            style: TextStyle(wordSpacing: 5),
          ),
      textColor: Colors.grey,
      splashColor: Theme.of(context).splashColor,
      onPressed: onPressed,
      highlightedBorderColor: Theme.of(context).splashColor,
    );
  }
}

class ViewStateLayou<T extends BaseViewModel> extends StatefulWidget {
  final ViewState viewState;
  final Widget empty;
  final Widget? error;
  final Widget loading;
  final Widget child;
  @override
  _ViewStateLayoutState createState() => _ViewStateLayoutState();
  const ViewStateLayou({
    Key? key,
    required this.child,
    required this.viewState,
    this.empty: const ViewStateEmptyWidget(),
    this.error,
    this.loading: const ViewStateBusyWidget(),
  }) : super(key: key);
}

class _ViewStateLayoutState extends State<ViewStateLayou> {
  @override
  Widget build(BuildContext context) {
    switch (widget.viewState) {
      case ViewState.busy:
        return widget.loading;
      case ViewState.empty:
        return widget.empty;
      case ViewState.error:
        return widget.error ?? widget.empty;
      default:
        return widget.child;
    }
  }
}

@immutable
class ViewStateConfigData {
  final Widget? emptyIconWidget;
  final String emptyTip;
  final Widget? emptyButtonWidget;
  final String? emptyButtonText;

  final Widget? errorNetIconWidget;
  final Widget? errorIconWidget;
  final String errorNetTip;
  final String errorTip;
  final Widget? errorButtonWidget;
  final String? errorButtonText;

  final Widget? errorUnauthorizedIconWidget;
  final String errorUnauthorizedTip;
  final Widget? errorUnauthorizedButtonWidget;
  final String? errorUnauthorizedButtonText;
  final VoidCallback? errorUnauthorizedOnPressed;

  const ViewStateConfigData({
    this.emptyIconWidget = const Icon(Icons.no_sim, size: 100, color: Colors.grey),
    this.emptyTip = "空空如也",
    this.emptyButtonWidget,
    this.emptyButtonText = '重试',
    this.errorNetIconWidget = const Icon(Icons.network_check, size: 100, color: Colors.grey),
    this.errorIconWidget = const Icon(Icons.error, size: 100, color: Colors.grey),
    this.errorNetTip = "网络连接异常,请检查网络或稍后重试",
    this.errorTip = "加载失败",
    this.errorButtonWidget,
    this.errorButtonText = "重试",
    this.errorUnauthorizedIconWidget = const Hero(
      tag: 'loginLogo',
      child: Icon(Icons.account_circle, size: 100, color: Colors.grey),
    ),
    this.errorUnauthorizedTip = "未登录",
    this.errorUnauthorizedButtonWidget,
    this.errorUnauthorizedButtonText = "登录",
    this.errorUnauthorizedOnPressed,
  });

  copyWith(
      {Widget? emptyIconWidget,
      String? emptyTip,
      Widget? emptyButtonWidget,
      String? emptyButtonText,
      Widget? errorNetIconWidget,
      Widget? errorIconWidget,
      String? errorNetTip,
      String? errorTip,
      Widget? errorButtonWidget,
      String? errorButtonText,
      Widget? errorUnauthorizedIconWidget,
      String? errorUnauthorizedTip,
      Widget? errorUnauthorizedButtonWidget,
      String? errorUnauthorizedButtonText,
      VoidCallback? errorUnauthorizedOnPressed}) {
    return ViewStateConfigData(
      emptyIconWidget: emptyIconWidget ?? this.emptyIconWidget,
      emptyTip: emptyTip ?? this.emptyTip,
      emptyButtonWidget: emptyButtonWidget ?? this.emptyButtonWidget,
      emptyButtonText: emptyButtonText ?? this.emptyButtonText,
      errorNetIconWidget: errorNetIconWidget ?? this.errorNetIconWidget,
      errorIconWidget: errorIconWidget ?? this.errorIconWidget,
      errorNetTip: errorNetTip ?? this.errorNetTip,
      errorTip: errorTip ?? this.errorTip,
      errorButtonWidget: errorButtonWidget ?? this.errorButtonWidget,
      errorButtonText: errorButtonText ?? this.errorButtonText,
      errorUnauthorizedIconWidget: errorUnauthorizedIconWidget ?? this.errorUnauthorizedIconWidget,
      errorUnauthorizedTip: errorUnauthorizedTip ?? this.errorUnauthorizedTip,
      errorUnauthorizedButtonWidget: errorUnauthorizedButtonWidget ?? this.errorUnauthorizedButtonWidget,
      errorUnauthorizedButtonText: errorUnauthorizedButtonText ?? this.errorUnauthorizedButtonText,
      errorUnauthorizedOnPressed: errorUnauthorizedOnPressed ?? this.errorUnauthorizedOnPressed,
    );
  }
}

// ignore: must_be_immutable
class ViewStateConfig extends InheritedWidget {
  ViewStateConfigData? _data;
  ViewStateConfigData get data => _data ?? (_data = _configGenerator.call());

  final ViewStateConfigGenerator _configGenerator;
  ViewStateConfig({required Widget child,required ViewStateConfigGenerator configBuilder})
      : this._configGenerator = configBuilder,
        super(child: child);

  @override
  bool updateShouldNotify(ViewStateConfig oldWidget) {
    // VoidCallback()
    return data != oldWidget.data;
  }

  static ViewStateConfigData of(BuildContext context) {
    var widget = context.dependOnInheritedWidgetOfExactType<ViewStateConfig>();
    if (widget is ViewStateConfig) {
      return widget.data;
    }
    return ViewStateConfigData();
  }
}

typedef ViewStateConfigGenerator = ViewStateConfigData Function();
