import 'package:flutter/material.dart';

Widget withScale({double value = 1, @required Widget child}) {
  return Transform(
      alignment: FractionalOffset.center,
      transform: new Matrix4.identity()..scale(value, value),
      child: child);
}

Widget withTranslate(
    {double x = 0, double y = 0, double z = 0, @required Widget child}) {
  return Transform(transform: Matrix4.translationValues(x, y, z), child: child);
}

Widget withRotation(
    {double x = 0, double y = 0, double z = 0, @required Widget child}) {
  return Transform(
      transform: Matrix4.rotationX(x)
        ..rotateY(x)
        ..rotateZ(z),
      child: child);
}
