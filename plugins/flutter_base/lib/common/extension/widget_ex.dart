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
    GestureTapCallback onTap,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
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
    double width,
    double height,
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

  Center center({double widthFactor, double heightFactor}) {
    return Center(child: this, widthFactor: widthFactor, heightFactor: heightFactor);
  }

    Container alignment(Alignment alignment, {EdgeInsetsGeometry padding}) {
    return Container(
      alignment: alignment,
      padding: padding,
      child: this,
    );
  }

  Widget showBy(bool isShow, {Widget place}) {
    return isShow ? this : place ?? SizedBox.shrink();
  }

  DecoratedBox bg({
    Color color,
    DecorationImage image,
    BoxBorder border,
    BorderRadiusGeometry borderRadius,
    List<BoxShadow> boxShadow,
    Gradient gradient,
    BlendMode backgroundBlendMode,
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

  Widget bgColor({
    Color start,
    Color end,
    BorderRadiusGeometry borderRadius = const BorderRadius.only(
      bottomLeft: Radius.circular(12),
      bottomRight: Radius.circular(12),
    ),
  }) {
    start == null ? start = Color(0xFF009EFD) : null;
    end == null ? end = Color(0xFF1FE0B0) : null;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [start, end],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: borderRadius),
      child: this,
    );
  }

  // Widget backImage({String image, EdgeInsetsGeometry padding}) {
  //   // return AsperctRaioImage.asset(
  //   //   ImageHelper.wrapAssets(image ?? 'container_bg.png'),
  //   //   builder: (context, snapshot, url) {
  //   //     print('width=${snapshot.data.width}');
  //   //     print('heiht=${snapshot.data.height}');
  //   //     return Column(
  //   //       crossAxisAlignment: CrossAxisAlignment.start,
  //   //       children: <Widget>[
  //   //         Text(
  //   //           '本地资源加载',
  //   //           style: TextStyle(fontSize: 25.0, color: Colors.black),
  //   //         ),
  //   //         Text(
  //   //           '大小--${snapshot.data.width.toDouble()}x${snapshot.data.height.toDouble()}',
  //   //           style: TextStyle(fontSize: 17.0),
  //   //         ),
  //   //         Container(
  //   //           width: snapshot.data.width.toDouble() / 5,
  //   //           height: snapshot.data.height.toDouble() / 5,
  //   //           decoration: BoxDecoration(
  //   //             image: DecorationImage(image: AssetImage(url), fit: BoxFit.cover),
  //   //           ),
  //   //         )
  //   //       ],
  //   //     );
  //   //   },
  //   // );

  //   return Container(
  //     padding: padding,
  //     decoration: BoxDecoration(
  //         image: DecorationImage(
  //       centerSlice: image == null ? Rect.fromLTRB(15.0, 15.0, 20.0, 20.0) : null,
  //       image: AssetImage(
  //         ImageHelper.wrapAssets(image ?? 'container_bg.webp'),
  //       ),
  //       fit: BoxFit.fill,
  //     )),
  //     constraints: BoxConstraints(minWidth: 48, minHeight: 44),
  //     child: this,
  //   );
  // }

}