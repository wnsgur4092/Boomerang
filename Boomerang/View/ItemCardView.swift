//
//  ItemCardView.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 1/9/2023.
//

import SwiftUI
import CoreData

struct itemCard : View {
    //MARK: - PROPERTIES
    @Environment(\.managedObjectContext) private var viewContext
    var notificationHandler = NotificationHandler()
    @ObservedObject var viewModel: ItemCardViewModel
    
    var item : Item
    @State private var isSwiped: Bool = false
    @State private var offset: CGFloat = 0
    
    //MARK: - BODY
    var body : some View {
        ZStack{
            LinearGradient(gradient: .init(colors: [Color("lightred"),Color("red")]), startPoint: .leading, endPoint: .trailing)
                .cornerRadius(8)
 
            // Delete Button
            deleteButton
   
            //Item Card
            HStack(spacing: 0) {
                dayAndTime
                
                Divider()
                    .frame(width: 1, height: 32)
                    .padding(.horizontal, 12)
                
                boomerang
                
                Spacer()
                
                resendButton
            }
            .zIndex(1)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .background(Color.onBackgroundTertiary)
            .cornerRadius(8)
            .offset(x: viewModel.offset)
            .gesture(
                DragGesture()
                    .onChanged(viewModel.onChanged)
                    .onEnded(viewModel.onEnd)
            )
        }
        .frame(height: 64)
    }
    
    //MARK: - COMPONENTS
    fileprivate var deleteButton : some View {
        HStack{
            Spacer()
            Button(action: {
                viewModel.deleteItem()
            }) {
                Image(systemName: "trash")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 90, height: 50)
            }
        }
    }
    
    fileprivate var dayAndTime: some View {
        let (monthDay, time) = viewModel.separateDateComponents(from: item.timestamp ?? Date())
        
        return VStack(alignment: .leading) {
            Text(monthDay)
                .font(.boldFont(size: 16))
            Text(time)
                .font(.regularFont(size: 14))
                .foregroundColor(.secondary)
        }
        .frame(width: 60)
    }
    
    fileprivate var boomerang : some View {
        HStack {
            Text(item.task ?? "")
                .font(.mediumFont(size: 18))
                .multilineTextAlignment(.leading)
                .lineLimit(1)
            Spacer()
        }
    }
    
    fileprivate var resendButton : some View {
        Button {
            notificationHandler.sendNotificationAgain(task: item.task ?? "")
        } label: {
            Image(systemName: "arrow.up")
                .resizable()
                .frame(width: 12, height: 16)
                .foregroundColor(Color.onBackgroundSecondary)
        }
    }
}

//MARK: - PREVIEW
struct itemCard_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        let dummyItem = Item(context: viewContext)
        
        let viewModel = ItemCardViewModel(item: dummyItem, viewContext: viewContext)
        
        return itemCard(viewModel: viewModel, item: dummyItem)
            .environment(\.managedObjectContext, viewContext)
    }
}

