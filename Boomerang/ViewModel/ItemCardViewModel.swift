//
//  ItemCardViewModel.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 1/9/2023.
//

import SwiftUI
import CoreData

class ItemCardViewModel: ObservableObject {
    private let item: Item
    private let viewContext: NSManagedObjectContext
    
    init(item: Item, viewContext: NSManagedObjectContext) {
        self.item = item
        self.viewContext = viewContext
    }
    
    @Published var isSwiped: Bool = false
    @Published var offset: CGFloat = 0
    
    func deleteItem() {
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) { [self] in
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
