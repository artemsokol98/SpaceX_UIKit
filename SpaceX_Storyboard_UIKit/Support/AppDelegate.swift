//
//  AppDelegate.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 13.08.2022.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var apiKey: String {
            guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
                  fatalError("Couldn't find file 'TMDB-Info.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "GoogleMapsAPI_KEY") as? String else {
                  fatalError("Couldn't find key 'GoogleMapsAPI_KEY' in 'Info.plist'.")
            }
            return value
        }
        GMSServices.provideAPIKey(apiKey)
        
        NetworkManager.shared.fetchInformation(urlString: URLs.rocketModel.rawValue, expectingType: [RocketModel].self) {
            NotificationCenter.default.post(name: Notification.Name(NotificationNames.dataDownloaded), object: nil)
            MainViewController.canIFetchData = true
            // notification center
        }
        NetworkManager.shared.fetchInformation(urlString: URLs.rocketLaunches.rawValue, expectingType: [RocketLaunches].self) {
            print("Launches have loaded")
        }
        
        NetworkManager.shared.fetchInformation(urlString: URLs.launchPads.rawValue, expectingType: [LaunchPadModel].self) {
            print("LaunchPads have loaded")
        }
        
        NetworkManager.shared.fetchInformation(urlString: URLs.landingPads.rawValue, expectingType: [LandingPadModel].self) {
            print("LandingPads have loaded")
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
