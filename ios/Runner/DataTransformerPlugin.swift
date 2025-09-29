import Flutter
import UIKit

public class DataTransformerPlugin: NSObject, FlutterPlugin {
  private static let dataTransformer = DataTransformerWrapper()
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "cpp_data_transformer_plugin", binaryMessenger: registrar.messenger())
    let instance = DataTransformerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "transformJson":
      if let args = call.arguments as? [String: Any],
         let jsonInput = args["jsonInput"] as? String {
        let transformed = DataTransformerPlugin.dataTransformer.transformJson(jsonInput)
        result(transformed)
      } else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments for transformJson", details: nil))
      }
    case "analyzeText":
      if let args = call.arguments as? [String: Any],
         let textInput = args["textInput"] as? String {
        let analyzed = DataTransformerPlugin.dataTransformer.analyzeText(textInput)
        result(analyzed)
      } else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments for analyzeText", details: nil))
      }
    case "convertFormat":
      if let args = call.arguments as? [String: Any],
         let dataInput = args["dataInput"] as? String,
         let fromFormat = args["fromFormat"] as? String,
         let toFormat = args["toFormat"] as? String {
        let converted = DataTransformerPlugin.dataTransformer.convertFormat(dataInput, fromFormat: fromFormat, toFormat: toFormat)
        result(converted)
      } else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments for convertFormat", details: nil))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}