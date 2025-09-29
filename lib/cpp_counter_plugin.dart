import 'package:flutter/services.dart';

class CppCounterPlugin {
  static const MethodChannel _channel = MethodChannel('cpp_counter_plugin');

  static Future<int?> getValue() async {
    final int? value = await _channel.invokeMethod('getValue');
    return value;
  }

  static Future<void> increment() async {
    await _channel.invokeMethod('increment');
  }

  static Future<void> decrement() async {
    await _channel.invokeMethod('decrement');
  }

  static Future<void> reset() async {
    await _channel.invokeMethod('reset');
  }
}
