import 'package:async_value_practical_example/async_value_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'AsyncValueSwitcher Tests',
    () {
      testWidgets('displays onData when data is provided',
          (WidgetTester tester) async {
        const text = 'Hello';
        const asyncValue = AsyncValue.data(text);
        await tester.pumpWidget(
          const MaterialApp(
            home: AsyncValueSwitcher<String>(
              asyncValue: asyncValue,
              onData: Text.new,
            ),
          ),
        );

        expect(find.text(text), findsOneWidget);
      });

      testWidgets(
        'displays onLoading when data is loading',
        (WidgetTester tester) async {
          const asyncValue = AsyncValue<String>.loading();
          await tester.pumpWidget(
            const MaterialApp(
              home: AsyncValueSwitcher<String>(
                asyncValue: asyncValue,
                onData: Text.new,
                onLoading: CircularProgressIndicator(),
              ),
            ),
          );

          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        },
      );

      testWidgets(
        'displays onError when error occurs',
        (WidgetTester tester) async {
          final asyncValue = AsyncValue<String>.error(
            Exception('An error occurred'),
            StackTrace.empty,
          );
          await tester.pumpWidget(
            MaterialApp(
              home: AsyncValueSwitcher<String>(
                asyncValue: asyncValue,
                onData: Text.new,
                onError: (e, s) => const Text('Error'),
              ),
            ),
          );

          expect(find.text('Error'), findsOneWidget);
        },
      );
    },
  );
}
