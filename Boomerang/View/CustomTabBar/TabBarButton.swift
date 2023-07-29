//
//  TabBarButton.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 29/7/2023.
//

import SwiftUI

struct TabBarButton: View {
    //MARK: - PROEPRTEIS
    var buttonText : String
    var ImageName : String
    var isActive : Bool
    
    //MARK: - BODY
    var body: some View {
        GeometryReader { geo in
            
            if isActive {
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: geo.size.width/2, height: 4)
                    .padding(.leading, geo.size.width / 4)
            }
            
            VStack(alignment: .center, spacing : 4){
                Image(systemName: ImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Text(buttonText)
                    .font(Font.tabBar)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButton(buttonText: "Home", ImageName: "house", isActive: true)
    }
}
