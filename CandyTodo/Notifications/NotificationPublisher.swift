//
//  NotificationPublisher.swift
//  
//
//  Created by Gabor Sornyei on 2019. 06. 30..
//

import UIKit
import UserNotifications

class NotificationPublisher: NSObject {
    static func sendSummaryNotification(body: String) {
        // Current day
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Summary"
        notificationContent.body = body
        notificationContent.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        notificationContent.sound = .default
        let dateOfSummary = Calendar.current.startOfDay(for: Date()).addingTimeInterval(60 * 60 * 24 - 60)
        let dateOfSummaryDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateOfSummary)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateOfSummaryDateComponents, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error in sending notification:", error.localizedDescription)
            }
        }
        
        // Next day
        let notificationContentNextDay = UNMutableNotificationContent()
        notificationContentNextDay.title = "You might have missed a few tasks!"
        notificationContentNextDay.body = "You did not check out your todo list today!"
        notificationContentNextDay.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        notificationContentNextDay.sound = .default
        
        guard let dateOfNextSummary = Calendar.current.date(byAdding: .hour, value: 24, to: dateOfSummary) else {return}
        
        let dateOfNextSummaryDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateOfNextSummary)
        let triggerNextDay = UNCalendarNotificationTrigger(dateMatching: dateOfNextSummaryDateComponents, repeats: true)
        let requestNextDay = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContentNextDay, trigger: triggerNextDay)
        UNUserNotificationCenter.current().add(requestNextDay) { (error) in
            if let error = error {
                print("Error in sending next day notification:", error.localizedDescription)
            }
        }
    }
    
    static func sendReminderNotification(body: String) {
        // Current day
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Reminder"
        notificationContent.body = body
        notificationContent.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        notificationContent.sound = .default
        var dateOfReminder = Calendar.current.startOfDay(for: Date()).addingTimeInterval(60 * 60 * 8)
        let dateOfReminderDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateOfReminder)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateOfReminderDateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error in sending notification:", error.localizedDescription)
            }
        }
        
        // Next day
        let notificationContentNextDay = UNMutableNotificationContent()
        notificationContentNextDay.title = "You might have missed a few tasks!"
        notificationContentNextDay.body = "You did not check out your todo list today!"
        notificationContentNextDay.badge = NSNumber(value: UIApplication.shared.applicationIconBadgeNumber + 1)
        notificationContentNextDay.sound = .default
        
        guard let dateOfNextReminder = Calendar.current.date(byAdding: .hour, value: 24, to: dateOfReminder) else {return}
        
        let dateOfNextReminderDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateOfNextReminder)
        let triggerNextDay = UNCalendarNotificationTrigger(dateMatching: dateOfNextReminderDateComponents, repeats: true)
        let requestNextDay = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContentNextDay, trigger: triggerNextDay)
        UNUserNotificationCenter.current().add(requestNextDay) { (error) in
            if let error = error {
                print("Error in sending next day notification:", error.localizedDescription)
            }
        }
    }
    
}
