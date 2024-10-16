//
//  UpgradesDataModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 15/10/2024.
//

import SwiftUI
import Foundation
import SwiftData

@Model
public class UpgradesDataModel : Hashable {
    var upgradeName: String             // Name of the upgrade
    var upgradeDescription: String      // Description of the upgrade
    var cost: Int                // Cost of the upgrade
    var effect: EffectType       // Effects provided by the upgrade
    var levelRequired: Int       // Required level to unlock this upgrade

    // Initialize UpgradesDataModel
    init(upgradeName: String, upgradeDescription: String, cost: Int, effect: EffectType, levelRequired: Int) {
        self.upgradeName = upgradeName
        self.upgradeDescription = upgradeDescription
        self.cost = cost
        self.effect = effect
        self.levelRequired = levelRequired
    }
}

@Model
public class EffectType {
    var cashPerMinIncrease: Double? // Amount to increase cash per minute
    var xpBoost: Double?            // Amount to increase XP earned
    var costReduction: Double?      // Percentage reduction in costs
    
    // Initialize EffectType
    init(cashPerMinIncrease: Double? = nil, xpBoost: Double? = nil, costReduction: Double? = nil) {
        self.cashPerMinIncrease = cashPerMinIncrease
        self.xpBoost = xpBoost
        self.costReduction = costReduction
    }
}


