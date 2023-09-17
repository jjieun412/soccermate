import UIKit
import Flutter
import GoogleMaps
import CoreLocation


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GMSServices.provideAPIKey(Storage().googleMapApiKey)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
