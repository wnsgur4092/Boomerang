//
//  BoomerangApp.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 29/7/2023.
//

import SwiftUI
import PopupView

@main
struct BoomerangApp: App {
    @UIApplicationDelegateAdaptor(NotificationHandler.self) var appDelegate
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .implementPopupView(config: configurePopup)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

private extension BoomerangApp {
    func configurePopup(_ config: GlobalConfig) -> GlobalConfig {
        config
        .centre { $0
            .tapOutsideToDismiss(false)
        }
    }
}


//@main
//struct BoomerangApp: App {
//    @UIApplicationDelegateAdaptor(NotificationHandler.self) var appDelegate
//    let persistenceController = PersistenceController.shared
//
//    var body: some Scene {
//
//        WindowGroup {
//            RootView()
//                .implementPopupView(config: configurePopup)
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//        //        WindowGroup {
//        //            RootView()
//        //            ContentView()
//        //                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        //        }
//    }
//}
//
//
//private extension BoomerangApp {
//    func configurePopup(_ config: GlobalConfig) -> GlobalConfig { config
//        //        .top { $0
//        //            .cornerRadius(24)
//        //            .dragGestureEnabled(true)
//        //        }
//        .centre { $0
//            .tapOutsideToDismiss(false)
//        }
//        //        .bottom { $0
//        //            .stackLimit(4)
//        //        }
//    }
//}
