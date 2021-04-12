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

  JsonModel(String fileName,String classNameTmp, List<DartDeclaration> dartDeclarations) {
    this.fileName = fileName;
    className = classNameTmp.toTitleCase();
    declaration = dartDeclarations.toDeclarationStrings(className);
    imports = dartDeclarations.toImportStrings();
    imports_raw = dartDeclarations.getImportRaw();
    enums = dartDeclarations.getEnums(className);
    nestedClasses = dartDeclarations.getNestedClasses();
  }

  // model string from json map
  static JsonModel fromMap(String fileName,String className, Map jsonMap) {
    var dartDeclarations = <DartDeclaration>[];
    jsonMap.forEach((key, value) {
      var declaration = DartDeclaration.fromKeyValue(key, value, fileName: fileName,className:className);
      return dartDeclarations.add(declaration);
    });
    // add key to templatestring
    // add valuetype to templatestring
    return JsonModel(fileName,className, dartDeclarations);
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
