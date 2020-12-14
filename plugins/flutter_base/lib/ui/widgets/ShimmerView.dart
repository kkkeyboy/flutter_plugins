import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerView extends StatelessWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final bool enableScroll;

  ShimmerView({
    @required this.child,
    this.baseColor,
    this.highlightColor,
    this.enableScroll = true,
  });

  @override
  Widget build(BuildContext context) {
    final shimmer = Shimmer.fromColors(
      baseColor: baseColor ?? Theme.of(context).primaryColor.withOpacity(0.3),
      highlightColor: highlightColor ?? Theme.of(context).splashColor.withOpacity(0.3),
      child: child,
    );
    return enableScroll
        ? SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: shimmer,
          )
        : shimmer;
  }
}
