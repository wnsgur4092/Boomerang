//
//  BoomerangApp.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 29/7/2023.
//

import SwiftUI

@main
struct BoomerangApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootView()
            
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
