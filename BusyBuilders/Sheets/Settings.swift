//
//  Settings.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/10/2024.
//

import SwiftUI
import SwiftData

struct Settings: View {
    
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel] // Query for businesses
    @Binding var userColorPreference: String
    
    var body: some View {
        VStack {
            Text("Choose a color preference:")
            Button("Set to Red") {
                userColorPreference = "red"
            }
            Button("Set to Blue") {
                userColorPreference = "blue"
            }
            Button("Set to Green") {
                userColorPreference = "green"
            }
            
            // Button for Testing (Add Items to Inventory)
            Button("Buy Cash Booster") {
                if let user = users.first {
                    user.inventory["Cash Booster", default: 0] += 1
                }
                do {
                    try context.save()
                }
                catch {
                    print("Failed to save user: \(error.localizedDescription)")
                }
            }
                
        }
            
            VStack {
                List {
                    Section(header: Text("Your Inventory")) {
                        if let user = users.first {
                            ForEach(user.inventory.sorted(by: { $0.key < $1.key }), id: \.key) { upgrade, count in
                                HStack {
                                    Text(upgrade) // Display the upgrade name
                                    Spacer()
                                    Text("\(count)") // Display the count of the upgrade
                                        .foregroundColor(.gray)
                                }
                                
                            }
                        } else {
                            Text("No Upgrades")
                        }
                    }
                }
            }
            
        }
    }


#Preview {
    Settings(userColorPreference: .constant("red"))
}
