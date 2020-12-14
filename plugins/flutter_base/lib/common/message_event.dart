import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class LoadingPopupEvent {
  final bool isShow;
  final bool canCancel;
  final String msg;
  const LoadingPopupEvent({
    this.isShow = true,
    this.canCancel = true,
    this.msg,
  });
}

class ToastPopupEvent {
  final String tipImg;
  final bool canCancel;
  final String msg;
  const ToastPopupEvent({
    this.tipImg,
    this.canCancel = true,
    this.msg,
  });
}

class WithDrawSuccess {
  const WithDrawSuccess();
}

class TabbarClick {
  final num index;
  const TabbarClick(this.index);
}

