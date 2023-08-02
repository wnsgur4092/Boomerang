//
//  RootView.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 29/7/2023.
//

import SwiftUI

struct RootView: View {
    @State var selectedTab : Tabs = .home
    var body: some View {
        VStack{
            if selectedTab == .home {
                HomeView()
            }
            
            Spacer()

            CustomTabBar(selectedTab: $selectedTab)
        }
        .padding(.horizontal, 20)
    }
    
 
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
