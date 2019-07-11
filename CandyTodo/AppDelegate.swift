//
//  AppDelegate.swift
//  CandyTodo
//
//  Created by Gabor Sornyei on 2019. 05. 14..
//  Copyright © 2019. Gabor Sornyei. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        requestNotificationAuthorization(application: application)
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        if let _ = UserDefaults.standard.object(forKey: kSUMMARY_MESSAGES) as? Bool {
            // already set
        } else {
            UserDefaults.standard.set(true, forKey: kSUMMARY_MESSAGES)
        }
        if let _ = UserDefaults.standard.object(forKey: kNOTIFICATION_MESSAGES) as? Bool {
            // already set
        } else {
            UserDefaults.standard.set(true, forKey: kNOTIFICATION_MESSAGES)
        }
        if Auth.auth().currentUser != nil {
            window?.rootViewController = MainViewController()
        } else {
            if let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                window?.rootViewController = UINavigationController(rootViewController: loginViewController)
            }
        }
        window?.makeKeyAndVisible()
        return true
    }

    private func requestNotificationAuthorization(application: UIApplication) {
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        notificationCenter.requestAuthorization(options: options) { (granted, error) in
            if let error = error {
                print("Error requesting notifications:", error.localizedDescription)
            } else {
                UNUserNotificationCenter.current().delegate = self
            }
            
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        if UserDefaults.standard.bool(forKey: kSUMMARY_MESSAGES) {
            Firestore.fetchTodaysInCompletedTasks { (count, error) in
                if let error = error {
                    print("Error getting today's tasks:", error.localizedDescription)
                    return
                }
                NotificationPublisher.sendSummaryNotification(body: "Today you left \(count) incompleted tasks.")
            }
        }
        if UserDefaults.standard.bool(forKey: kNOTIFICATION_MESSAGES) {
            Firestore.fetchTasksForToday { (count, error) in
                if let error = error {
                    print("Error getting today's tasks:", error.localizedDescription)
                    return
                }
                NotificationPublisher.sendReminderNotification(body: "Today you have \(count) item on your list")
            }
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        application.applicationIconBadgeNumber = 0
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
    }


    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let options: UNNotificationPresentationOptions = [.alert, .badge, .sound]
        completionHandler(options)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}

