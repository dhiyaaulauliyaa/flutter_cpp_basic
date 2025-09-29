package com.example.flutter_cpp_basic

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val COUNTER_CHANNEL = "cpp_counter_plugin"
    private val DATA_TRANSFORMER_CHANNEL = "cpp_data_transformer_plugin"
    private lateinit var counterWrapper: CounterWrapper
    private lateinit var dataTransformerWrapper: DataTransformerWrapper

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        counterWrapper = CounterWrapper()
        dataTransformerWrapper = DataTransformerWrapper()
        
        // Counter method channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, COUNTER_CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "getValue" -> {
                    val value = counterWrapper.getValue()
                    result.success(value)
                }
                "increment" -> {
                    counterWrapper.increment()
                    result.success(null)
                }
                "decrement" -> {
                    counterWrapper.decrement()
                    result.success(null)
                }
                "reset" -> {
                    counterWrapper.reset()
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
        
        // Data transformer method channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DATA_TRANSFORMER_CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "transformJson" -> {
                    val jsonInput = call.argument<String>("jsonInput")
                    if (jsonInput != null) {
                        val transformed = dataTransformerWrapper.transformJson(jsonInput)
                        result.success(transformed)
                    } else {
                        result.error("INVALID_ARGUMENT", "jsonInput cannot be null", null)
                    }
                }
                "analyzeText" -> {
                    val textInput = call.argument<String>("textInput")
                    if (textInput != null) {
                        val analysis = dataTransformerWrapper.analyzeText(textInput)
                        result.success(analysis)
                    } else {
                        result.error("INVALID_ARGUMENT", "textInput cannot be null", null)
                    }
                }
                "convertFormat" -> {
                    val dataInput = call.argument<String>("dataInput")
                    val fromFormat = call.argument<String>("fromFormat")
                    val toFormat = call.argument<String>("toFormat")
                    if (dataInput != null && fromFormat != null && toFormat != null) {
                        val converted = dataTransformerWrapper.convertFormat(dataInput, fromFormat, toFormat)
                        result.success(converted)
                    } else {
                        result.error("INVALID_ARGUMENT", "All arguments must be non-null", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
