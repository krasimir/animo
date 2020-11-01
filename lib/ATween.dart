import 'package:flutter/material.dart';

const DEFAULT_INTERVAL = Interval(0, 1, curve: Curves.easeOut);

class ATween {
  double begin;
  double end;
  Interval interval;
  Interval reverseInterval;
  Animation anim;
  ATween(
      {@required double begin,
      @required double end,
      @required Interval interval,
      Interval reverseInterval}) {
    this.begin = begin;
    this.end = end;
    this.interval = interval != null ? interval : DEFAULT_INTERVAL;
    this.reverseInterval =
        reverseInterval != null ? reverseInterval : this.interval;
  }
  get value {
    if (anim == null) {
      throw ("Your ATween is not attached to a AAnimation instance. Please use `<your animation>.attach()` method before reading the value.");
    }
    return anim.value;
  }
}
