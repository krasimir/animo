import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tween_manager/tween_manager.dart';

class TestWidget extends StatelessWidget {
  Widget build(context) {
    return TweenManager((defineAnimation) {
      TMAnimation anim = defineAnimation(duration: Duration(seconds: 1));
      Animation a = anim.defineTween(
          begin: 0, end: 120, interval: Interval(0, 1, curve: Curves.easeOut));
      anim.controller.forward();
      return () {
        return Text('value: ${a.value}');
      };
    });
  }
}

void main() {
  testWidgets('Should run the animation', (WidgetTester tester) async {
    await tester.pumpWidget(Material(
        child: Directionality(
            textDirection: TextDirection.ltr, child: TestWidget())));
    await tester.pump();
    await tester.pump(Duration(milliseconds: 2000));

    final text = find.text('value: 120.0');

    expect(text, findsOneWidget);
  });
}
