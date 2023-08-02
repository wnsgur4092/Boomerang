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
            .onAppear {
                   // Asking for notification permission when the view appears
//                   NotificationHandler().askPermission()
               }
        
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(itemsGroupedByYear.sorted(by: { $0.key > $1.key }), id: \.key) { year, itemsInYear in
                Section(header: yearView(for: year)) {
                    ForEach(itemsInYear, id: \.self) { item in
                        itemCard(item: item)
                    }
                    
                }
            }
        }
    }
    
    
    
    private func yearView(for year: String) -> some View {
        HStack {
            Text(year)
                .font(.headline)
            
            Spacer()
        }
    }
    
    
    fileprivate var header : some View {
        HStack(spacing: 0) {
            Text("Boomerang")
                .font(.boldFont(size: 24))
            
            Spacer()
            
            Text("\(items.count) items")
                .font(.regularFont(size: 16))
        }
    }
    
}

struct itemCard : View {
    @Environment(\.managedObjectContext) private var viewContext
    var notificationHandler = NotificationHandler() // NotificationHandler 인스턴스 생성
    
    var item : Item
    @State private var isSwiped: Bool = false
    @State private var offset: CGFloat = 0
    
    var body : some View {
        let (monthDay, time) = separateDateComponents(from: item.timestamp ?? Date())
        
        ZStack{
            LinearGradient(gradient: .init(colors: [Color("lightblue"),Color("blue")]), startPoint: .leading, endPoint: .trailing)
            
            // Delete Button..
            
            HStack{
                
                Spacer()
                
                Button(action: {
                  
                        deleteItem()
                    
                }) {
                    
                    Image(systemName: "trash")
                        .font(.title)
                        .foregroundColor(.red)
                    // default Frame....
                        .frame(width: 90, height: 50)
                }
            }
            
            
            HStack(spacing: 0){
                VStack(alignment:.leading){
                    Text(monthDay)
                        .font(.boldFont(size: 20))
                    Text(time)
                        .font(.regularFont(size: 16))
                        .foregroundColor(.secondary)
                }
                
                Divider()
                    .frame(width: 1, height: 32)
                    .padding(.horizontal, 12)
                
                
                HStack{
                    Text(item.task ?? "")
                        .font(.regularFont(size: 18))
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    
                    Spacer()
                }
     
                
                Spacer()
                
                Button {
                    notificationHandler.sendNotificationAgain(task: item.task ?? "")
                } label: {
                    Image(systemName: "arrow.up")
                        .resizable()
                        .frame(width: 12, height: 16)
                        .foregroundColor(Color.onBackgroundSecondary)
                }
            }
            .zIndex(1)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .background(Color.onBackgroundTertiary)
            .cornerRadius(8)
            .offset(x: offset) // Applying the offset here
            .gesture(
                        DragGesture()
                            .onChanged(onChanged)
                            .onEnded(onEnd)
                    )
        }
    }
    
    private func deleteItem() {
        viewContext.delete(item)
        do {
            try viewContext.save()
        } catch {
            // Handle the error here
            print("Error deleting item: \(error)")
        }
    }
    
    func separateDateComponents(from date: Date) -> (monthDay: String, time: String) {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)

        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale(identifier: "en_US") // 영어로 설정
        let time = dateFormatter.string(from: date)

        return (monthDay: String(format: "%02d.%02d", day, month), time: time) // DD/MM 순서로 변경
    }
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.width < 0 {
            if isSwiped {
                offset = value.translation.width - 90
            } else {
                offset = value.translation.width
            }
        }
    }

    func onEnd(value: DragGesture.Value) {
        withAnimation(.easeOut) {
            if value.translation.width < 0 {
                if -value.translation.width > UIScreen.main.bounds.width / 2 {
                    offset = -1000
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                        deleteItem()
                    }
                } else if -offset > 50 {
                    isSwiped = true
                    offset = -90
                } else {
                    isSwiped = false
                    offset = 0
                }
            } else {
                isSwiped = false
                offset = 0
            }
        }
    }


    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
