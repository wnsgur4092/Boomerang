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
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    private var itemsGroupedByYear: [String: [Item]] {
        Dictionary(grouping: items, by: { "\(Calendar.current.component(.year, from: $0.timestamp ?? Date()))" })
    }
    
    //MARK: - BODY
    var body: some View {
        header
        
        if items.isEmpty {
            emptyView
        } else {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(itemsGroupedByYear.sorted(by: { $0.key > $1.key }), id: \.key) { year, itemsInYear in
                    Section(header: yearView(for: year)) {
                        ForEach(itemsInYear, id: \.self) { item in
                            itemCard(viewModel: ItemCardViewModel(item: item, viewContext: viewContext), item: item)
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - COMPONENTS
    fileprivate var header : some View {
        HStack(spacing: 0) {
            Text("Boomerang")
                .font(.boldFont(size: 24))
            
            Spacer()
            
            Text("\(items.count) items")
                .font(.regularFont(size: 16))
        }
    }
    
    fileprivate var emptyView : some View {
        VStack(spacing: 4) {
            Spacer()
            
            HStack{
                Text("Tap the")
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .scaledToFit()
                Text("button")
            }
            Text("below to create a new task")
            
            Spacer()
        }
        .font(.regularFont(size: 18))
        .foregroundColor(.onBackgroundSecondary)
        .padding()
    }
    
    private func yearView(for year: String) -> some View {
        HStack {
            Text(year)
                .font(.mediumFont(size: 24))
                .foregroundColor(.onBackgroundSecondary)
            
            Spacer()
        }
    }
}

//MARK: - PREVIEW
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
