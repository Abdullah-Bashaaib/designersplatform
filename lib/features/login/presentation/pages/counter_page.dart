import 'package:flutter/material.dart';
import '../state/counter_notifier.dart';

class CounterPage extends StatefulWidget {
  final CounterNotifier notifier;
  const CounterPage({super.key, required this.notifier});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  void initState() {
    super.initState();
    widget.notifier.load();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.notifier,
      builder: (context, _) {
        final value = widget.notifier.counter?.value ?? 0;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Counter'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You have pushed the button this many times:'),
                if (widget.notifier.isLoading)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: CircularProgressIndicator(),
                  )
                else
                  Text(
                    '$value',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: widget.notifier.increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
