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
            //            Spacer.height(24)
            //            createIllustration()
            //            Spacer.height(20)
            createHeader()
                .padding(.top, 24)
                .padding(.bottom, 20)
            //            Spacer.height(8)
            createTextField()
                .padding(.bottom, 32)
            //            Spacer.height(32)
            HStack{
                createCancelButton()
                createSaveButton()
            }
            .padding(.bottom, 24)
       
            //            Spacer.height(24)
        }
        .onAppear(perform: onAppear)
    }
}

private extension PopUpView {
    func createIllustration() -> some View {
        Image("dotty-1")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 100)
    }
    func createHeader() -> some View {
        Text("Boomerang:")
            .font(.boldFont(size: 18))
        //            .font(.interBold(18))
        //            .foregroundColor(.onBackgroundPrimary)
    }
    func createTextField() -> some View {
        TextField("Task?", text: $task)
        //            .font(.interBold(24))
        //            .foregroundColor(.onBackgroundPrimary)
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
            //                .font(.interBold(15))
                .foregroundColor(.white)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                .cornerRadius(8)
                .padding(.horizontal, 24)
        }
    }
    
    func createSaveButton() -> some View {
        Button(action: addItem) {
            Text("Send".uppercased())
            //                .font(.interBold(15))
                .foregroundColor(.white)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(Color.primary)
                .cornerRadius(8)
                .padding(.horizontal, 24)
        }
    }
    
    func addItem() {
        if self.task != "" {
            let newTask = Item(context: viewContext)
            newTask.id = UUID()
            newTask.task = task
            newTask.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                print(">>>>> Error saving task: \(error)")
                print("More detailed error: \(error.localizedDescription)")
                let nsError = error as NSError
                print("Detailed error description: \(nsError.userInfo)")
            }

        }
        // 빈 작업 항목을 생성하는 코드는 제거
    }
}

private extension PopUpView {
    func onAppear() {
        textFieldFocused = true
    }
}


