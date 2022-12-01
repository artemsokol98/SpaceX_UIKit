//
//  AppDelegate.swift
//  SpaceX_Storyboard_UIKit
//
//  Created by Артем Соколовский on 13.08.2022.
//

import UIKit
import Firebase
import FirebaseMessaging
// import UserNotifications
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: - Push notifications plug-in
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, _ in
            guard success else {
                return
            }
            
            print("Success in APNS registry")
        }
        application.registerForRemoteNotifications()
        
        // MARK: - Google maps api
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
        DIContainer.shared.networkManager.fetchInformation(urlString: URLs.rocketModel.rawValue, expectingType: [RocketModel].self) {
            NotificationCenter.default.post(name: Notification.Name(NotificationNames.dataDownloaded), object: nil)
            MainViewController.canIFetchData = true
            // notification center
        }
        DIContainer.shared.networkManager.fetchInformation(urlString: URLs.rocketLaunches.rawValue, expectingType: [RocketLaunches].self) {
            print("Launches have loaded")
        }
        DIContainer.shared.networkManager.fetchInformation(urlString: URLs.launchPads.rawValue, expectingType: [LaunchPadModel].self) {
            print("LaunchPads have loaded")
        }
        DIContainer.shared.networkManager.fetchInformation(urlString: URLs.landingPads.rawValue, expectingType: [LandingPadModel].self) {
            print("LandingPads have loaded")
        }
        return true
    }
    
    // MARK: - For Push Notifications
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else {
                return
            }
            print("Token: \(token)")
        }
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
