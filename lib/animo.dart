export 'AAnimation.dart';
export 'ATween.dart';
export 'utils.dart';

import 'package:flutter/material.dart';
import 'AAnimation.dart';

const DEFAULT_DURATION = Duration(seconds: 1);

class Animo extends StatefulWidget {
  void Function(Function) animationFactory;

  Animo(Function Function(Function) animations) {
    animationFactory = animations;
  }

  @override
  createState() {
    return _Animo(animationFactory);
  }
}

class _Animo extends State<Animo> with TickerProviderStateMixin {
  List<AnimationController> _controllers = [];

  Function Function(Function) animationFactory;
  Widget Function() childFactory;

  _Animo(this.animationFactory);

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

  AAnimation defineController(
      {Duration duration = DEFAULT_DURATION, Duration reverseDuration}) {
    AnimationController c = AnimationController(
        duration: duration,
        vsync: this,
        reverseDuration: reverseDuration != null ? reverseDuration : duration);
    c.addListener(() {
      setState(() {});
    });
    return AAnimation(c);
  }

  Widget build(BuildContext context) {
    return childFactory();
  }
}
