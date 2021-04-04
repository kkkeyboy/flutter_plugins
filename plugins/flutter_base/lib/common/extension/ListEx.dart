import 'MapEx.dart';

extension ListEx on List? {
  String toJson({bool isFormat = false, int indentation = 2}) {
    String result = "";
    String indentationStr = isFormat ? " " * indentation : "";
    if (true) {
      result += "$indentationStr[";
      if (!this.isNullOrEmpty) {
        this!.forEach((value) {
          if (value is Map) {
            var temp = value.toJson(isFormat: isFormat, indentation: indentation + 2);
            result += "\n$indentationStr" + "\"$temp\",";
          } else if (value is List) {
            result += value.toJson(indentation: indentation + 2);
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

  bool get isNullOrEmpty => this == null || this?.isEmpty==true;

  // R reduceAs<T,R>(R combine(T value, T element)) {
  //   Iterator<T> iterator = this.iterator;
  //   if (!iterator.moveNext()) {
  //     throw Exception();
  //   }
  //   R value ;
  //   T last = iterator.current;
  //   while (iterator.moveNext()) {
  //     // value = combine(last, iterator.current);
  //   }
  //   return value;
  // }
}
