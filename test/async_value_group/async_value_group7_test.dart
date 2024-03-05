import 'package:async_value_practical_example/async_value_group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AsyncValueGroup7 Tests', () {
    test('group7 combines seven AsyncData values', () {
      final result = AsyncValueGroup.group7(
        const AsyncData<int>(1),
        const AsyncData<String>('Test'),
        const AsyncData<double>(2.5),
        const AsyncData<bool>(true),
        const AsyncData<List<int>>([1, 2, 3]),
        const AsyncData<Map<String, int>>({'key': 100}),
        const AsyncData<Set<String>>({'value'}),
      );

      expect(result.value?.$1, 1);
      expect(result.value?.$2, 'Test');
      expect(result.value?.$3, 2.5);
      expect(result.value?.$4, true);
      expect(result.value?.$5, [1, 2, 3]);
      expect(result.value?.$6, {'key': 100});
      expect(result.value?.$7, {'value'});
    });

    test('group7 returns AsyncLoading if any value is loading', () {
      final result = AsyncValueGroup.group7(
        const AsyncData<int>(1),
        const AsyncData<String>('Test'),
        const AsyncData<double>(2.5),
        const AsyncData<bool>(true),
        const AsyncData<List<int>>([1, 2, 3]),
        const AsyncData<Map<String, int>>({'key': 100}),
        const AsyncLoading<Set<String>>(),
      );

      expect(result, isA<AsyncLoading<dynamic>>());
    });

    test('group7 functions return AsyncError on exception', () {
      final result = AsyncValueGroup.group7(
        const AsyncData<int>(1),
        const AsyncData<String>('Test'),
        const AsyncData<double>(2.5),
        const AsyncData<bool>(true),
        const AsyncData<List<int>>([1, 2, 3]),
        const AsyncData<Map<String, int>>({'key': 100}),
        AsyncError<dynamic>(
          Error(),
          StackTrace.empty,
        ), // これによりエラーが発生します
      );

      expect(result, isA<AsyncError<dynamic>>());
    });
  });
}
