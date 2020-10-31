import 'package:flutter/material.dart';

const DEFAULT_DURATION = Duration(seconds: 1);

class TweenW extends StatefulWidget {
  Widget Function(
      Function(
          {@required double begin,
          @required double end,
          @required Interval interval}),
      AnimationController) callback;
  Duration duration;

  TweenW(this.callback, this.duration);

  @override
  createState() {
    return _TweenW(callback, duration);
  }
}

class _TweenW extends State<TweenW> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Widget Function(
      Function(
          {@required double begin,
          @required double end,
          @required Interval interval}),
      AnimationController) callback;
  Duration duration;

  _TweenW(this.callback, this.duration);

  @override
  initState() {
    super.initState();
    controller = AnimationController(duration: duration, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          Animation defineTween(
              {@required double begin,
              @required double end,
              @required Interval interval}) {
            return Tween<double>(begin: begin, end: end)
                .animate(CurvedAnimation(parent: controller, curve: interval));
          }

          return callback(defineTween, controller);
        });
  }
}

Widget TweenManager(
    {Widget Function(
            Function(
                {@required double begin,
                @required double end,
                @required Interval interval}),
            AnimationController)
        callback,
    duration = DEFAULT_DURATION}) {
  return TweenW(callback, duration);
}
