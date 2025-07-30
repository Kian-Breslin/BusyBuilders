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
                iconNames: ["hammer", "hammer", "hammer", "hammer"],
                iconLabels: ["Placeholder", "Placeholder", "Placeholder", "Placeholder"],
                selectedIcon: $selectedIcon
            )
            Spacer()
        }
        .background(userManager.mainColor)
        
        VStack {
            if selectedIcon == "hammer" {
                Placeholder()
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
