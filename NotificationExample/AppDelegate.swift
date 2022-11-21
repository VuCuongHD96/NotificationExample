//
//  AppDelegate.swift
//  NotificationExample
//
//  Created by sun on 10/11/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let center = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerForPushNotifications()
        return true
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("------ deubug ---------- token = ", token)
    }
}

extension AppDelegate {
    
    func registerForPushNotifications() {
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] (granted, error) in
            guard let self = self else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        center.getNotificationSettings { [weak self] settings in
            guard let self = self else { return }
            self.setupNotificationSetting(settings: settings)
        }
    }
    
    func setupNotificationSetting(settings: UNNotificationSettings) {
        if settings.authorizationStatus == .authorized {
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        } else {
            let allowNotificationViewModel = AllowNotificationTutorialViewModel()
            allowNotificationViewModel.showTutorial()
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("----- debug ----- willPresent")
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("----- debug ----- didReceive")
        completionHandler()
    }
}
