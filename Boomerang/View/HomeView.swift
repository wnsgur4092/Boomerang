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
    
    private var categorizedItems: [String: [Item]] {
        let todayItems = items.filter {
            Calendar.current.isDateInToday($0.timestamp ?? Date())
        }
        let previousItems = items.filter {
            !Calendar.current.isDateInToday($0.timestamp ?? Date())
        }
        
        var result: [String: [Item]] = [:]
        if !todayItems.isEmpty {
            result["TODAY"] = todayItems
        }
        if !previousItems.isEmpty {
            result["PREVIOUS"] = previousItems
        }
        return result
    }
    
    
    //MARK: - BODY
    var body: some View {
        header
        
        if items.isEmpty {
            emptyView
        } else {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(categorizedItems.keys.sorted(by: { $0 == "TODAY" ? true : ($1 == "TODAY" ? false : ($0 < $1)) }), id: \.self) { category in
                    Section(header: categoryView(for: category)) {
                        ForEach(categorizedItems[category]!, id: \.self) { item in
                            BoomerangCardView(viewModel: ItemCardViewModel(item: item, viewContext: viewContext), item: item)
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
    
    private func categoryView(for category: String) -> some View {
        HStack {
            Text(category)
                .font(Font.regularFont(size: 20))
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
