//
//  SettingView.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 4/8/2023.
//

import SwiftUI
import UserNotifications
import UIKit
import CoreData

struct SettingView: View {
    //MARK: - PROPERTIES
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var viewModel: SettingViewModel
    @State var showToast = false
    
    init(viewModel: SettingViewModel) {
        self.viewModel = viewModel
    }
    
    //MARK: - BODY
    var body: some View {
        VStack {
            header
            
            VStack(spacing: 32) {
                notificationURLButton
                deleteAllButton
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Delete All Data"),
                    message: Text("Are you sure you want to delete all Boomerangs?"),
                    primaryButton: .default(Text("Cancel")),
                    secondaryButton: .destructive(Text("Delete"), action: {
                        viewModel.deleteAllData()
                        self.showToast.toggle()
                    })
                )
            }
        }
    }
    
    //MARK: - COMPONENTS
    
    fileprivate var header: some View {
        HeaderView(title: "Setting", itemCount: nil)
    }
    
    fileprivate var notificationURLButton: some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.openNotificationSettings()
                }) {
                    Text("Open Notification Settings")
                        .foregroundColor(.onMainColor)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .background(Color.onBackgroundTertiary)
            .cornerRadius(8)
            
            Text("To enable notifications, please turn on Allow Notifications.")
                .font(.regularFont(size: 14))
                .foregroundColor(.secondary)
        }
    }
    
    fileprivate var deleteAllButton: some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.showAlert = true
                }) {
                    Text("Delete All")
                        .foregroundColor(.red)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 16)
            .background(Color.onBackgroundTertiary)
            .cornerRadius(8)
            
            Text("Delete all Boomerangs")
                .font(.regularFont(size: 14))
                .foregroundColor(.secondary)
        }
    }
}

//MARK: - PREVIEW
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SettingViewModel(viewContext: NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType))
        return SettingView(viewModel: viewModel)
    }
}


