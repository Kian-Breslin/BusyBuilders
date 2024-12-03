//
//  UpgradeWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/11/2024.
//

import SwiftUI

struct UpgradeWidget: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var Upgrade : UpgradesDataModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: ((screenWidth-45)/2), height: 120)
            .foregroundStyle(themeManager.mainColor)
            .overlay {
                VStack (alignment: .leading){
                    Text(Upgrade.upgradeName)
                        .font(.system(size: 25))
                    Text("Cost: $\(Upgrade.cost)")
                    Text("CPM: +\((Upgrade.effect.cashPerMinIncrease ?? 0)*100, specifier: "%.f")%")
                    Text("Level: \(Upgrade.levelRequired)")
                }
                .foregroundStyle(themeManager.textColor)
            }
    }
}

#Preview {
    UpgradeWidget(Upgrade: UpgradesDataModel(upgradeName: "Cash Booster", upgradeDescription: "This is a cash booster that will multiply your earnings by 5%", cost: 10000, effect: EffectType(cashPerMinIncrease: 0.05), levelRequired: 1))
        .environmentObject(ThemeManager())
}


//upgradeName: "Cash Booster",
//upgradeDescription: "This is a cash booster that will multiply your earnings by 5%",
//cost: 10000,
//effect: EffectType(cashPerMinIncrease: 0.05),
//levelRequired: 1
