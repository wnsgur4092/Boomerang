//
//  CustomTabBar.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 29/7/2023.
//

import SwiftUI
import PopupView

enum Tabs : Int {
    case home = 0
    case setting = 2
}

struct CustomTabBar: View {
    //MARK: - PROPERTIES
    @Binding var selectedTab : Tabs
    
    //MARK: - BODY
    var body: some View {
        HStack(alignment: .center){
            Button {
                selectedTab = .home
            } label: {
                TabBarButton(buttonText: "Home", ImageName: "house", isActive: selectedTab == .home)
            }
            .tint(Color.gray)
            
            Button {
                PopUpView().showAndStack()
            } label: {
                VStack(alignment: .center, spacing : 4){
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    
                    Text("New")
                        .font(Font.tabBar)
                }
            }
            .tint(Color.blue)
            
            Button {
                selectedTab = .setting
            } label: {
                TabBarButton(buttonText: "Setting", ImageName: "gear", isActive: selectedTab == .setting)
            }
            .tint(Color.gray)

        }
        .frame(height: 82)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.home))
    }
}
