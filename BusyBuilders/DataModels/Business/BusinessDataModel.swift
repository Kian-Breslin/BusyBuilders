////
////  DataModels.swift
////  BusyBuilders
////
////  Created by Kian Breslin on 04/10/2024.
///

import Foundation
import SwiftData
import SwiftUI

@Model
class BusinessDataModel : ObservableObject, Identifiable {
    var id: UUID
    var businessName: String
    var businessTheme: String
    var businessType: String // New property for business type
    var businessIcon: String
    var Owners: [UserDataModel] // Assuming it's an array of owner IDs or names
    var time: Int // Keeps track of the Users time spent
    var cashPerMin: Int {
        let baseRate = 100

        // Linear growth with business level (level 1 = $100)
        let businessLevel = self.businessLevel
        let baseCash = baseRate + businessLevel

        // Finance department multiplier (capped at 10 levels)
        let financeLevelRaw = self.departmentLevels["Finance"] ?? 0
        let financeMultiplier = 1.0 + (Double(financeLevelRaw) * 0.10) // 10% per level

        let finalCashPerMin = Double(baseCash) * financeMultiplier
        return Int(finalCashPerMin)
    }
    var netWorth: Int
    var costPerMin: Int {
        let corpTax = 0.15
        let baseWages = 0.3
        let baseOverhead = 0.2
        let baseRate = 40

        let operationsLevel = departmentLevels["Operations"] ?? 0
        let overheadReduction = min(Double(operationsLevel) * 0.02, 0.2) // Max 20% reduction
        let adjustedOverhead = max(baseOverhead - overheadReduction, 0)

        let hrLevel = departmentLevels["HR"] ?? 0
        let wagesReduction = min(Double(hrLevel) * 0.02, 0.2) // Max 20% reduction
        let adjustedWages = max(baseWages - wagesReduction, 0)

        let totalCostMultiplier = corpTax + adjustedWages + adjustedOverhead
        let cost = Double(baseRate) * totalCostMultiplier

        return Int(cost)
    }
    var investment: Int
    var investors: [UserDataModel] // Array of user IDs or names for investors
    var badges: [String] // Badges array
    var upgrades : [BusinessUpgradeModel]
    var sessionHistory: [SessionDataModel] // History of sessions
    var leaderboardPosition: Int // Position in leaderboard
    var insuranceLevel: Int // Level of insurance
    var securityLevel: Int // Level of security
    var departmentLevels: [String: Int]
    var businessLevel: Int {
        var Level = 0
        for session in self.sessionHistory {
            Level += session.totalStudyTime
        }
        return Level
    }// Current level of the business
    var businessPrestige: String
    var streak : Int
    var creationDate : Date
    var products : [ProductDataModel] = []

    // Initializer
    init(id: UUID = UUID(), businessName: String, businessTheme: String, businessType: String, businessIcon: String, owners: [UserDataModel] = [], time: Int = 0, netWorth: Int = 0, investment: Int = 0, investors: [UserDataModel] = [], badges: [String] = [], upgrades: [BusinessUpgradeModel] = [], sessionHistory: [SessionDataModel] = [], leaderboardPosition: Int = 0, insuranceLevel: Int = 0, securityLevel: Int = 0, departmentLevel: [String: Int] = [:], businessPrestige: String = "Start-Up", streak : Int = 0, creationDate: Date = Date()) {
        self.id = id
        self.businessName = businessName
        self.businessTheme = businessTheme
        self.businessType = businessType
        self.businessIcon = businessIcon
        self.Owners = owners
        self.time = time
        self.netWorth = netWorth
        self.investment = investment
        self.investors = investors
        self.badges = badges
        self.upgrades = upgrades
        self.sessionHistory = sessionHistory
        self.leaderboardPosition = leaderboardPosition
        self.insuranceLevel = insuranceLevel
        self.securityLevel = securityLevel
        self.departmentLevels = [
            "Finance": 0,
            "Operations": 0,
            "Marketing": 0,
            "HR": 0,
            "R&D": 0
        ]
        self.businessPrestige = businessPrestige
        self.streak = streak
        self.creationDate = creationDate
    }
}

extension BusinessDataModel {
    func upgradeDept(dept: String) {
        let currentLevel = departmentLevels[dept] ?? 0
        departmentLevels[dept] = currentLevel + 1
    }
}

extension BusinessDataModel {
    func makeRandomProduct() -> ProductDataModel {
        let productNames = ["Gadget", "Widget", "Device", "Module", "Tool"]
        let icons = ["iphone", "laptopcomputer", "headphones", "gamecontroller", "bolt"]
        let types = ["Electronics", "Software", "Wearable", "Utility", "Hardware"]

        let name = productNames.randomElement() ?? "Product"
        let icon = icons.randomElement() ?? "cube.box"
        let type = types.randomElement() ?? "General"

        let traits = [
            "Innovation": Int.random(in: 0...10),
            "Retention": Int.random(in: 0...10),
            "Quality": Int.random(in: 0...10),
            "Design": Int.random(in: 0...10)
        ]

        let quantity = Int.random(in: 1000...3000)
        let markup = Int.random(in: 10...50)

        let newProduct = ProductDataModel(
            productName: name,
            quantity: quantity,
            markupPercentage: markup,
            priceHistory: [],
            productType: type,
            icon: icon,
            soldHistory: [],
            business: self
        )

        newProduct.traits = traits
        return newProduct
    }
}
