import 'package:flutter/material.dart';
import 'package:flutter_cpp_basic/cpp_counter_plugin.dart';
import 'package:flutter_cpp_basic/cpp_data_transformer_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter C++ Integration Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter C++ Integration Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CounterPage()),
                );
              },
              child: const Text('Counter Demo'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DataTransformerPage(),
                  ),
                );
              },
              child: const Text('Data Transformer Demo'),
            ),
          ],
        ),
      ),
    );
  }
}

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
                  key: ValueKey('FAB-Increment'),
                  onPressed: _incrementCounter,
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  key: ValueKey('FAB-Refresh'),
                  onPressed: _resetCounter,
                  child: const Icon(Icons.refresh),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  key: ValueKey('FAB-Decrement'),
                  onPressed: _decrementCounter,
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DataTransformerPage extends StatefulWidget {
  const DataTransformerPage({super.key});

  @override
  State<DataTransformerPage> createState() => _DataTransformerPageState();
}

class _DataTransformerPageState extends State<DataTransformerPage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  String _selectedOperation = 'transformJson';
  String _fromFormat = 'csv';
  String _toFormat = 'json';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Transformer Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: _selectedOperation,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOperation = newValue!;
                });
              },
              items: <String>['transformJson', 'analyzeText', 'convertFormat']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                  .toList(),
            ),
            const SizedBox(height: 16),
            if (_selectedOperation == 'convertFormat') ...[
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<String>(
                      value: _fromFormat,
                      onChanged: (String? newValue) {
                        setState(() {
                          _fromFormat = newValue!;
                        });
                      },
                      items: <String>['csv', 'json']
                          .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          })
                          .toList(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.arrow_forward),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButton<String>(
                      value: _toFormat,
                      onChanged: (String? newValue) {
                        setState(() {
                          _toFormat = newValue!;
                        });
                      },
                      items: <String>['json', 'xml']
                          .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          })
                          .toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Input',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _processData,
                    child: const Text('Process'),
                  ),
            const SizedBox(height: 16),
            TextField(
              controller: _outputController,
              decoration: const InputDecoration(
                labelText: 'Output',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }

  void _processData() async {
    setState(() {
      _isLoading = true;
    });

    String? result;
    switch (_selectedOperation) {
      case 'transformJson':
        result = await CppDataTransformerPlugin.transformJson(
          _inputController.text,
        );
        break;
      case 'analyzeText':
        result = await CppDataTransformerPlugin.analyzeText(
          _inputController.text,
        );
        break;
      case 'convertFormat':
        result = await CppDataTransformerPlugin.convertFormat(
          dataInput: _inputController.text,
          fromFormat: _fromFormat,
          toFormat: _toFormat,
        );
        break;
    }

    setState(() {
      _outputController.text = result ?? 'Error processing data';
      _isLoading = false;
    });
  }
}
