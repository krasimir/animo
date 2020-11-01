import 'package:flutter/material.dart';
import './ATween.dart';

class AAnimation {
  AnimationController controller;
  Function onCompleted;
  Function onDismissed;
  Function onForward;
  Function onReverse;
  AAnimation(AnimationController c) {
    controller = c;
    controller.addListener(() {
      switch (controller.status) {
        case AnimationStatus.completed:
          if (onCompleted != null) onCompleted();
          break;
        case AnimationStatus.dismissed:
          if (onDismissed != null) onDismissed();
          break;
        case AnimationStatus.forward:
          if (onForward != null) onForward();
          break;
        case AnimationStatus.reverse:
          if (onReverse != null) onReverse();
          break;
      }
    });
  }
  void attach(List<ATween> tweens) {
    tweens.forEach((t) {
      t.anim = Tween<double>(begin: t.begin, end: t.end).animate(
          CurvedAnimation(
              parent: controller,
              curve: t.interval,
              reverseCurve: t.reverseInterval));
    });
  }
}
