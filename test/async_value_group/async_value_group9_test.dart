import 'package:async_value_practical_example/async_value_group.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AsyncValueGroup9 Tests', () {
    test('group9 combines nine AsyncData values', () {
      final result = AsyncValueGroup.group9(
        const AsyncData<int>(1),
        const AsyncData<String>('Test'),
        const AsyncData<double>(2.5),
        const AsyncData<bool>(true),
        const AsyncData<List<int>>([1, 2, 3]),
        const AsyncData<Map<String, int>>({'key': 100}),
        const AsyncData<Set<String>>({'value'}),
        const AsyncData<Duration>(Duration(seconds: 5)),
        const AsyncData<double>(3.5), // Replaced Uri.parse with double
      );

      expect(result.value?.$1, 1);
      expect(result.value?.$2, 'Test');
      expect(result.value?.$3, 2.5);
      expect(result.value?.$4, true);
      expect(result.value?.$5, [1, 2, 3]);
      expect(result.value?.$6, {'key': 100});
      expect(result.value?.$7, {'value'});
      expect(result.value?.$8, const Duration(seconds: 5));
      expect(result.value?.$9, 3.5);
    });

    test('group9 returns AsyncLoading if any value is loading', () {
      final result = AsyncValueGroup.group9(
        const AsyncData<int>(1),
        const AsyncData<String>('Test'),
        const AsyncData<double>(2.5),
        const AsyncData<bool>(true),
        const AsyncData<List<int>>([1, 2, 3]),
        const AsyncData<Map<String, int>>({'key': 100}),
        const AsyncData<Set<String>>({'value'}),
        const AsyncLoading<Duration>(),
        const AsyncData<double>(3.5), // Replaced Uri.parse with double
      );

      expect(result, isA<AsyncLoading<dynamic>>());
    });

    test('group9 functions return AsyncError on exception', () {
      final result = AsyncValueGroup.group9(
        const AsyncData<int>(1),
        const AsyncData<String>('Test'),
        const AsyncData<double>(2.5),
        const AsyncData<bool>(true),
        const AsyncData<List<int>>([1, 2, 3]),
        const AsyncData<Map<String, int>>({'key': 100}),
        const AsyncData<Set<String>>({'value'}),
        const AsyncData<Duration>(Duration(seconds: 5)),
        AsyncError<dynamic>(
          Error(),
          StackTrace.empty,
        ), // これによりエラーが発生します
      );

      expect(result, isA<AsyncError<dynamic>>());
    });
  });
}
