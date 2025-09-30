import Flutter
import UIKit

public class CounterPlugin: NSObject, FlutterPlugin {
  private static let counter = CounterWrapper()
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "cpp_counter_plugin", binaryMessenger: registrar.messenger())
    let instance = CounterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getValue":
      let value = CounterPlugin.counter.getValue()
      result(value)
    case "increment":
      CounterPlugin.counter.increment()
      result(nil)
    case "decrement":
      CounterPlugin.counter.decrement()
      result(nil)
    case "reset":
      CounterPlugin.counter.reset()
      result(nil)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}