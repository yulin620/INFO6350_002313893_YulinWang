import Flutter
import UIKit
import GoogleMaps


@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyC4QVcuR0kkGyodY91kjvbU08fL-h6AwnY")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
