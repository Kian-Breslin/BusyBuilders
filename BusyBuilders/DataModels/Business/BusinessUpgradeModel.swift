//
//  BusinessUpgradeModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 13/02/2025.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class BusinessUpgradeModel: ObservableObject, Identifiable, Equatable {
    
    var upgradeName: String
    var upgradeIcon: String
    var upgradePrice: Int
    var upgradeRequiredLevel: Int
    var isUnlocked: Bool
    var upgradeType: String
    var upgradeDescription: String
    
    init(upgradeName: String, upgradeIcon: String, upgradePrice: Int, upgradeRequiredLevel: Int, isUnlocked: Bool, upgradeType: String, upgradeDescription: String) {
        self.upgradeName = upgradeName
        self.upgradeIcon = upgradeIcon
        self.upgradePrice = upgradePrice
        self.upgradeRequiredLevel = upgradeRequiredLevel
        self.isUnlocked = isUnlocked
        self.upgradeType = upgradeType
        self.upgradeDescription = upgradeDescription
    }
}
