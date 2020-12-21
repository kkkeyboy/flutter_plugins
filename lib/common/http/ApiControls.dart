import 'DioFactory.dart';
import 'services/MainApi.dart';

class ApiControls {
  static MainApi _api;
  static MainApi get api => _api;
  static initMainApi(String hostUrl) {
    _api = MainApi(DioFactory().getDio(hostUrl), baseUrl: hostUrl);
  }
}
