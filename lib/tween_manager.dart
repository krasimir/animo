import 'package:flutter/material.dart';

const DEFAULT_DURATION = Duration(seconds: 1);

class TweenManager extends StatefulWidget {
  void Function(Function) animationFactory;

  TweenManager(Function Function(Function) animations) {
    animationFactory = animations;
  }

  @override
  createState() {
    return _TW(animationFactory);
  }
}

class _TW extends State<TweenManager> with SingleTickerProviderStateMixin {
  List<AnimationController> _controllers = [];

  Function Function(Function) animationFactory;
  Widget Function() childFactory;

  _TW(this.animationFactory);

  @override
  initState() {
    super.initState();
    childFactory = animationFactory(defineController);
  }

  @override
  void dispose() {
    _controllers.forEach((c) {
      c.dispose();
    });
    super.dispose();
  }

  TMAnimation defineController(
      {Duration duration = DEFAULT_DURATION, Duration reverseDuration}) {
    AnimationController c = AnimationController(
        duration: duration,
        vsync: this,
        reverseDuration: reverseDuration != null ? reverseDuration : duration);
    c.addListener(() {
      setState(() {});
    });
    return TMAnimation(c);
  }

  Widget build(BuildContext context) {
    return childFactory();
  }
}

class TMAnimation {
  AnimationController controller;
  TMAnimation(this.controller);
  Animation defineTween(
      {@required double begin,
      @required double end,
      @required Interval interval,
      Interval reverseInterval}) {
    return Tween<double>(begin: begin, end: end).animate(CurvedAnimation(
        parent: controller,
        curve: interval,
        reverseCurve: reverseInterval != null ? reverseInterval : interval));
  }
}
