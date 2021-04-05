import 'package:flutter_base/flutter_base.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    handler.next(options);
    String requestStr = "\n==================== REQUEST ====================\n"
        "- URL:\n${options.uri}\n"
        "- METHOD: ${options.method}\n";

    requestStr += "- HEADER:\n${options.headers.mapToStructureString()}\n";

    final data = options.data;
    if (data != null) {
      if (data is Map)
        requestStr += "- BODY:\n${data.mapToStructureString()}\n";
      else if (data is FormData) {
        final formDataMap = Map()..addEntries(data.fields)..addEntries(data.files);
        requestStr += "- BODY:\n${formDataMap.mapToStructureString()}\n";
      } else
        requestStr += "- BODY:\n${data.toString()}\n";
    }

    requestStr.log("HTTP");
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    handler.next(err);
    String errorStr = "\n==================== RESPONSE ====================\n"
        "- URL:\n${err.requestOptions.baseUrl + err.requestOptions.path}\n"
        "- METHOD: ${err.requestOptions.method}\n";

    errorStr += "- HEADER:\n${err.response?.headers?.map?.mapToStructureString() ?? '{}'}\n";
    if (err.response != null && err.response?.data != null) {
      '╔ ${err.type.toString()}'.log("HTTP");
      errorStr += "- ERROR:\n${_parseResponse(err.response!)}\n";
    } else {
      errorStr += "- ERRORTYPE: ${err.type}\n";
      errorStr += "- MSG: ${err.message}\n";
    }
    errorStr.log("HTTP");
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
    String responseStr = "\n==================== RESPONSE ====================\n"
        "- URL:\n${response.requestOptions.uri}\n";
    responseStr += "- HEADER:\n{";
    response.headers.forEach((key, list) => responseStr += "\n  " + "\"$key\" : \"$list\",");
    responseStr += "\n}\n";
    responseStr += "- STATUS: ${response.statusCode}\n";

    if (response.data != null) {
      responseStr += "- BODY:\n ${_parseResponse(response)}";
    }
    printWrapped(responseStr);
  }

  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => match.group(0).log("HTTP"));
  }

  String _parseResponse(Response response) {
    String responseStr = "";
    var data = response.data;
    if (data is Map)
      responseStr += data.mapToStructureString();
    else if (data is List)
      responseStr += data.listToStructureString();
    else
      responseStr += response.data.toString();

    return responseStr;
  }
}

extension Map2StringEx on Map {
  String mapToStructureString({int indentation = 2}) {
    String result = "";
    String indentationStr = " " * indentation;
    if (true) {
      result += "{";
      this.forEach((key, value) {
        if (value is Map) {
          var temp = value.mapToStructureString(indentation: indentation + 2);
          result += "\n$indentationStr" + "\"$key\" : $temp,";
        } else if (value is List) {
          result += "\n$indentationStr" + "\"$key\" : ${value.listToStructureString(indentation: indentation + 2)},";
        } else {
          final isStr = value is String;
          result += "\n$indentationStr" + "\"$key\" : ${isStr ? "\"" : ""}$value${isStr ? "\"" : ""},";
        }
      });
      result = result.substring(0, result.length - 1);
      result += indentation == 2 ? "\n}" : "\n${" " * (indentation - 1)}}";
    }

    return result;
  }
}

extension List2StringEx on List {
  String listToStructureString({int indentation = 2}) {
    String result = "";
    String indentationStr = " " * indentation;
    if (true) {
      result += "$indentationStr[";
      if (this.isNotEmpty) {
        this.forEach((value) {
          if (value is Map) {
            var temp = value.mapToStructureString(indentation: indentation + 2);
            result += "\n$indentationStr" + "\"$temp\",";
          } else if (value is List) {
            result += value.listToStructureString(indentation: indentation + 2);
          } else {
            final isStr = value is String;
            result += "\n$indentationStr${isStr ? "\"" : ""}$value${isStr ? "\"" : ""},";
          }
        });
        result = result.substring(0, result.length - 1);
      }
      result += "\n$indentationStr]";
    }

    return result;
  }
}
