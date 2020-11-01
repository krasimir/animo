import 'package:flutter/material.dart';

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
