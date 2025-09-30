import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:flutter_cpp_basic/models/file_metadata.dart';

class CppFileInfoPlugin {
  static const MethodChannel _channel = MethodChannel('cpp_file_info_plugin');

  static Future<FileMetadata> analyzeFile(String path) async {
    final result = await _channel.invokeMethod('analyzeFile', {'path': path});

    try {
      // The result can be a Map (from iOS) or a JSON String (from Android)
      late final Map<String, dynamic> jsonMap;

      /* Map -- Typically from iOS */
      if (result is Map) {
        jsonMap = result.cast<String, dynamic>();
      }

      /* String -- Typically from Android */
      else if (result is String) {
        jsonMap = jsonDecode(result) as Map<String, dynamic>;
      }
      
      /* Others */
      else {
        throw FormatException(
          'Unexpected type from platform channel: ${result.runtimeType}. '
          'Expected Map or JSON String.',
        );
      }

      // Now, parse the unified map into our FileMetadata object
      return FileMetadata.fromJson(jsonMap);
    } catch (e) {
      // If the result is neither a Map nor a String, it's an unexpected type.
      throw FormatException(
        'Unexpected type from platform channel: ${result.runtimeType}. '
        'Expected Map or JSON String.',
      );
    }
  }
}
