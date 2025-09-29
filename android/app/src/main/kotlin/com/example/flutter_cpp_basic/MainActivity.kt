package com.example.flutter_cpp_basic

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "cpp_counter_plugin"
    private lateinit var counterWrapper: CounterWrapper

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        counterWrapper = CounterWrapper()
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
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
    }
}
