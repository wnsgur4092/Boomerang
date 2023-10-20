//
//  PopUpView.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 29/7/2023.
//

import SwiftUI
import PopupView
import Foundation

struct PopUpView: CentrePopup {
    //MARK: - PROPERTIES
    @State var task: String = ""
    @State private var isPriority: Bool = false
    
    @FocusState private var textFieldFocused
    
    @Environment(\.managedObjectContext) private var viewContext
    
    func configurePopup(popup: CentrePopupConfig) -> CentrePopupConfig {
        popup
    }
    
    func createContent() -> some View {
        VStack(spacing: 20) {
            Spacer.height(20)
        
            createHeader()
            
            Spacer.height(10)
            
            createSubHeader()
            
            Spacer.height(20)
            
            createTextField()
//                .padding(.vertical, 32)
            
            Spacer.height(20)
            
            HStack(spacing: 24){
                createCancelButton()
                createSaveButton()
            }
            
            Spacer.height(20)
        }
        .padding(.horizontal, 32)
        .background(Color.onPopUpColor)
        .cornerRadius(20)
        .onAppear(perform: onAppear)
    }
}

private extension PopUpView {
    func createIllustration() -> some View {
        Image("boomerang")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 50)
    }
    
    func createHeader() -> some View {
        HStack(alignment: .center){
            Text("Create a New Boomerang:")
                .font(.boldFont(size: 18))
            //            .font(.interBold(18))
                .foregroundColor(.primary)
   
            
            Spacer()
        }

    }
    
    func createSubHeader() -> some View {
        HStack(alignment: .center){
            Text("Is this important?")
                .font(Font.regularFont(size: 16))
                .foregroundColor(.gray)
            
            Spacer()
            
            HStack{
                Toggle(isOn: $isPriority) {
                    Text("🔥")
                }
                .toggleStyle(CheckboxToggleStyle())
            }
            
        }
    }
    
    
    func createTextField() -> some View {
        VStack(alignment: .leading, spacing: 12){
            TextField("", text: $task)
                .font(.mediumFont(size: 24))
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading) // <-- Change this line
                .frame(maxWidth: .infinity)
                .focused($textFieldFocused)
            
            RoundedRectangle(cornerRadius: 4).frame(height: 1)
                .foregroundColor(.secondary)
        }
    }
    
    
    func createCancelButton() -> some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel".uppercased())
                .font(.boldFont(size: 16))
                .foregroundColor(.white)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
            
                .background(Color.gray)
                .cornerRadius(12)
            
        }
    }
    
    func createSaveButton() -> some View {
        Button(action: addItem) {
            HStack(alignment: .center){
                Text("Send".uppercased())
                
                Image(systemName: "arrow.up")
            }
            .offset(x: 7)
            .font(.boldFont(size: 16))
            .foregroundColor(task.isEmpty ? Color.onMainColor : Color.white)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
        }
        .background(task.isEmpty ? Color.clear : Color.onMainColor)
        .overlay(RoundedRectangle(cornerRadius: 12)
            .stroke(task.isEmpty ? Color.onMainColor : Color.clear, lineWidth: 2))
        .cornerRadius(12)
        .disabled(task.isEmpty)
    }
    
    
    func addItem() {
        if self.task != "" {
            let newTask = Item(context: viewContext)
            newTask.id = UUID()
            newTask.task = task
            newTask.timestamp = Date()
            newTask.priority = isPriority
            
            let notificationHandler = NotificationHandler()
            //            notificationHandler.sendNotification(with: newTask.task ?? "") // Calling sendNotification method
            notificationHandler.sendNotification(date: Date(), type: "time", title: isPriority ? "Boomerang🔥" : "Boomerang", body: task)// Calling sendNotification method
            
            dismiss()
            
            do {
                try viewContext.save()
                
            } catch {
                print(">>>>> Error saving task: \(error)")
                print("More detailed error: \(error.localizedDescription)")
                let nsError = error as NSError
                print("Detailed error description: \(nsError.userInfo)")
            }
        }
    }
}

private extension PopUpView {
    func onAppear() {
        textFieldFocused = true
    }
}


struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label  // The label (Text("Check me!"))
            
            //            Spacer()
            
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .frame(width: 24, height: 24)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}
