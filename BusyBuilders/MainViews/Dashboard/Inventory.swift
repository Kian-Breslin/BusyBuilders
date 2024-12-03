//
//  Inventory.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 20/11/2024.
//

import SwiftUI

struct Inventory: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        Text("Hello Inventory")
    }
}

#Preview {
    Inventory()
        .environmentObject(ThemeManager())
}


// John.carr@kashmirifoods.com
