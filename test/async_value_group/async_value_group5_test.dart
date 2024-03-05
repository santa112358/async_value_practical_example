import 'package:async_value_practical_example/async_value_group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AsyncValueGroup5 Tests', () {
    test('group5 combines five AsyncData values', () {
      final result = AsyncValueGroup.group5(
        const AsyncData<int>(1),
        const AsyncData<String>('Test'),
        const AsyncData<double>(2.5),
        const AsyncData<bool>(true),
        const AsyncData<List<int>>([1, 2, 3]),
      );

      expect(result.value?.$1, 1);
      expect(result.value?.$2, 'Test');
      expect(result.value?.$3, 2.5);
      expect(result.value?.$4, true);
      expect(result.value?.$5, [1, 2, 3]);
    });

    test('group5 returns AsyncLoading if any value is loading', () {
      final result = AsyncValueGroup.group5(
        const AsyncData<int>(1),
        const AsyncData<String>('Test'),
        const AsyncData<double>(2.5),
        const AsyncLoading<bool>(),
        const AsyncData<List<int>>([1, 2, 3]),
      );

      expect(result, isA<AsyncLoading<dynamic>>());
    });

    test('group5 functions return AsyncError on exception', () {
      final result = AsyncValueGroup.group5(
        const AsyncData<int>(1),
        const AsyncData<String>('Test'),
        const AsyncData<double>(2.5),
        const AsyncData<bool>(true),
        AsyncError<dynamic>(
          Error(),
          StackTrace.empty,
        ), // これによりエラーが発生します
      );

      expect(result, isA<AsyncError<dynamic>>());
    });
  });
}
