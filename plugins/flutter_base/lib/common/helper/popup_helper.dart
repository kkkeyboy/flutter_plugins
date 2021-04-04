import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/ui/widgets/popups.dart';

typedef HideCallback = Future Function();

Future showTipPopup(
    {required BuildContext context,
    Widget? icon,
    String? message,
    Widget? messageWidget,
    stopEvent = false,
    bool? backButtonClose,
    Alignment? alignment,
    Duration? closeDuration}) {
  final config = PopupConfig.of(context);
  closeDuration = closeDuration ?? config.duration;
  backButtonClose = backButtonClose ?? config.backButtonClose;
  final hide = showPopup(
    context: context,
    alignment: alignment,
    message: message != null ? Text(message) : messageWidget,
    stopEvent: stopEvent,
    backButtonClose: backButtonClose,
    icon: icon,
  );

  return Future.delayed(closeDuration, () {
    hide();
  });
}

HideCallback showLoadingPopup(
    {required BuildContext context, Widget? message, String? messageTxt, stopEvent = true, bool? backButtonClose, Alignment? alignment}) {
  var config = PopupConfig.of(context);
  message = message ?? Text(messageTxt ?? "");
  backButtonClose = backButtonClose ?? config.backButtonClose;

  return showPopup(context: context, alignment: alignment, message: message, stopEvent: stopEvent, icon: LoadingPopup(), backButtonClose: backButtonClose);
}

int backButtonIndex = 2;

HideCallback showPopup({required BuildContext context, Widget? message, Widget? icon, bool stopEvent = false, Alignment? alignment,required bool backButtonClose}) {
  var config = PopupConfig.of(context);
  alignment = alignment ?? config.alignment;

  Completer<VoidCallback> result = Completer<VoidCallback>();
  var backButtonName = 'CoolUI_WeuiToast$backButtonIndex';
  BackButtonInterceptor.add((stopDefaultButtonEvent,RouteInfo info) {
    debugPrint("$backButtonClose");
    if (backButtonClose) {
      result.future.then((hide) {
        hide();
      });
    }
    return true;
  }, zIndex: backButtonIndex, name: backButtonName);
  backButtonIndex++;

  OverlayEntry? overlay = OverlayEntry(
      maintainState: true,
      builder: (_) => WillPopScope(
            onWillPop: () async {
              var hide = await result.future;
              hide();
              return false;
            },
            child: PopupWidget(
              alignment: alignment!,
              icon: icon,
              padding: config.padding,
              message: message,
              stopEvent: stopEvent,
            ),
          ));
  result.complete(() {
    if (overlay == null) {
      return;
    }
    overlay!.remove();
    overlay = null;
    BackButtonInterceptor.removeByName(backButtonName);
  });
  Overlay.of(context)!.insert(overlay!);

  return () async {
    var hide = await result.future;
    hide();
  };
}
