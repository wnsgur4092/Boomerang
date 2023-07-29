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
            Text("Hello, World!")
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
