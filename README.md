# Async Value Practical Example

Async Value Practical Example illustrates a refined approach to managing multiple
asynchronous data sources within Flutter applications using the Riverpod library. Inspired by the
async_value_group library, which relies on tuples, this example builds upon the concept using Dart's
record feature to enhance readability and usability.
It employs the AsyncValue class, the AsyncValueSwitcher widget, and the AsyncValueGroup utility to
efficiently orchestrate the fetching
and rendering of asynchronous data.

Thanks goes to the original author of the async_value_group
library, [bannzai](https://github.com/bannzai)

**Example:**

```dart

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
    final futureA = ref.watch(futureProviderA);
    final futureB = ref.watch(futureProviderB);
    return Scaffold(
      appBar: AppBar(),
      body: AsyncValueSwitcher(
        asyncValue: AsyncValueGroup.group2(futureA, futureB),
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
```

## Key Concepts

### AsyncValueGroup

AsyncValueGroup is crucial for merging multiple AsyncValue instances into a single entity. This
capability allows for the simultaneous management of data from different asynchronous sources. By
doing this, it eliminates the need for separate UI rendering logic for each async data stream,
streamlining the handling of multiple asynchronous operations.

### AsyncValueSwitcher

The AsyncValueSwitcher widget is designed to efficiently manage the states of an AsyncValue,
transitioning smoothly between loading, error, and data states. Using a consistent widget across the
application for these transitions ensures a uniform approach to handling asynchronous data,
simplifying the development process and enhancing user experience.

Keep in mind that AsyncValueSwitcher is just an example for constructing custom widgets tailored to
manage AsyncValues effectively. Developers should consider creating their own custom widgets that
fit their project's specific requirements. The need for customization can come from various aspects
of a project, including transitions between states, as well as the adaptation of default widgets to
better align with your design system.

## Benefits

The use of AsyncValueGroup and AsyncValueSwitcher significantly streamlines development by reducing
the need for repetitive code for handling asynchronous operations. This approach minimizes the
necessity for developers to manually manage multiple AsyncValues or implement individual state
management for each asynchronous data source. As a result, it leads to a more maintainable codebase,
reduces boilerplate, and enhances scalability.

By strategically employing AsyncValueGroup and AsyncValueSwitcher, async_value_practical_example not
only demonstrates an efficient way to handle and display data from multiple asynchronous sources but
also simplifies the development workflow. This results in a more dynamic and user-friendly
interface, with the added advantage of a cleaner and more manageable code structure.
