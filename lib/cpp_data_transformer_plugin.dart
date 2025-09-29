import 'package:flutter/services.dart';

class CppDataTransformerPlugin {
  static const MethodChannel _channel = MethodChannel('cpp_data_transformer_plugin');

  static Future<String?> transformJson(String jsonInput) async {
    final String? result = await _channel.invokeMethod('transformJson', {
      'jsonInput': jsonInput,
    });
    return result;
  }

  static Future<String?> analyzeText(String textInput) async {
    final String? result = await _channel.invokeMethod('analyzeText', {
      'textInput': textInput,
    });
    return result;
  }

  static Future<String?> convertFormat({
    required String dataInput,
    required String fromFormat,
    required String toFormat,
  }) async {
    final String? result = await _channel.invokeMethod('convertFormat', {
      'dataInput': dataInput,
      'fromFormat': fromFormat,
      'toFormat': toFormat,
    });
    return result;
  }
}