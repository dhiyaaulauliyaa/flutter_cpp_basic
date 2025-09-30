import Flutter
import UIKit

public class FileInfoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "cpp_file_info_plugin", binaryMessenger: registrar.messenger())
    let instance = FileInfoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "analyzeFile":
      guard let args = call.arguments as? [String: Any] else {
        result(FlutterError(code: "BAD_ARGS", message: "Missing args", details: nil))
        return
      }
      guard let path = args["path"] as? String else {
        result(FlutterError(code: "BAD_ARGS", message: "Missing path", details: nil))
        return
      }

      let dict = FileInfoWrapper.analyzeFile(atPath: path)
      result(dict)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
