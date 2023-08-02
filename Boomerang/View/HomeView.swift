//
//  HomeView.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 29/7/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        header
        
        item

    }
    
    fileprivate var header : some View {
        HStack(spacing: 0) {
            Text("Boomerang")
                .font(.boldFont(size: 24))
            
            Spacer()
            
            Text("2 items")
                .font(.regularFont(size: 16))
        }
    }
    
    fileprivate var item : some View {
        HStack{
            Text("Default")
            
            Spacer()
            
            Text("Your Task")
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "arrow.up")
                    .resizable()
                    .frame(width: 12, height: 16)
                    .foregroundColor(Color.onBackgroundSecondary)
            }
        }
        .frame(width: .infinity)
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(Color.onBackgroundTertiary)
        .cornerRadius(8)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
