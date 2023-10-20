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

    @AppStorage("hasSeenOnBoarding") var hasSeenOnBoarding: Bool = false

    var body: some Scene {
        WindowGroup {
            if hasSeenOnBoarding {
                RootView()
                    .implementPopupView(config: configurePopup)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            } else {
                OnBoardingView()
            }
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


