//
//  HomeView.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 29/7/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    //MARK: - PROPERTIES
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //MARK: - BODY
    var body: some View {
        header
        
        ForEach(self.items, id: \.self) { item in
            itemCard(taskName: item.task ?? "Error")
        }

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
    
}

struct itemCard : View {
    var taskName : String
//    var date : String
//    var time : String

    var body : some View {
        HStack{
            Text("Default")
            
            Spacer()
            
            Text(taskName)
            
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
