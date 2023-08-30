//
//  SettingView.swift
//  Boomerang
//
//  Created by JunHyuk Lim on 4/8/2023.
//

import SwiftUI
import UserNotifications
import UIKit
import CoreData // Import CoreData

struct SettingView: View {
    @Environment(\.managedObjectContext) private var viewContext 
    @State private var showAlert = false // Track whether to show the alert or not

    var body: some View {
        VStack{
            header
            
            VStack(spacing: 32) {
                notificationURL
                deleteAllButton
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Delete All Data"),
                    message: Text("Are you sure you want to delete all Boomerangs?"),
                    primaryButton: .default(Text("Cancel")),
                    secondaryButton: .destructive(Text("Delete"), action: {
                        // Call the function to delete all data
                        deleteAllData()
                    })
                )
            }
        }
        

    }
    
    fileprivate var header: some View {
        HStack(spacing: 0) {
            Text("Setting")
                .font(.boldFont(size: 24))
            
            Spacer()
            
            Text("Version 1.0")
                .font(.regularFont(size: 16))
        }
    }
    
    fileprivate var notificationURL : some View {
        VStack{
            HStack{
                
                Button(action: {
                    // Open the app's notification settings
                    if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(settingsUrl)
                    }
                }) {
                    Text("Open Notification Settings")
                        .foregroundColor(.blue)
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
                    showAlert = true // Show the alert when the button is clicked
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

      // Function to delete all data from CoreData
      private func deleteAllData() {
          let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item") // Replace "YourEntityName" with the actual name of your CoreData entity
          
          let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
          
          do {
              try viewContext.execute(deleteRequest)
              try viewContext.save() // Save the context to commit the changes
              print("All data deleted successfully.")
          } catch {
              print("Error deleting data: \(error)")
          }
      }
  }



struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

