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
    @FocusState private var textFieldFocused
    
    @Environment(\.managedObjectContext) private var viewContext
    
    func configurePopup(popup: CentrePopupConfig) -> CentrePopupConfig {
        popup
    }
    
    func createContent() -> some View {
        VStack(spacing: 0) {
            Spacer.height(24)
            createIllustration()
                .padding(.vertical, 20)
            
            createHeader()
                .padding(.top, 24)
                .padding(.bottom, 20)
            
            
            
            createTextField()
                .padding(.vertical, 32)
            
            Spacer.height(32)
            
            HStack(spacing: 24){
                createCancelButton()
                createSaveButton()
            }
            
            Spacer.height(24)
        }
        .padding(.horizontal, 20)
        .onAppear(perform: onAppear)
    }
}

private extension PopUpView {
    func createIllustration() -> some View {
        Image("boomerang")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 100)
    }
    func createHeader() -> some View {
        Text("Boomerang:")
            .font(.boldFont(size: 18))
        //            .font(.interBold(18))
            .foregroundColor(.onBackgroundPrimary)
    }
    func createTextField() -> some View {
        TextField("??", text: $task)
            .font(.mediumFont(size: 24))
            .foregroundColor(.onBackgroundPrimary)
        
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity)
            .focused($textFieldFocused)
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
                .cornerRadius(8)
            
        }
    }
    
    func createSaveButton() -> some View {
        Button(action: addItem) {
            Text("Send".uppercased())
                .font(.boldFont(size: 16))
                .foregroundColor(task.isEmpty ? Color.blue : Color.white)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
        }
        .background(task.isEmpty ? Color.clear : Color.blue) // 배경 조건 설정
        .overlay(RoundedRectangle(cornerRadius: 8) // 테두리 추가
            .stroke(task.isEmpty ? Color.blue : Color.clear, lineWidth: 2)) // 테두리 조건 설정
        .cornerRadius(8)
        .disabled(task.isEmpty) // task가 비어 있으면 비활성화
    }
    
    
    func addItem() {
        if self.task != "" {
            let newTask = Item(context: viewContext)
            newTask.id = UUID()
            newTask.task = task
            newTask.timestamp = Date()
            
            let notificationHandler = NotificationHandler()
            //            notificationHandler.sendNotification(with: newTask.task ?? "") // Calling sendNotification method
            notificationHandler.sendNotification(date: Date(), type: "time", title: "Boomerang", body: task)// Calling sendNotification method
            
            
            
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


