import 'package:animo/animo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

ATween t =
    ATween(begin: 0, end: 120, interval: Interval(0, 1, curve: Curves.easeOut));

class TestWidget extends StatelessWidget {
  Widget build(context) {
    return Animo((defineAnimation) {
      AAnimation anim = defineAnimation(duration: Duration(seconds: 1));
      anim.attach([t]);
      anim.controller.forward();
      return () {
        return Text('value: ${t.value}');
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
