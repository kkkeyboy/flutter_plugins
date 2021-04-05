import 'DioFactory.dart';
import 'services/MainApi.dart';
import 'services/TestApi.dart';

class ApiControls {
  static late MainApi _api;
  static MainApi get api => _api;
  static initMainApi(String hostUrl) {
    _api = MainApi(DioFactory().getDio(hostUrl), baseUrl: hostUrl);
  }

  static TestApi? _apiTest;
  static TestApi get apiTest {
    if (_apiTest == null) {
      _apiTest = TestApi(DioFactory().getDio(), baseUrl: "http://139.159.183.240:9092");
    }
    return _apiTest!;
  }
}
