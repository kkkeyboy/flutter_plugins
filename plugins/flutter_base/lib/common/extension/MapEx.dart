import 'ListEx.dart';

extension MapEx on Map {
  String toJson({bool isFormat = false, int indentation = 2}) {
    String result = "";
    String indentationStr = isFormat ? " " * indentation : "";
    if (true) {
      result += "{";
      this.forEach((key, value) {
        if (value is Map) {
          var temp = value.toJson(indentation: indentation + 2);
          result += "\n$indentationStr" + "\"$key\" : $temp,";
        } else if (value is List) {
          result += "\n$indentationStr" + "\"$key\" : ${value.toJson(indentation: indentation + 2)},";
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
