import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/flutter_base.dart';

/// widget扩展方法
extension WidgetEx on Widget {
  Widget topBg() {
    return Stack(fit: StackFit.expand, children: [
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset(0.2, 0),
            end: FractionalOffset(0.2, 0.28),
            colors:["#FFBF60".toColor(), "#FF8F1F".toColor()],
          ),
        ),
      ),
      this,
    ]);
  }
}
