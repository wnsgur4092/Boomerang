//
//  NotificationHandler.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 2/8/2023.
//

import Foundation
import UserNotifications
import UIKit

class NotificationHandler: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.delegate = self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .sound, .badge])
    }
    
    func sendNotification(date: Date, type: String, timeInterval: Double = 1, title: String, body: String) {
        var trigger: UNNotificationTrigger?

        if type == "date" {
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        } else if type == "time" {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        }

        let content = UNMutableNotificationContent()
        content.title = title // Set title from the parameter
        content.body = body
        content.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func sendNotificationAgain(task: String, priority: Bool) {
         let timeInterval: Double = 1
        let title = priority ? "Boomerang🔥" : "Boomerang"
         let body = task

         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)

         let content = UNMutableNotificationContent()
         content.title = title
         content.body = body
         content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
         UNUserNotificationCenter.current().add(request)
     }
}
