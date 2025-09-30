import 'package:flutter/material.dart';
import 'package:flutter_cpp_basic/plugins/cpp_data_transformer_plugin.dart';

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
            /* Operation Dropdown Menu */
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

            /* Convert Format Input Choice  */
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

            /* Input Field */
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Input',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),

            /* Process Button */
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _processData,
                    child: const Text('Process'),
                  ),
            const SizedBox(height: 16),

            /* Output Field */
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
    setState(() => _isLoading = true);

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
