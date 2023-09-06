//
//  HeaderView.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 1/9/2023.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let itemCount: Int?

    var body: some View {
        HStack(spacing: 0) {
            Text(title)
                .font(.boldFont(size: 24))
            
            Spacer()
            
            if let itemCount = itemCount {
                Text("\(itemCount) items")
                    .font(.regularFont(size: 16))
            } else {
                Text(String(format: "Version %.1f", Version.current))
                    .font(.regularFont(size: 16))
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "Boomerang", itemCount: nil)
    }
}
