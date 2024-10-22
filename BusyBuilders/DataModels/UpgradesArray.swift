//
//  UpgradesArray.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 15/10/2024.
//
import Foundation

// Predefined upgrades
let cashBoosterUpgrade = UpgradesDataModel(
    upgradeName: "Cash Booster",
    upgradeDescription: "This is a cash booster that will multiply your earnings by 5%",
    cost: 10000,
    effect: EffectType(cashPerMinIncrease: 0.05),
    levelRequired: 1
)

let xpBooster = UpgradesDataModel(
    upgradeName: "Experience Booster",
    upgradeDescription: "This is an XP Booster that will multiply your XP from your session",
    cost: 5000,
    effect: EffectType(xpBoost: 0.1),
    levelRequired: 1
)

let costReduction = UpgradesDataModel(
    upgradeName: "Cost Reduction",
    upgradeDescription: "Reduce your business costs for this session",
    cost: 1000,
    effect: EffectType(costReduction: 0.5),
    levelRequired: 1
)

let breakBooster = UpgradesDataModel(
    upgradeName: "Break Booster",
    upgradeDescription: "Earn while youre on your break",
    cost: 3000,
    effect: EffectType(cashPerMinIncrease: 1.0),
    levelRequired: 1)

// Array of all available upgrades
public let availableUpgrades: [UpgradesDataModel] = [cashBoosterUpgrade, xpBooster, costReduction, breakBooster]
