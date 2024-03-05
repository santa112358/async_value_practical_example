import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

/// Switch between onData, onLoading, and onError based on the state of the AsyncValue
/// Animate the transition between onData, onLoading, and onError
class AsyncValueSwitcher<T> extends StatelessWidget {
  const AsyncValueSwitcher({
    super.key,
    required this.asyncValue,
    required this.onData,
    this.onError,
    this.onLoading,
    this.skipLoadingOnReload = true,
    this.skipLoadingOnRefresh = true,
    this.skipError = false,
    this.duration = const Duration(milliseconds: 300),
  });

  final AsyncValue<T> asyncValue;
  final Widget Function(T data) onData;
  final Widget? onLoading;
  final Widget Function(Object, StackTrace)? onError;
  final bool skipLoadingOnReload;
  final bool skipLoadingOnRefresh;
  final bool skipError;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      child: asyncValue.when(
        skipLoadingOnReload: skipLoadingOnReload,
        skipLoadingOnRefresh: skipLoadingOnRefresh,
        skipError: skipError,
        data: (data) => KeyedSubtree(
          key: const ValueKey('onData'),
          child: onData(data),
        ),
        error: (e, s) => KeyedSubtree(
          key: const ValueKey('onError'),
          child: onError?.call(e, s) ?? const SizedBox.shrink(),
        ),
        loading: () => KeyedSubtree(
          key: const ValueKey('onLoading'),
          child: onLoading ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}

/// For slivers
class SliverAsyncValueSwitcher<T> extends StatelessWidget {
  const SliverAsyncValueSwitcher({
    super.key,
    required this.asyncValue,
    required this.onData,
    this.onError,
    this.onLoading,
    this.skipLoadingOnReload = true,
    this.skipLoadingOnRefresh = true,
    this.skipError = false,
    this.duration = const Duration(milliseconds: 300),
  });

  final AsyncValue<T> asyncValue;
  final Widget Function(T data) onData;
  final Widget? onLoading;
  final Widget Function(Object, StackTrace)? onError;
  final bool skipLoadingOnReload;
  final bool skipLoadingOnRefresh;
  final bool skipError;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedSwitcher(
      duration: duration,
      child: asyncValue.when(
        skipLoadingOnReload: skipLoadingOnReload,
        skipLoadingOnRefresh: skipLoadingOnRefresh,
        skipError: skipError,
        data: (data) => KeyedSubtree(
          key: const ValueKey('onData'),
          child: onData(data),
        ),
        error: (e, s) => KeyedSubtree(
          key: const ValueKey('onError'),
          child: onError?.call(e, s) ?? const SizedBox.shrink(),
        ),
        loading: () => KeyedSubtree(
          key: const ValueKey('onLoading'),
          child: onLoading ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
