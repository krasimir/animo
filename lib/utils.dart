import 'package:flutter/material.dart';
import './animo.dart';

Widget withOpacity(Widget child, {double value = 1}) {
  return Opacity(opacity: value, child: child);
}

Widget withScale(Widget child, {double value = 1}) {
  return Transform(
      alignment: FractionalOffset.center,
      transform: new Matrix4.identity()..scale(value, value),
      child: child);
}

Widget withTranslate(
  Widget child, {
  double x = 0,
  double y = 0,
  double z = 0,
}) {
  return Transform(transform: Matrix4.translationValues(x, y, z), child: child);
}

Widget withRotation(Widget child, {double x = 0, double y = 0, double z = 0}) {
  return Transform(
      transform: Matrix4.rotationX(x)
        ..rotateY(x)
        ..rotateZ(z),
      child: child);
}

Widget fadeIn(child,
    {double offsetX = 0,
    double offsetY = 0,
    int duration = 800,
    int delay = 0,
    curve = Curves.easeOut}) {
  return Animo((defineAnimation) {
    AAnimation anim =
        defineAnimation(duration: Duration(milliseconds: duration + delay));
    double startAt = delay / (duration + delay);
    ATween opacity = ATween(
        begin: 0,
        end: 1,
        interval: Interval(startAt, 1, curve: Curves.easeOut));
    ATween positionX = ATween(
        begin: offsetX, end: 0, interval: Interval(startAt, 1, curve: curve));
    ATween positionY = ATween(
        begin: offsetY, end: 0, interval: Interval(startAt, 1, curve: curve));

    anim.attach([opacity, positionX, positionY]);
    anim.controller.forward();

    return () {
      return withOpacity(
          withTranslate(child, x: positionX.value, y: positionY.value),
          value: opacity.value);
    };
  });
}

Widget fadeOut(child,
    {double offsetX = 0,
    double offsetY = 0,
    int duration = 800,
    int delay = 0,
    curve = Curves.easeIn}) {
  return Animo((defineAnimation) {
    AAnimation anim =
        defineAnimation(duration: Duration(milliseconds: duration + delay));
    double startAt = delay / (duration + delay);
    ATween opacity = ATween(
        begin: 1,
        end: 0,
        interval: Interval(startAt, 1, curve: Curves.easeOut));
    ATween positionX = ATween(
        begin: 0, end: offsetX, interval: Interval(startAt, 1, curve: curve));
    ATween positionY = ATween(
        begin: 0, end: offsetY, interval: Interval(startAt, 1, curve: curve));

    anim.attach([opacity, positionX, positionY]);
    anim.controller.forward();

    return () {
      return withOpacity(
          withTranslate(child, x: positionX.value, y: positionY.value),
          value: opacity.value);
    };
  });
}
