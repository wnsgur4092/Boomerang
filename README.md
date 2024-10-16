# Boomerang
### ***“We see notifications even without opening our notepads, don't we? 🤔”***
Send your thoughts flying and receive them as instant notifications

Development periold: 29.07.2023 ~ 06.09.2023

[![appStore](https://user-images.githubusercontent.com/50910456/173174832-7d395623-ceb3-4796-b718-22e550af6934.svg)](https://apps.apple.com/au/app/boomerang-reminder/id6464021812)

## About
Boomerang - Reminder : The Reminder App for those who’d rather not open a notepad or notes.

🙋🏻‍♂️ **Boomerang user’s characteristic:**

1. Folks who often forget what they've written, even when using sticky notes or note-taking apps.
2. People who have a hard time keeping track of their daily schedules.
3. Those who find it a bit too bothersome to open a notepad.

📍**Boomerang Features:**

- Get your reminders delivered as quick notifications; just a single swipe on your lock screen to check them.
- Easily send a reminder you've written before.
- Review your reminders categorised by the year they were made.

## Preview
<img src="https://github.com/wnsgur4092/Boomerang/assets/43236727/1035bb82-017d-4cde-bc31-e1bf37cdaab4">

## Update
- Version 1.1 : Realse on AppStore (06.09.2023)

## Develop Environment
- Language : Swift 5.6
- iOS Deployment Target : 16.4
- Xcode : 14.3.1

## Tech
- UIKit
- SwiftUI
- MVVM
- Combine
- CoreData
- PopupView
- Local Notification

## Privacy Policy
- [Privacy Policy](https://wnsgur4092.notion.site/Privacy-Policy-19722dcba877400784abd66352623d04)

## 💡Challenge
1. Local Notification
- Implementing Local Notifications in Boomerang was essential for delivering reminders instantly, allowing users to view them directly on the lock screen. This feature was challenging because it required a comprehensive understanding of the UserNotifications framework to configure different types of notifications, such as date-based and time interval notifications.The purpose of Local Notifications was to ensure that reminders were visible even without opening the app, making it more convenient for users. Here’s a snippet of how notifications were set up:

```swift
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
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
```

2. CoreData
- While I typically prefer Realm for data storage, I encountered issues with compatibility across different iOS versions, causing bugs and app crashes. To resolve these problems, I switched to Core Data, Apple’s native data persistence framework. Core Data’s tight integration with iOS ensured stability and eliminated the version-specific issues that were problematic with Realm.

```swift
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Boomerang")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
```
- Switching to Core Data allowed for greater stability, leveraging Apple’s support for iOS data management. This persistence framework provided reliability, which was essential for managing user reminders in Boomerang.
