import 'dart:io';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'view_state.dart';


class ObservableField<T> extends ChangeNotifier {
  ObservableField([T? value]) : this._value = value;
  T? _value;
  set value(T? value) {
    if (value != _value) {
      _value = value;
      notifyListeners();
    }
  }

  T? get value => _value;
}

class BaseViewModel with ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  /// 当前的页面状态,默认为busy,可在viewModel的构造方法中指定;
  late ViewState _viewState;

  /// 根据状态构造
  ///
  /// 子类可以在构造函数指定需要的页面状态
  /// FooModel():super(viewState:ViewState.busy);
  BaseViewModel({ViewState? viewState}) : _viewState = viewState ?? ViewState.idle {
    debugPrint('ViewStateModel---constructor--->$runtimeType');
  }

  /// ViewState
  ViewState get viewState => _viewState;

  var _needDiscardLastSetState = false;
  int? _lastStateChangeTime;
  set viewState(ViewState viewState) {
    final now = DateTime.now().microsecondsSinceEpoch;
    if (_viewState == viewState) {
      notifyListeners();
      _lastStateChangeTime = now;
      return;
    }
    final delay = now - (_lastStateChangeTime ?? now);
    if (delay < 300) {
      _needDiscardLastSetState = false;
      Future.delayed(Duration(milliseconds: 300 - delay), () {
        if (!_needDiscardLastSetState) {
          _viewState_IMPL(viewState);
        }
      });
    } else {
      _needDiscardLastSetState = true;
      _viewState_IMPL(viewState);
    }
    _lastStateChangeTime = now;
  }

  _viewState_IMPL(ViewState viewState) {
    _viewStateError = null;
    _viewState = viewState;

    notifyListeners();
  }

  /// ViewStateError
  ViewStateError? _viewStateError;

  ViewStateError get viewStateError => _viewStateError!;

  /// set
  void setIdle() {
    viewState = ViewState.idle;
  }

  void setBusy() {
    viewState = ViewState.busy;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  /// [e]分类Error和Exception两种
  void setError(e, stackTrace, {String? message}) {
    ViewStateErrorType errorType = ViewStateErrorType.defaultError;

    /// 见https://github.com/flutterchina/dio/blob/master/README-ZH.md#dioerrortype
    if (e is DioError) {
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.sendTimeout || e.type == DioErrorType.receiveTimeout) {
        // timeout
        errorType = ViewStateErrorType.networkTimeOutError;
        message = e.error;
      } else if (e.type == DioErrorType.response) {
        // incorrect status, such as 404, 503...
        message = e.error;
      } else if (e.type == DioErrorType.cancel) {
        // to be continue...
        message = e.error;
      } else {
        // dio将原error重新套了一层
        e = e.error;
        /*if (e is UnAuthorizedException) {
          stackTrace = null;
          errorType = ViewStateErrorType.unauthorizedError;
        } else if (e is NotSuccessException) {
          stackTrace = null;
          message = e.message;
        } else*/
        if (e is SocketException) {
          errorType = ViewStateErrorType.networkTimeOutError;
          message = e.message;
        } else {
          message = e.message;
        }
      }
    }
    viewState = ViewState.error;
    _viewStateError = ViewStateError(
      errorType,
      message: message,
      errorMessage: e.toString(),
    );
    printErrorStack(e, stackTrace);
    onError(viewStateError);
  }

  void onError(ViewStateError? viewStateError) {}

  /// 显示错误消息
  showErrorMessage(context, {String? message}) {
    if (viewStateError != null || message != null) {
      if (viewStateError!.isNetworkTimeOut) {
        message ??= "";
      } else {
        message ??= viewStateError?.message;
      }
      // Future.microtask(() {
      //   showToast(message, context: context);
      // });
    }
  }

  @override
  String toString() {
    return 'BaseModel{_viewState: $viewState, _viewStateError: $_viewStateError} ${super.toString()}';
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    debugPrint('view_state_model dispose -->$runtimeType');
    super.dispose();
  }
}

/// [e]为错误类型 :可能为 Error , Exception ,String
/// [s]为堆栈信息
printErrorStack(e, s) {
  debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----error-----↓↓↓↓↓↓↓↓↓↓----->
$e
<-----↑↑↑↑↑↑↑↑↑↑-----error-----↑↑↑↑↑↑↑↑↑↑----->''');
  if (s != null) debugPrint('''
<-----↓↓↓↓↓↓↓↓↓↓-----trace-----↓↓↓↓↓↓↓↓↓↓----->
$s
<-----↑↑↑↑↑↑↑↑↑↑-----trace-----↑↑↑↑↑↑↑↑↑↑----->
    ''');
}

abstract class BaseLoadDataViewModel extends BaseViewModel {
  BaseLoadDataViewModel() : super(viewState: ViewState.busy);

  loadData();

  bool hasData() => true;

  void notifyState() {
    hasData() ? setIdle() : setEmpty();
  }
}

abstract class BaseLoadRefreshDataViewModel<T> extends BaseLoadDataViewModel {
  /// 页面数据
   T? data;

  final _refreshController = RefreshController(initialRefresh: false);
  RefreshController get refreshController => _refreshController;

  bool _enableRefresh = true;
  bool get enableRefresh => _enableRefresh;
  set enableRefresh(bool enableRefresh) {
    if (_enableRefresh != enableRefresh) {
      this._enableRefresh = enableRefresh;
      notifyListeners();
    }
  }

  @override
  // 加载数据
  Future<T?> loadData();

  @override
  bool hasData() => data != null;

  /// 下拉刷新
  Future<T?> refresh() async {
    try {
      var data = await loadData();
      if (data != null) {
        this.data = data;
      }
      refreshController.refreshCompleted();
      notifyState();

      return data;
    } catch (e, s) {
      refreshController.refreshFailed();
      if (this.data == null) {
        setError(e, s);
      }
      return null;
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}

abstract class BaseLoadListDataViewModel<T> extends BaseLoadDataViewModel {
  /// 页面数据
  List<T>? datas = [];

  /// 分页第一页页码
  static const int pageNumFirst = 1;

  /// 分页条目数量
  final int pageSize = 20;

  /// 分页页码
  int pageNum = pageNumFirst;

  final _refreshController = RefreshController(initialRefresh: false);
  RefreshController get refreshController => _refreshController;

  bool _enableRefresh = true;
  bool get enableRefresh => _enableRefresh;
  set enableRefresh(bool enableRefresh) {
    if (_enableRefresh != enableRefresh) {
      this._enableRefresh = enableRefresh;
      notifyListeners();
    }
  }

  bool _enableLoadMore = true;
  bool get enableLoadMore => _enableLoadMore;
  set enableLoadMore(bool enableLoadMore) {
    if (_enableLoadMore != enableLoadMore) {
      this._enableLoadMore = enableLoadMore;
      notifyListeners();
    }
  }

  // 加载数据
  @override
  Future<List<T>?> loadData({int pageNum});

  @override
  bool hasData() => datas?.isNotEmpty == true;

  /// 下拉刷新
  Future<List<T>?> refresh() async {
    try {
      pageNum = pageNumFirst;
      var data = await loadData(pageNum: pageNumFirst);
      datas?.clear();
      if (data?.isNotEmpty == true) {
        datas?.addAll(data!);
      }
      refreshController.refreshCompleted();
      // 小于分页的数量,禁止上拉加载更多
      if ((data?.length ?? 0 )< pageSize) {
        refreshController.loadNoData();
      } else {
        //防止上次上拉加载更多失败,需要重置状态
        refreshController.loadComplete();
      }
      notifyState();

      return data;
    } catch (e, s) {
      refreshController.refreshFailed();
      if (!hasData()) {
        setError(e, s);
      }
      return null;
    }
  }

  /// 上拉加载更多
  Future<List<T>?> loadMore() async {
    try {
      var data = await loadData(pageNum: ++pageNum);
      if (data?.isNotEmpty != true) {
        pageNum--;
        refreshController.loadNoData();
      } else {
        datas?.addAll(data!);
        if (data!.length < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        notifyListeners();
      }
      return data;
    } catch (e, s) {
      pageNum--;
      refreshController.loadFailed();
      printErrorStack(e, s);
      return null;
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
