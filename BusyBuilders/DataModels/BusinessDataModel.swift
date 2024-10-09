////
////  DataModels.swift
////  BusyBuilders
////
////  Created by Kian Breslin on 04/10/2024.
///

import Foundation
import SwiftData

@Model
class BusinessDataModel {
    var id: UUID
    var businessName: String
    var businessTheme: String
    var businessType: String // New property for business type
    var businessIcon: String
    var owners: [String] // Assuming it's an array of owner IDs or names
    var cashPerMin: Int
    var netWorth: Double
    var investment: Int
    var investors: [String] // Array of user IDs or names for investors
    var badges: [String] // Badges array
    var sessionHistory: [SessionDataModel] // History of sessions
    var leaderboardPosition: Int // Position in leaderboard
    var insuranceLevel: Int // Level of insurance
    var securityLevel: Int // Level of security
    var businessLevel: Int // Current level of the business

    // Initializer
    init(businessName: String, businessTheme: String, businessType: String, businessIcon: String, owners: [String] = [], cashPerMin: Int = 1000, netWorth: Double = 0, investment: Int = 0, investors: [String] = [], badges: [String] = [], sessionHistory: [SessionDataModel] = [], leaderboardPosition: Int = 0, insuranceLevel: Int = 0, securityLevel: Int = 0, businessLevel: Int = 0) {
        self.id = UUID() // Automatically generate a new UUID
        self.businessName = businessName
        self.businessTheme = businessTheme
        self.businessType = businessType
        self.businessIcon = businessIcon
        self.owners = owners
        self.cashPerMin = cashPerMin
        self.netWorth = netWorth
        self.investment = investment
        self.investors = investors
        self.badges = badges
        self.sessionHistory = sessionHistory
        self.leaderboardPosition = leaderboardPosition
        self.insuranceLevel = insuranceLevel
        self.securityLevel = securityLevel
        self.businessLevel = businessLevel
    }
}
