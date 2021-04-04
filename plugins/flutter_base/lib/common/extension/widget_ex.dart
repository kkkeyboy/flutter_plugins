import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// widget扩展方法
extension WidgetEx on Widget {
  Padding padding(EdgeInsetsGeometry padding) {
    return Padding(padding: padding, child: this);
  }

  InkWell click({
    Alignment alignment = Alignment.center,
    double heightFactor: 1.0,
    double widthFactor: 1.12,
    GestureTapCallback? onTap,
    Color? focusColor,
    Color? hoverColor,
    Color? highlightColor,
    Color? splashColor,
  }) {
    return InkWell(
      onTap: onTap,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      child: Align(
        alignment: alignment,
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        child: this,
      ),
    );
  }

  SizedBox size({
    double? width,
    double? height,
  }) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      child: this,
    );
  }

  Expanded expand({
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }

  Center center({double? widthFactor, double? heightFactor}) {
    return Center(child: this, widthFactor: widthFactor, heightFactor: heightFactor);
  }

    Container alignment(Alignment alignment, {EdgeInsetsGeometry? padding}) {
    return Container(
      alignment: alignment,
      padding: padding,
      child: this,
    );
  }

  Widget showBy(bool isShow, {Widget? place}) {
    return isShow ? this : place ?? SizedBox.shrink();
  }

  DecoratedBox bg({
    Color? color,
    DecorationImage? image,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BlendMode? backgroundBlendMode,
    BoxShape shape = BoxShape.rectangle,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        image: image,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        gradient: gradient,
        backgroundBlendMode: backgroundBlendMode,
        shape: shape,
      ),
      child: this,
    );
  }

}
