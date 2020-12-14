import 'package:flutter_base/common/helper/dimens_helper.dart';

extension DoubleEx on num {
  double get px {
    return DimensHelper.setPx(this.toDouble());
  }

  double get rpx {
    return DimensHelper.setRpx(this.toDouble());
  }

  String subZeroAndDot([String nullPlace = ""]) {
    if (this == null) {
      return nullPlace;
    }
    var originalStr = this.toString();
    if (originalStr.isEmpty) {
      return originalStr;
    }
    if (originalStr.indexOf(".") > 0) {
      originalStr = originalStr.replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
    }
    return originalStr;
    //这种 会在保留小数的基础上对末位进行四舍五入 且只保留了一位小数
    // return this?.toStringAsFixed(this?.truncateToDouble() == this ? 0 : 1) ?? nullPlace ?? "";
  }

// +
  num add(num value) {
    return this == null ? value == null ? null : value : this + value;
  }

//-
  num subtract(num value) {
    return this == null ? null : value == null ? this : this - value;
  }

//*
  num multiply(num value) {
    return this == null || value == null ? null : this * value;
  }

// /
  num divide(num value) {
    return this == null ? null : value == null || value == 0 ? this : this / value;
  }

  // double operator -(num other) {
  //   return 1;
  // }
}

// extension IntEx on int {
//   double get px {
//     return DimensHelper.setPx(this.toDouble());
//   }

//   double get rpx {
//     return DimensHelper.setRpx(this.toDouble());
//   }
// }
