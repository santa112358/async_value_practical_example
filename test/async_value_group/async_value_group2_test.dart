import 'package:async_value_practical_example/async_value_group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AsyncValueGroup2 Tests', () {
    test('group2 combines two AsyncData values', () {
      final result = AsyncValueGroup.group2(
        const AsyncData<int>(1),
        const AsyncData<String>('Test'),
      );

      expect(result.value?.$1, 1);
      expect(result.value?.$2, 'Test');
    });

    test('group2 returns AsyncLoading if any value is loading', () {
      final result = AsyncValueGroup.group2(
        const AsyncData<int>(1),
        const AsyncLoading<String>(),
      );

      expect(result, isA<AsyncLoading<dynamic>>());
    });

    test('group2 functions return AsyncError on exception', () {
      final result = AsyncValueGroup.group2(
        const AsyncData<int>(1),
        AsyncError<dynamic>(
          Error(),
          StackTrace.empty,
        ), // これによりエラーが発生します
      );

      expect(result, isA<AsyncError<dynamic>>());
    });
  });
}
