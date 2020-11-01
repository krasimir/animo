# Animo

> Why this package exists?

Because I needed something simpler with greater control over my staggered animations. I needed an API to create multiple controllers in the context of a single widget. And of course the power to start/stop/reverse the animations when I want.

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:animo/animo.dart';

// Define a tween.
ATween myTween = ATween(
  begin: 0,
  end: 120,
  interval: Interval(0, 1, curve: Curves.easeOut)
);

class TestWidget extends StatelessWidget {
  Widget build(context) {
    return Animo((defineAnimation) {
      // When you have complex animation sequences you'll probably need
      // multiple controllers. `defineAnimation` spins up a new one every time
      // when it gets called.
      AAnimation anim = defineAnimation(duration: Duration(seconds: 1));
      
      // Attach multiple tweens to the created controller.
      anim.attach([myTween]);
      

      // ... and at the end control your animation directly by calling forward, reverse, stop
      // methods of the AnimationController instance
      anim.controller.forward();

      // It is important to return a function that returns your widget. This function gets
      // gets called on every tick of the animation.
      return () {
        return Text('value: ${myTween.value}');
      };
    });
  }
}
```

Additionally the package offers three helper functions to apply scaling, translating and rotating:

```dart
// Widget withScale({double value = 1, @required Widget child})
// Widget withTranslate({double x = 0, double y = 0, double z = 0, @required Widget child})
// Widget withRotation({double x = 0, double y = 0, double z = 0, @required Widget child})

Padding(
  padding: EdgeInsets.only(bottom: 40),
  child: withTranslate(
    y: myTween.value,
    child: withScale(
      value: anotherTween.value,
      child: MyButton("Click me")),
  ))
```




