import 'package:flutter/material.dart';
import 'package:flutter_cpp_basic/plugins/cpp_counter_plugin.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _updateCounterFromCpp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  key: ValueKey('FAB-Decrement'),
                  onPressed: _decrementCounter,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  key: ValueKey('FAB-Refresh'),
                  onPressed: _resetCounter,
                  child: const Icon(Icons.refresh),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  key: ValueKey('FAB-Increment'),
                  onPressed: _incrementCounter,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _updateCounterFromCpp() async {
    final value = await CppCounterPlugin.getValue();
    if (value != null) {
      setState(() {
        _counter = value;
      });
    }
  }

  void _incrementCounter() {
    CppCounterPlugin.increment().then((_) {
      _updateCounterFromCpp();
    });
  }

  void _decrementCounter() {
    CppCounterPlugin.decrement().then((_) {
      _updateCounterFromCpp();
    });
  }

  void _resetCounter() {
    CppCounterPlugin.reset().then((_) {
      _updateCounterFromCpp();
    });
  }
}
