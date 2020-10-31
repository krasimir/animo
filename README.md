# tween_manager

Dart/Flutter utility package for performing staggered animation. The idea is to have a simple interface that allows you to create multiple controllers and tweens attached to them.

---

The package delivers a single utility `TweenManager` that accepts a function. That one gets called with a factory function that you can use to create simple objects of type `TMAnimation`. Those objects have `defineTween` (returns `Animation`) and `controller` which is an instance of `AnimationController`. Checkout the example below to get a better idea.

## Example

```dart
import 'package:flutter/material.dart';
import 'package:tween_manager/tween_manager.dart';

class TestWidget extends StatelessWidget {
  Widget build(context) {
    return TweenManager((defineAnimation) {
      // When you have complex animation sequences you'll probably need
      // multiple controllers. `defineAnimation` spins up a new one every time
      // when it gets called.
      TMAnimation anim = defineAnimation(duration: Duration(seconds: 1));
      
      // You can create multiple animations attached to a single controller.
      Animation a = anim.defineTween(
          begin: 0, end: 120, interval: Interval(0, 1, curve: Curves.easeOut));

      // ... and at the end control your animation directly by calling forward, reverse, stop
      // methods of the AnimationController instance
      anim.controller.forward();

      // It is important to return a function that returns your widgets. This function gets
      // gets called on every tick of the animation.
      return () {
        return Text('value: ${a.value}');
      };
    });
  }
}
```


