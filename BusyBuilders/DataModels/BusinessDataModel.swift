////
////  DataModels.swift
////  BusyBuilders
////
////  Created by Kian Breslin on 04/10/2024.
///

import Foundation
import SwiftData

@Model
class BusinessDataModel : ObservableObject, Identifiable {
    var id: UUID
    var businessName: String
    var businessTheme: String
    var businessType: String // New property for business type
    var businessIcon: String
    var Owners: [UserDataModel] // Assuming it's an array of owner IDs or names
    var time: Int // Keeps track of the Users time spent
    var cashPerMin: Int
    var netWorth: Int
    var costPerMin: Int
    var investment: Int
    var investors: [UserDataModel] // Array of user IDs or names for investors
    var badges: [String] // Badges array
    var sessionHistory: [SessionDataModel] // History of sessions
    var leaderboardPosition: Int // Position in leaderboard
    var insuranceLevel: Int // Level of insurance
    var securityLevel: Int // Level of security
    var businessLevel: Int // Current level of the business
    var businessPrestige: String
    var streak : Int

    // Initializer
    init(id: UUID = UUID(), businessName: String, businessTheme: String, businessType: String, businessIcon: String, owners: [UserDataModel] = [], time: Int = 0, cashPerMin: Int = 1000, netWorth: Int = 0, costPerMin: Int = 300, investment: Int = 0, investors: [UserDataModel] = [], badges: [String] = [], sessionHistory: [SessionDataModel] = [], leaderboardPosition: Int = 0, insuranceLevel: Int = 0, securityLevel: Int = 0, businessLevel: Int = 0, businessPrestige: String = "Start-Up", streak : Int = 0) {
        self.id = id
        self.businessName = businessName
        self.businessTheme = businessTheme
        self.businessType = businessType
        self.businessIcon = businessIcon
        self.Owners = owners
        self.time = time
        self.cashPerMin = cashPerMin
        self.costPerMin = costPerMin
        self.netWorth = netWorth
        self.investment = investment
        self.investors = investors
        self.badges = badges
        self.sessionHistory = sessionHistory
        self.leaderboardPosition = leaderboardPosition
        self.insuranceLevel = insuranceLevel
        self.securityLevel = securityLevel
        self.businessLevel = businessLevel
        self.businessPrestige = businessPrestige
        self.streak = streak
    }
}
