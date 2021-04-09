enum NullSafeType {
  NORMAL, //默认 启用空安全
  NONE_SAFE, //不需空安全
  NONE_NULL, //需空安全，单确保不为空
}

extension NullSafeFileSuffix on NullSafeType {
  String getSuffix(NullSafeType type) {
    switch (type) {
      case NullSafeType.NONE_SAFE:
        return "nonesafe";
      case NullSafeType.NONE_NULL:
        return "nonenull";
      default:
        return "";
    }
  }

  NullSafeType getType(String fileName) {
    final suffix = fileName.split("_").lastWhere(
          (element) => true,
          orElse: () => "",
        );
    if (_equals("nonesafe", suffix)) {
      return NullSafeType.NONE_SAFE;
    }
    if (_equals("nonenull", suffix)) {
      return NullSafeType.NONE_NULL;
    }
    return NullSafeType.NORMAL;
  }

  bool _equals(
    String first,
    String other, {
    bool ignoreCase = false,
  }) {
    if (this == null) return other == null;
    return other != null && first.length == other.length && (!ignoreCase ? first == other : first.toUpperCase() == other.toUpperCase());
  }
}
