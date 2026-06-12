import Flutter
import UIKit
import workmanager_apple

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // WorkmanagerPlugin.registerBGProcessingTask(withIdentifier: "com.catimage.fetch_every_fifteen_minutes")
    // WorkmanagerPlugin.registerBGProcessingTask(withIdentifier: "com.catimage.fetch_every_two_hours")
    WorkmanagerPlugin.registerBGProcessingTask(withIdentifier: "com.catimage.fetch_once_today")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
