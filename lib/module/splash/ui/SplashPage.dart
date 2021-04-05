import 'package:codes/common/router/RouterHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/flutter_base.dart';
import 'package:codes/common/helper/ResourceHelper.dart';
import 'package:codes/common/themes.dart';
import 'package:codes/generated/l10n.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
 late AnimationController _logoController;
 late Animation<double> _animation;
 late AnimationController _countdownController;

  @override
  void initState() {
    _logoController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));

    _animation =
        Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(curve: Interval(0.0, 0.5, curve: Curves.ease), parent: _logoController));

    _logoController.forward();

    _countdownController =
        AnimationController(vsync: this, duration: Duration(milliseconds: _logoController.duration!.inMilliseconds + 500));
    _countdownController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _countdownController.dispose();
    super.dispose();
  }

  Widget buildBody(BuildContext context) {
    DimensHelper.initialize(context, standardWidth: 375);
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Stack(fit: StackFit.expand, children: <Widget>[
        Image.asset(ImageHelper.wrapAssets('splash_bg.png'),
            colorBlendMode: BlendMode.srcOver, //colorBlendMode方式在android等机器上有些延迟,导致有些闪屏,故采用两套图片的方式
            color: Colors.white,
            fit: BoxFit.fill),
        Align(
          alignment: Alignment(0.0, -0.2),
          child: AnimatedLogo(
            animation: _animation,
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: SafeArea(
            child: InkWell(
              onTap: () {
                nextPage(context);
              },
              child: Container(
                child: AnimatedCountdown(
                  context: context,
                  animation: StepTween(begin: 4, end: 0).animate(_countdownController),
                ),
              ),
            ),
          ),
        )
      ]),
    ).bg(color: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent, body: SafeArea(top: false, bottom: false, child: buildBody(context)));
  }
}

class AnimatedCountdown extends AnimatedWidget {
  final Animation<int> animation;

  AnimatedCountdown({key, required this.animation, context}) : super(key: key, listenable: animation) {
    this.animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        nextPage(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var value = animation.value + 1;
    return Opacity(
        opacity: 0,
        child: Text(
          (value == 0 ? '' : '$value | ') + S.of(context).splashSkip,
          style: TextStyle(color: Colors.white),
        ));
  }
}

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({
    Key? key,
   required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    // print("animation ${animation.value}");
    return AnimatedOpacity(
      opacity: animation.value,
      duration: Duration(milliseconds: 400),
      child: Image.asset(
        ImageHelper.wrapAssets('icSplash.png'),
        width: 200.rpx,
        height: 200.rpx,
      ),
    );
  }
}

void nextPage(context) {
  Navigator.of(context).pushReplacementNamed(RouteName.MAIN);
}
