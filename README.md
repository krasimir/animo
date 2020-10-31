# tween_manager

Dart/Flutter utility package for performing staggered animation.

---

Under the hood creates a StatefulWidget widget, AnimationController and AnimatedBuilder. It's less than 100 loc.

## API

The package delivers a single function `TweenManager`. It accepts two params:

* `Duration` - by default equal to `Duration(seconds: 1)`. This is the duration of the whole animation.
* `callback` function - this function is called with `defineTween` helper and `controller` which is of type [`AnimationController`](https://api.flutter.dev/flutter/animation/AnimationController-class.html). The `callback` should return a widget.

The `defineTween` helper creates an [`Animation`](https://api.flutter.dev/flutter/animation/Animation-class.html) object. It is really a shortcut to:

```dart
Tween<double>(begin: begin, end: end).animate(
  CurvedAnimation(parent: controller, curve: interval)
);
```

## Example

```dart
import 'package:flutter/material.dart';
import 'package:tween_manager/manager.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return TweenManager(
      duration: Duration(seconds: 3),
      callback: (defineTween, controller) {
        Animation opacity = defineTween(
            begin: 0,
            end: 1,
            interval: Interval(0, 0.6, curve: Curves.easeOut));

        controller.forward();

        return Container(
            color: Color(0xFF000000),
            child: Opacity(
              opacity: opacity.value,
              child: Text('Hello world'),
            ));
      });
  }
}

```


