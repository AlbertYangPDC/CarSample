//
//  Dr. Ing. h.c. F. Porsche AG confidential. This code is protected by intellectual property rights.
//  The Dr. Ing. h.c. F. Porsche AG owns exclusive legal rights of use.
//

import UIKit

import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var locationManager: CLLocationManager?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        locationManager = CLLocationManager()
        if locationManager?.authorizationStatus == .notDetermined {
            locationManager?.requestWhenInUseAuthorization()
        }
        locationManager?.startUpdatingLocation()
        return true
    }
}

