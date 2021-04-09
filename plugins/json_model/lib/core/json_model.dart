import 'package:json_model/core/dart_declaration.dart';

import '../utils/extensions.dart';

class JsonModel {
  String fileName;
  String className;
  String declaration;
  String imports;
  List<String> imports_raw;
  String enums;
  String enumConverters;
  String nestedClasses;

  JsonModel(String fileName, List<DartDeclaration> dartDeclarations) {
    this.fileName = fileName;
    className = fileName.toTitleCase();
    declaration = dartDeclarations.toDeclarationStrings(className);
    imports = dartDeclarations.toImportStrings();
    imports_raw = dartDeclarations.getImportRaw();
    enums = dartDeclarations.getEnums(className);
    nestedClasses = dartDeclarations.getNestedClasses();
    print("1111:->${this}");
  }

  // model string from json map
  static JsonModel fromMap(String fileName, Map jsonMap) {
    var dartDeclarations = <DartDeclaration>[];
    jsonMap.forEach((key, value) {
      var declaration = DartDeclaration.fromKeyValue(key, value, fileName: fileName);
      return dartDeclarations.add(declaration);
    });
    // add key to templatestring
    // add valuetype to templatestring
    return JsonModel(fileName, dartDeclarations);
  }

  @override
  String toString() {
    return """fileName:${fileName},
    className:${className},
    declaration:${declaration},
    imports:${imports},
    imports_raw:${imports_raw},
    enums:${enums},
    nestedClasses:${nestedClasses},
    enumConverters:${enumConverters},""";
  }
}
