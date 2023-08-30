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
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else if let error = error {
                print(error.localizedDescription)
                print("Notification permission denied.")
            }
        }
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .sound, .badge]) // 여기서 알림의 표시 방식을 설정합니다.
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
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func sendNotificationAgain(task: String) {
         // 알림을 보내려는 작업과 관련된 정보를 구성합니다.
         // 예를 들어, 시간 간격, 제목, 본문 등을 설정할 수 있습니다.

         let timeInterval: Double = 1 // 재알림의 시간 간격 (예: 1초 뒤)
         let title = "Boomerang" // 알림 제목
         let body = task // 알림 본문

         // 알림 트리거 생성 (여기서는 시간 간격 트리거 사용)
         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)

         // 알림 내용 생성
         let content = UNMutableNotificationContent()
         content.title = title
         content.body = body
         content.sound = UNNotificationSound.default

         // 알림 요청 생성 및 예약
         let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
         UNUserNotificationCenter.current().add(request)
     }
}
