import 'package:provider/provider.dart';
// import 'package:xy_wallet/view_model/favourite_model.dart';
import 'base/vm/GlobalUserModel.dart';
import 'base/vm/LocaleModel.dart';
import 'base/vm/ThemeModel.dart';
// import 'package:xy_wallet/view_model/user_model.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [...independentServices, ...dependentServices, ...uiConsumableProviders];

/// 独立的model
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider<ThemeModel>(
    create: (context) => ThemeModel(),
  ),
  ChangeNotifierProvider<LocaleModel>(
    create: (context) => LocaleModel(),
  ),
  ChangeNotifierProvider<GlobalUserModel>(
    create: (context) => GlobalUserModel(),
  )
];

/// 需要依赖的model
///
/// UserModel依赖globalFavouriteStateModel
List<SingleChildWidget> dependentServices = [
  // ChangeNotifierProxyProvider<GlobalFavouriteStateModel, UserModel>(
  //   create: null,
  //   update: (context, globalFavouriteStateModel, userModel) =>
  //   userModel ??
  //       UserModel(globalFavouriteStateModel: globalFavouriteStateModel),
  // )
];

List<SingleChildWidget> uiConsumableProviders = [
//  StreamProvider<User>(
//    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
//  )
];
