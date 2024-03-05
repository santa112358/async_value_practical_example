import 'package:async_value_practical_example/async_value_group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AsyncValueGroup4 Tests', () {
    test('group4 combines four AsyncData values', () {
      final result = AsyncValueGroup.group4(
        const AsyncData<int>(1),
        const AsyncData<String>('Test'),
        const AsyncData<double>(2.5),
        const AsyncData<bool>(true),
      );

      expect(result.value?.$1, 1);
      expect(result.value?.$2, 'Test');
      expect(result.value?.$3, 2.5);
      expect(result.value?.$4, true);
    });

    test('group4 returns AsyncLoading if any value is loading', () {
      final result = AsyncValueGroup.group4(
        const AsyncData<int>(1),
        const AsyncData<String>('Test'),
        const AsyncData<double>(2.5),
        const AsyncLoading<bool>(),
      );

      expect(result, isA<AsyncLoading<dynamic>>());
    });

    test('group4 functions return AsyncError on exception', () {
      final result = AsyncValueGroup.group4(
        const AsyncData<int>(1),
        const AsyncData<String>('Test'),
        const AsyncData<double>(2.5),
        AsyncError<dynamic>(
          Error(),
          StackTrace.empty,
        ), // これによりエラーが発生します
      );

      expect(result, isA<AsyncError<dynamic>>());
    });
  });
}
