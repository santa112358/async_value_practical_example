import 'package:async_value_practical_example/async_value_group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AsyncValueGroup3 Tests', () {
    test('group3 combines three AsyncData values', () {
      final result = AsyncValueGroup.group3(
        const AsyncData<int>(1),
        const AsyncData<String>('Test'),
        const AsyncData<double>(2.5),
      );

      expect(result.value?.$1, 1);
      expect(result.value?.$2, 'Test');
      expect(result.value?.$3, 2.5);
    });

    test('group3 returns AsyncLoading if any value is loading', () {
      final result = AsyncValueGroup.group3(
        const AsyncData<int>(1),
        const AsyncData<String>('Test'),
        const AsyncLoading<double>(),
      );

      expect(result, isA<AsyncLoading<dynamic>>());
    });

    test('group3 functions return AsyncError on exception', () {
      final result = AsyncValueGroup.group3(
        const AsyncData<int>(1),
        const AsyncData<String>('Test'),
        AsyncError<dynamic>(
          Error(),
          StackTrace.empty,
        ), // これによりエラーが発生します
      );

      expect(result, isA<AsyncError<dynamic>>());
    });
  });
}
