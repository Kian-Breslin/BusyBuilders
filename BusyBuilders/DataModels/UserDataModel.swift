//
//  UserDataModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 16/07/2025.
//

import SwiftUI
import SwiftData

@Model
public class UserDataModel: Identifiable {
    public var id: UUID = UUID()
    var username: String = "N/A"
    var name: String = "N/A"
    var email: String = "N/A"
    var password: String = "N/A"
    
    // User Cash
    var netWorth: Int {
        var total = availableBalance

        for business in businesses ?? [] {
            total += business.netWorth
        }

        for item in inventory {
            total += item.price
        }

        for agency in Agencies.values {
            if agency.isUnlocked {
                total += 100000 + (agency.level * 10000)
            }
        }

        return total
    }
    var availableBalance: Int = 0
    
    // Social
    var friends: [UUID] = []
    var referralCode: String?
    var invitedByUserId: UUID?
    
    // Business Data Model
    @Relationship var businesses: [BusinessDataModel]? = []
    
    @Relationship var plannedSessions: [PlannedSession]? = []

    // Agencies
    var Agencies: [String: AgencyInfo] = [
        "Hiring Department": AgencyInfo(isUnlocked: false, level: 0),
        "Operations Department": AgencyInfo(isUnlocked: false, level: 0),
        "Research and Development Department": AgencyInfo(isUnlocked: false, level: 0),
        "Marketing Department": AgencyInfo(isUnlocked: false, level: 0),
        "Finance Department": AgencyInfo(isUnlocked: false, level: 0)
    ]
    // Mini-Games
    var tokens: Int = 0
    
    //Stocks
    var stocksOwned: [String: Int] = [:]  // [stockName: amountOwned]
    
    // Sessions
    var sessionHistory: [SessionDataModel] = []
        
    // Basic user level
    var userLevel: Int = 0
    
    // Achievements or badges
    var badges: [String] = []
    
    // Inventory of items or upgrades
    var inventory: [ItemModel] = []
    
    init(id: UUID, username: String, name: String, email: String, password: String, netWorth: Int, availableBalance: Int, friends: [UUID], referralCode: String? = nil, invitedByUserId: UUID? = nil, businesses: [BusinessDataModel], agencies: [String : AgencyInfo] = [:], tokens: Int, sessionHistory: [SessionDataModel], userLevel: Int, badges: [String], inventory: [ItemModel]) {
        self.id = id
        self.username = username
        self.name = name
        self.email = email
        self.password = password
        self.availableBalance = availableBalance
        self.friends = friends
        self.referralCode = referralCode
        self.invitedByUserId = invitedByUserId
        self.businesses = businesses
        if !agencies.isEmpty { self.Agencies = agencies }
        self.tokens = tokens
        self.sessionHistory = sessionHistory
        self.userLevel = userLevel
        self.badges = badges
        self.inventory = inventory
    }
}

struct AgencyInfo: Codable, Hashable {
    var isUnlocked: Bool
    var level: Int
}



extension UserDataModel {
    func OpenBusiness(name: String, theme: String, type: String, icon: String, user: UserDataModel) {
        let newBusiness = BusinessDataModel(user: user, businessName: name, businessTheme: theme, businessType: type, businessIcon: icon, totalTime: 0)
        if businesses == nil { businesses = [] }
        businesses?.append(newBusiness)
    }
    
    func MakeSession(time: Int) -> SessionDataModel {
        let time = time/60
        var businessSummaries: [BusinessSessionSummary] = []
        for business in businesses ?? [] {
            // Product Logic
            
            let businessSessison = BusinessSessionSummary(
                // Income
                businessId: business.id,
                baseIncome: business.cashPerMinute * time,
                products: business.products,
                rentedBuildings: business.rentedBuildings,
                serviceIncome: 0,
                // Costs
                taxCost: business.taxAmount,
                wageCost: business.employeeCostperMinute * time,
                productStorageCost: 0,
                adCampaignCost: 0,
                researchCost: 0,
                finesCost: 0,
                securityCost: 0,
                insuranceCost: 0,
                ownedBuildings: business.buildings,
                rentingBuildings: business.rentingBuildings
            )
            
            businessSummaries.append(businessSessison)
        }
        
        let newSession = SessionDataModel(date: Date.now, totalTime: time, businessSummaries: businessSummaries)
        self.sessionHistory.append(newSession)
        
        self.availableBalance += newSession.total
        
        return newSession
    }
    
    func getBusinessSummaries() -> [[String]] {
        (businesses ?? []).map { business in
            [
                business.businessName,
                business.businessIcon,
                business.businessTheme,
                String(business.netWorth)
            ]
        }
    }
    
    func getDateIncome(date: String) -> Int {
        var calendar = Calendar.current
        calendar.firstWeekday = 2 // Ensure week starts on Monday
        let now = Date()

        let filteredSessions: [SessionDataModel] = sessionHistory.filter { session in
            switch date.lowercased() {
            case "todays":
                return calendar.isDateInToday(session.date)
            case "weekly":
                if let weekInterval = calendar.dateInterval(of: .weekOfYear, for: now) {
                    return weekInterval.contains(session.date)
                }
                return false
            case "monthly":
                if let monthInterval = calendar.dateInterval(of: .month, for: now) {
                    return monthInterval.contains(session.date)
                }
                return false
            default:
                return false
            }
        }

        return filteredSessions.reduce(0) { $0 + $1.total }
    }
    
    func get5PreviousSessions() -> [SessionDataModel] {
        let sortedSessions = sessionHistory.sorted(by: { $0.date > $1.date })
        return Array(sortedSessions.prefix(5))
    }
    
    func getRandomBusiness() -> BusinessDataModel? {
        let businessCount = self.businesses?.count ?? 0
        if businessCount > 0 {
            let randomIndex: Int = Int.random(in: 0..<businessCount)
            return self.businesses![randomIndex]
        }
        else {
            return nil
        }
    }
    
    func getUserNetworthBreakdown() -> [Int]{
        var finalArray: [Int] = []
        var balance = availableBalance
        var businessesAmount: Int = 0
        var items: Int = 0
        var agencies: Int = 0
        
        for business in businesses ?? [] {
            businessesAmount += business.netWorth
        }

        for item in inventory {
            items += item.price
        }

        for agency in Agencies.values {
            if agency.isUnlocked {
                agencies += 100000 + (agency.level * 10000)
            }
        }
        
        finalArray.append(balance)
        finalArray.append(businessesAmount)
        finalArray.append(items)
        finalArray.append(agencies)
        
        
        return finalArray
    }
    
    func getUserBusinessNetWorth() -> Int {
        var total = 0
        for business in businesses ?? [] {
            total += business.netWorth
        }
        return total
    }
    
    func getUserBusinessNetWorthBreakdown() -> [Double] {
        // Safely unwrap businesses and map net worths
        let netWorths: [Int] = (businesses ?? []).map { $0.netWorth }
        // If no businesses, return empty array
        guard !netWorths.isEmpty else { return [] }
        // Compute total net worth across all businesses
        let total = netWorths.reduce(0, +)
        // If total is zero, return an array of zeros with same count
        guard total > 0 else { return Array(repeating: 0.0, count: netWorths.count) }
        // Compute percentage breakdowns as Double fractions
        let breakdown = netWorths.map { Double($0) / Double(total) }
        return breakdown
    }
}

@Model
class PlannedSession: Identifiable {
    @Relationship var user: UserDataModel? = nil
    var id: UUID = UUID()
    var startTime: Date? = Date.now
    var endTime: Date? = Date.now
    var type: String? = ""
    var completed: Bool? = false
    var completedAt: Date? = Date.now
//    PlannedSession
//    - id
//    - startTime
//    - endTime
//    - type
//    - sourceApp
//    - completed
//    - completedAt
    init(id: UUID, startTime: Date? = nil, endTime: Date? = nil, type: String? = nil, completed: Bool? = nil, completedAt: Date? = nil) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.type = type
        self.completed = completed
        self.completedAt = completedAt
    }
}

