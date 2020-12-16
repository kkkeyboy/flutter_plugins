import 'package:flutter_base/flutter_base.dart';
import 'package:codes/common/http/UrlsConfig.dart';

import 'DioFactory.dart';

class ApiControls {
  
  static Dio getApi() => DioFactory().getDio(UrlsConfig.API_HOST);
}
