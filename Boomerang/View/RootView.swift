//
//  RootView.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 29/7/2023.
//

import SwiftUI
import CoreData

struct RootView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var selectedTab : Tabs = .home
   
    
    var body: some View {
        VStack{
            if selectedTab == .home {
                HomeView()
            } else {
                SettingView(viewModel: SettingViewModel(viewContext: viewContext))
            }
            Spacer()

            CustomTabBar(selectedTab: $selectedTab, viewContext: viewContext)

        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
