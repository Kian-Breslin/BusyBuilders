//
//  UpgradesStoreView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/11/2024.
//

import SwiftUI
import SwiftData

struct UpgradesStoreView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel]
    
    let upgrades = availableUpgrades
    
    var body: some View {
        VStack (spacing: 15){
            HStack (spacing: 15){
                UpgradeWidget(Upgrade: upgrades[0])
                UpgradeWidget(Upgrade: upgrades[1])
            }
            HStack (spacing: 15){
                UpgradeWidget(Upgrade: upgrades[2])
                UpgradeWidget(Upgrade: upgrades[3])
            }
        }
        .foregroundStyle(themeManager.textColor)
    }
}

#Preview {
    UpgradesStoreView()
        .environmentObject(ThemeManager())

}
