import 'package:flutter/material.dart';
import 'package:flutter_cpp_basic/pages/counter_page.dart';
import 'package:flutter_cpp_basic/pages/data_transformer_page.dart';
import 'package:flutter_cpp_basic/pages/file_info_page.dart';

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
            /* Counter */
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

            /* Data Transformer */
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
            const SizedBox(height: 20),

            /* File Info */
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FileInfoPage()),
                );
              },
              child: const Text('File Info Demo'),
            ),
          ],
        ),
      ),
    );
  }
}
