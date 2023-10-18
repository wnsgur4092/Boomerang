//
//  BoomerangCardView.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 16/10/2023.
//

import SwiftUI
import CoreData

struct BoomerangCardView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) private var viewContext
    var notificationHandler = NotificationHandler()
    @ObservedObject var viewModel : ItemCardViewModel
    
    @State private var isResendAndEditButtonVisible: Bool = false
    
    
    var item : Item
    @State private var isSwiped: Bool = false
    @State private var offset: CGFloat = 0
    
    //MARK: - BODY
    var body: some View {
        ZStack{
            LinearGradient(gradient: .init(colors: [Color("lightred"),Color("red")]), startPoint: .leading, endPoint: .trailing)
                .cornerRadius(8)
            //                .frame(height: 300)
            
            // Delete Button
            deleteButton
            
            VStack(alignment:.leading, spacing: 20){
                HStack(alignment: .center){
                    dayString
                    
                    Spacer()
                    
                    timeString
                        .foregroundColor(.gray)
                }
                
                boomerang
                Divider()
                
                HStack{
                    Text(item.priority ? "🔥" : "")
                    Spacer()
                    resendButton
                }
                
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
            //            .frame(height: 300)
        }
        
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
    
    fileprivate var dayString: some View {
        let monthDay = item.timestamp?.formattedAsDayMonth() ?? Date().formattedAsDayMonth()
        
        return Text(monthDay)
            .padding(.horizontal,8)
            .padding(.vertical,4)
            .font(Font.boldFont(size: 16))
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color("maincolor")))
        
        
        // .font(Font.boldFont(size: 16))
        // .foregroundColor(colorScheme == .dark ? Color.onBackgroundPrimary : Color.primary)
    }
    
    
    fileprivate var timeString: some View {
        let timeValue = viewModel.separateDateComponents(from: item.timestamp ?? Date()).1
        
        return Text(timeValue)
            .font(Font.regularFont(size: 16))
        //            .font(Font.regularFont(size: 14))
        //            .foregroundColor(colorScheme == .dark ? Color.onBackgroundSecondary : Color.secondary)
    }
    
    fileprivate var boomerang : some View {
        Text(item.task ?? "Eggs, milk, passport, coffee, ice, drinks, water, what else do you think u need? Pho, and beef noode soup and this is what I like")
            .font(Font.mediumFont(size: 18))
        //                .foregroundColor(colorScheme == .dark ? Color.black : Color.primary)
            .multilineTextAlignment(.leading)
            .lineLimit(3)
    }
    
    fileprivate var resendButton : some View {
        Button(action: {
            notificationHandler.sendNotificationAgain(task: item.task ?? "", priority: item.priority)
        }, label: {
            HStack{
                Text("Resend")
                Image(systemName: "arrow.up")
            }
            .font(Font.regularFont(size: 12))
            .padding(.horizontal,8)
            .padding(.vertical,4)
            .background(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 1).opacity(0.3))
        })
    }

    
}

//MARK: - PREVIEW
struct BoomerangCard_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        let dummyItem = Item(context: viewContext)
        
        let viewModel = ItemCardViewModel(item: dummyItem, viewContext: viewContext)
        
        return BoomerangCardView(viewModel: viewModel, item: dummyItem)
            .environment(\.managedObjectContext, viewContext)
    }
}

