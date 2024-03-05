import 'package:async_value_practical_example/async_value_group.dart';
import 'package:async_value_practical_example/async_value_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

final futureProviderA = FutureProvider(
  (ref) => Future.delayed(const Duration(milliseconds: 300), () => 'A'),
);

final futureProviderB = FutureProvider(
  (ref) => Future.delayed(const Duration(milliseconds: 200), () => 'B'),
);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateA = ref.watch(futureProviderA);
    final stateB = ref.watch(futureProviderB);
    return Scaffold(
      body: AsyncValueSwitcher(
        asyncValue: AsyncValueGroup.group2(stateA, stateB),
        onData: (group) {
          final a = group.$1;
          final b = group.$2;
          return Center(
            child: Text('result: $a, $b'),
          );
        },
      ),
    );
  }
}
