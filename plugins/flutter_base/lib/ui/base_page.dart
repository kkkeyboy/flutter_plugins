import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_base/common/helper/popup_helper.dart';
import 'package:flutter_base/common/message_event.dart';
import 'package:flutter_base/provider/provider_widget.dart';
import 'package:flutter_base/provider/view_state_model.dart';
import 'package:flutter_base/provider/view_state_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_base/provider/view_state.dart';

mixin BasePageMixin {
  @protected
  final bool hasAppBar = true;
  @protected
  final double barHeight = null;

  @protected
  void initWithContext(BuildContext context) {}

  @protected
  final String titleLabel = "";

  @protected
  final bool hasBgImg = false;

  final Color bgColor = null;
  final String bgImg = null;
  final Color appBarBgColor = null;
  final Color appBarFgColor = null;
  final Color appBarLabelFgColor = null;

  PageConfigData getConfig(BuildContext context) {
    return BasePageConfig.of(context).checkWith(
        bgColor: bgColor,
        bgImg: bgImg,
        appBarBgColor: appBarBgColor,
        appBarFgColor: appBarFgColor,
        hasBgImg: hasBgImg,
        appBarLabelFgColor: appBarLabelFgColor);
  }

  @protected
  PreferredSizeWidget buildAppBar(BuildContext context) {
    return hasAppBar
        ? new AppBar(
            toolbarHeight: barHeight,
            backgroundColor: getConfig(context).appBarBgColor,
            flexibleSpace: barHeight == null
                ? Container(
                    decoration: BoxDecoration(
                      color: appBarBgColor,
                    ),
                  )
                : null,
            title: buildAppBarTitle(context),
            elevation: 0.0,
            centerTitle: centerTitle(context),
            actions: buildAppBarAction(context),
            leading: buildAppBarLeading(context),
            iconTheme: Theme.of(context).primaryIconTheme.copyWith(color: getConfig(context).appBarFgColor))
        : null;
  }

  bool centerTitle(BuildContext context) {
    return true;
  }

  Widget buildAppBarTitle(BuildContext context) {
    return Text(
      titleLabel,
      style: Theme.of(context)
          .primaryTextTheme
          .headline6
          .copyWith(color: getConfig(context).appBarLabelFgColor ?? getConfig(context).appBarFgColor),
    );
  }

  List<Widget> buildAppBarAction(BuildContext context) {
    return null;
  }

  Widget buildAppBarLeading(BuildContext context) {
    return null;
  }

  Widget buildBottomNavigationBar(BuildContext context) {
    return null;
  }

  @protected
  hideInputKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    // if (FocusScope.of(context).focusedChild != null) //判断获取焦点child时灵时不灵
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      FocusScope.of(context).requestFocus(FocusNode());
      if (MediaQuery.of(context).viewInsets.bottom > 0) {
        FocusManager.instance.primaryFocus.unfocus();
      }
      debugPrint("收起键盘。。。");
    }
  }

  @protected
  Widget buildBody(BuildContext context);

  @protected
  Widget wrapBody(BuildContext context) => null;

  @protected
  Widget buildBodyOutside(BuildContext context, Widget body) => body;

  Widget buildImpl(BuildContext context) {
    initWithContext(context);
    var scaffold = new Scaffold(
      backgroundColor: Colors.transparent,
      appBar: buildAppBar(context),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 触摸收起键盘
          hideInputKeyboard(context);
        },
        // child: SafeArea(
        child: buildBodyOutside(context, wrapBody(context) ?? buildBody(context)),
        // ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );

    final bgImage = getConfig(context).bgImg;
    return Container(
      child: scaffold,
      decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //   colors: [Color(0xFFF0F8FF), Color(0xFFF0F8FF)],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // ),
        image: hasBgImg && bgImage?.isNotEmpty == true ? DecorationImage(image: AssetImage(bgImage), fit: BoxFit.fill) : null,
        color: hasBgImg && bgImage?.isNotEmpty == true ? null : getConfig(context).bgColor,
      ),
    );
  }
}

abstract class BasePageStateless extends StatelessWidget with BasePageMixin {
  BasePageStateless({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildImpl(context);
  }
}

abstract class BasePage extends StatefulWidget {
  @protected
  @override
  BasePageState createState();
}

abstract class BasePageState<T extends BasePage> extends State<T> with BasePageMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => false;

  StreamSubscription _eventBusSubscription;

  @mustCallSuper
  @override
  void initState() {
    _regEventBus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildImpl(context);
  }

  @override
  void deactivate() {
    hideInputKeyboard(context);
    super.deactivate();
  }

  HideCallback _popupHideCallback;
  void showLoading({String msg, bool canCancel = true}) {
    hideLoading();
    if (mounted) {
      _popupHideCallback = showLoadingPopup(context: context, messageTxt: msg, backButtonClose: canCancel);
    }
  }

  void hideLoading() async {
    await _popupHideCallback?.call();
  }

  void _regEventBus() {
    _eventBusSubscription = eventBus.on().listen((event) {
      if (mounted) {
        if (event is LoadingPopupEvent) {
          if (event.isShow) {
            showLoading(msg: event.msg, canCancel: event.canCancel);
          } else {
            hideLoading();
          }
        }
        if (event is ToastPopupEvent) {
          showTipPopup(
            context: context,
            message: event.msg,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _eventBusSubscription?.cancel();
    super.dispose();
  }
}

//加载数据state
abstract class BaseLoadDataState<T extends BasePage, VM extends BaseLoadDataViewModel> extends BasePageState<T> {
  @protected
  final bool emptyEnableReload = false;
  @protected
  final bool errorEnableReload = true;
  @protected
  final VoidCallback onPressedEmpty = null;
  @protected
  VoidCallback onPressedError;
  @protected
  final String emptyTxt = null;

  VM onCreateViewModel();
  VM _viewModel;
  VM get viewModel {
    if (_viewModel == null) {
      _viewModel = onCreateViewModel();
    }
    return _viewModel;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
  //     if (viewModel.viewState == ViewState.busy) {
  //         viewModel.loadData();
  //       }
  //    });
  // }

  Widget buildLoadingWidget(BuildContext context) {
    return ViewStateBusyWidget();
  }

  Widget buildEmptyWidget(BuildContext context, [bool emptyEnableReload = false]) {
    return ViewStateEmptyWidget(
      message: emptyTxt,
      onPressed: emptyEnableReload
          ? onPressedEmpty ??
              () {
                viewModel.setBusy();
                viewModel.loadData();
              }
          : null,
    );
  }

  Widget buildErrorWidget(BuildContext context, [bool errorEnableReload = true]) {
    return ViewStateErrorWidget(
      error: viewModel.viewStateError,
      onPressed: errorEnableReload
          ? onPressedError ??
              () {
                viewModel.setBusy();
                viewModel.loadData();
              }
          : null,
    );
  }

  @override
  Widget wrapBody(BuildContext context) {
    return ProviderWidget<VM>(
      model: viewModel,
      onModelReady: (model) {
        // if (viewModel.viewState != ViewState.idle && viewModel.viewState != ViewState.busy) {
        //   viewModel.setBusy();
        // }
        if (model.viewState == ViewState.busy) {
          model.loadData();
        }
      },
      builder: (context, model, child) {
        switch (model.viewState) {
          case ViewState.busy:
            return buildLoadingWidget(context);
          case ViewState.empty:
            return buildEmptyWidget(context, emptyEnableReload);
          case ViewState.error:
            return buildErrorWidget(context, errorEnableReload);
          default:
            return buildBody(context);
        }
      },
    );
  }
}

//加载数据state 带下拉刷新
abstract class BaseLoadRefreshDataState<T extends BasePage, VM extends BaseLoadRefreshDataViewModel> extends BaseLoadDataState<T, VM> {
  @override
  VoidCallback get onPressedEmpty => _handlerEmptyAndError;
  @override
  VoidCallback get onPressedError => _handlerEmptyAndError;

  bool get showWithOutNoData => true;

  ScrollPhysics refreshPhysics;

  _handlerEmptyAndError() {
    viewModel.setBusy();
    viewModel.refresh();
  }

  Widget buildRefreshWithOutHeader(BuildContext context) => null;
  Widget buildRefreshWithOutFooter(BuildContext context) => null;

  Widget buildRefreshOutside(BuildContext context) => buildRefreshWidget(context);

  Widget buildRefreshWidget(BuildContext context) {
    final refreshView = SmartRefresher(
      controller: viewModel.refreshController,
      onRefresh: viewModel.refresh,
      enablePullDown: viewModel.enableRefresh,
      physics: refreshPhysics,
      child: buildBody(context),
    );

    return showWithOutNoData ? refreshView : _buildWidgetWithOut(context, refreshView);
  }

  @override
  Widget wrapBody(BuildContext context) {
    return ProviderWidget<VM>(
      model: viewModel,
      onModelReady: (model) {
        // if (viewModel.viewState != ViewState.idle && viewModel.viewState != ViewState.busy) {
        //   viewModel.setBusy();
        // }
        if (model.viewState == ViewState.busy) {
          model.refresh();
        }
      },
      builder: (context, model, child) {
        Widget widget;
        switch (model.viewState) {
          case ViewState.busy:
            // model.refresh();
            widget = model.hasData() ? buildRefreshOutside(context) : buildLoadingWidget(context);
            break;
          case ViewState.empty:
            widget = buildEmptyWidget(context, emptyEnableReload);
            break;
          case ViewState.error:
            widget = buildErrorWidget(context, errorEnableReload);
            break;
          default:
            widget = buildRefreshOutside(context);
            break;
        }
        return !showWithOutNoData ? widget : _buildWidgetWithOut(context, widget);
      },
    );
  }

  Widget _buildWidgetWithOut(
    BuildContext context,
    Widget widget,
  ) {
    final header = buildRefreshWithOutHeader(context);
    final footer = buildRefreshWithOutFooter(context);
    if (header == null && footer == null) return widget;
    return SafeArea(
        child: Column(
      children: <Widget>[
        header ?? SizedBox.shrink(),
        Expanded(
          child: widget,
        ),
        footer ?? SizedBox.shrink(),
      ],
    ));
  }
}

//加载List数据state 带下拉刷新 上拉加载更多
abstract class BaseLoadListDataState<T extends BasePage, VM extends BaseLoadListDataViewModel> extends BaseLoadDataState<T, VM> {
  @override
  VoidCallback get onPressedEmpty => _handlerEmptyAndError;
  @override
  VoidCallback get onPressedError => _handlerEmptyAndError;

  bool get showWithOutNoData => true;

  _handlerEmptyAndError() {
    viewModel.setBusy();
    viewModel.refresh();
  }

  Widget buildRefreshWithOutHeader(BuildContext context) => null;
  Widget buildRefreshWithOutFooter(BuildContext context) => null;

  ScrollPhysics refreshPhysics() => null;

  Widget buildRefreshOutside(BuildContext context) => buildRefreshWidget(context);
  Widget buildRefreshWidget(BuildContext context) {
    final refreshView = SmartRefresher(
      controller: viewModel.refreshController,
      enablePullUp: viewModel.enableLoadMore,
      enablePullDown: viewModel.enableRefresh,
      onRefresh: viewModel.refresh,
      onLoading: viewModel.loadMore,
      physics: refreshPhysics(),
      child: buildBody(context),
    );

    return showWithOutNoData ? refreshView : _buildWidgetWithOut(context, refreshView);
  }

  Widget _buildWidgetWithOut(
    BuildContext context,
    Widget widget,
  ) {
    final header = buildRefreshWithOutHeader(context);
    final footer = buildRefreshWithOutFooter(context);
    if (header == null && footer == null) return widget;
    return SafeArea(
        child: Column(
      children: <Widget>[
        header ?? SizedBox.shrink(),
        Expanded(
          child: widget,
        ),
        footer ?? SizedBox.shrink(),
      ],
    ));
  }

  @override
  Widget wrapBody(BuildContext context) {
    return ProviderWidget<VM>(
      model: viewModel,
      onModelReady: (model) {
        // if (viewModel.viewState != ViewState.idle) {
        //   viewModel.setBusy();
        // }
        if (model.viewState == ViewState.busy) {
          model.refresh();
        }
      },
      builder: (context, model, child) {
        Widget widget;
        switch (model.viewState) {
          case ViewState.busy:
            // model.refresh();
            widget = model.hasData() ? buildRefreshOutside(context) : buildLoadingWidget(context);
            break;
          case ViewState.empty:
            widget = buildEmptyWidget(context, emptyEnableReload);
            break;
          case ViewState.error:
            widget = buildErrorWidget(context, errorEnableReload);
            break;
          default:
            widget = buildRefreshOutside(context);
            break;
        }
        return !showWithOutNoData ? widget : _buildWidgetWithOut(context, widget);
      },
    );
  }
}

class BasePageConfig extends InheritedWidget {
  final PageConfigData data;
  BasePageConfig({Widget child, this.data}) : super(child: child);

  @override
  bool updateShouldNotify(BasePageConfig oldWidget) {
    return data != oldWidget.data;
  }

  static PageConfigData of(BuildContext context) {
    var widget = context.dependOnInheritedWidgetOfExactType<BasePageConfig>();
    if (widget is BasePageConfig) {
      return widget.data;
    }
    return PageConfigData();
  }
}

@immutable
class PageConfigData {
  final Color bgColor;
  final String bgImg;
  final Color appBarBgColor;
  final Color appBarFgColor;
  final Color appBarLabelFgColor;

  const PageConfigData({
    this.bgColor = Colors.white,
    this.bgImg = "",
    this.appBarBgColor = Colors.white,
    this.appBarFgColor = const Color(0xff00156B),
    this.appBarLabelFgColor,
  });

  PageConfigData copyWith({Color bgColor, String bgImg, Color appBarBgColor, Color appBarLabelFgColor, Color appBarFgColor}) {
    return PageConfigData(
      bgColor: bgColor ?? this.bgColor,
      bgImg: bgImg ?? this.bgImg,
      appBarBgColor: appBarBgColor ?? this.appBarBgColor,
      appBarFgColor: appBarFgColor ?? this.appBarFgColor,
      appBarLabelFgColor: appBarLabelFgColor ?? this.appBarLabelFgColor,
    );
  }

  PageConfigData checkWith(
      {Color bgColor, String bgImg, Color appBarBgColor, Color appBarFgColor, Color appBarLabelFgColor, bool hasBgImg}) {
    return PageConfigData(
      bgColor: bgColor ?? this.bgColor,
      bgImg: hasBgImg ? bgImg ?? this.bgImg : "",
      appBarBgColor: appBarBgColor ?? this.appBarBgColor,
      appBarFgColor: appBarFgColor ?? this.appBarFgColor,
      appBarLabelFgColor: appBarLabelFgColor ?? this.appBarLabelFgColor,
    );
  }
}
