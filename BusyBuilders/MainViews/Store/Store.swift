//
//  Store.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 30/07/2025.
//

import SwiftUI
import SwiftData

struct Store: View {
    @EnvironmentObject var userManager: UserManager
    @State var selectedIcon = "hammer"
    
    var body: some View {
        VStack {
            TopNavigation(
                title: "Store",
                iconNames: ["gamecontroller", "hammer", "hammer", "hammer"],
                iconLabels: ["Tokens", "Placeholder", "Placeholder", "Placeholder"],
                selectedIcon: $selectedIcon
            )
            Spacer()
        }
        .background(userManager.mainColor)
        
        VStack {
            if selectedIcon == "gamecontroller" {
                Tokens()
            } else if selectedIcon == "hammer" {
                Placeholder()
            } else if selectedIcon == "hammer" {
                Placeholder()
            } else if selectedIcon == "hammer" {
                Placeholder()
            }
        }
        .background(userManager.mainColor)
    }
}

#Preview {
    Store()
        .environmentObject(UserManager())
}
