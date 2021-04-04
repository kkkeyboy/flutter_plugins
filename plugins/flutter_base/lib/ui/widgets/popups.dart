import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PopupWidget extends StatelessWidget {
  const PopupWidget({
    Key? key,
    required this.stopEvent,
    required this.alignment,
    required this.padding,
    this.icon,
    this.message,
  }) : super(key: key);

  final bool stopEvent;
  final Alignment alignment;
  final EdgeInsetsGeometry padding;
  final Widget? icon;
  final Widget? message;

  @override
  Widget build(BuildContext context) {
    var widget = Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: Align(
          alignment: this.alignment,
          child: IntrinsicHeight(
            child: IntrinsicWidth(
              child: Container(
                margin: EdgeInsets.all(22.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Color.fromRGBO(17, 17, 17, 0.7), borderRadius: BorderRadius.circular(5.0)),
                // constraints: BoxConstraints(
                //   minHeight: icon == null ? 50 : 122.0,
                //   minWidth: 124,
                // ),
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    icon == null
                        ? SizedBox.shrink()
                        : Container(
                            constraints: BoxConstraints(minHeight: 55.0),
                            child: IconTheme(data: IconThemeData(size: 55.0), child: icon!),
                          ),
                    message == null
                        ? SizedBox.shrink()
                        : DefaultTextStyle(
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white60),
                            child: message!,
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    return IgnorePointer(
      ignoring: !stopEvent,
      child: widget,
    );
  }
}

class LoadingPopup extends StatefulWidget {
  final double size;

  LoadingPopup({this.size = 50.0});

  @override
  State<StatefulWidget> createState() => LoadingPopupState();
}

class LoadingPopupState extends State<LoadingPopup> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      size: 42,
      color: Theme.of(context).accentColor,
      duration: const Duration(milliseconds: 1000),
    );
  }
}

@immutable
class PopupConfigData {
  final Duration duration;
  final bool backButtonClose;
  final Alignment alignment;
  final EdgeInsets padding;

  const PopupConfigData({
    this.duration = const Duration(seconds: 3),
    this.backButtonClose = true,
    this.alignment = const Alignment(0.0, -0.2),
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
  });

  copyWith({String? successText, Duration? successDuration, bool? backButtonClose, Alignment? toastAlignment}) {
    return PopupConfigData(
        duration: successDuration ?? this.duration, backButtonClose: backButtonClose ?? this.backButtonClose, alignment: toastAlignment ?? this.alignment);
  }
}

class PopupConfig extends InheritedWidget {
  final PopupConfigData data;
  PopupConfig({required Widget child, required this.data}) : super(child: child);

  @override
  bool updateShouldNotify(PopupConfig oldWidget) {
    return data != oldWidget.data;
  }

  static PopupConfigData of(BuildContext context) {
    var widget = context.dependOnInheritedWidgetOfExactType<PopupConfig>();
    if (widget is PopupConfig) {
      return widget.data;
    }
    return PopupConfigData();
  }
}
