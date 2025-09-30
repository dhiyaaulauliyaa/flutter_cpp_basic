import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Register custom C++ plugins
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    CounterPlugin.register(with: controller.registrar(forPlugin: "CounterPlugin")!)
    DataTransformerPlugin.register(with: controller.registrar(forPlugin: "DataTransformerPlugin")!)
    FileInfoPlugin.register(with: controller.registrar(forPlugin: "FileInfoPlugin")!)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
