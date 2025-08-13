//
//  UserDataModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 16/07/2025.
//

import SwiftUI
import SwiftData

@Model
public class UserDataModel: Identifiable, ObservableObject {
    public var id: UUID
    var username: String
    var name: String
    var email: String
    var password: String
    
    // User Cash
    var netWorth: Int {
        var total = availableBalance

        for business in businesses {
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
    var businesses: [BusinessDataModel] = []

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
    
    init(id: UUID, username: String, name: String, email: String, password: String, netWorth: Int, availableBalance: Int, friends: [UUID], referralCode: String? = nil, invitedByUserId: UUID? = nil, business: [BusinessDataModel], Agencies: [String : Bool] = [:], tokens: Int, sessionHistory: [SessionDataModel], userLevel: Int, badges: [String], inventory: [ItemModel]) {
        self.id = id
        self.username = username
        self.name = name
        self.email = email
        self.password = password
        self.availableBalance = availableBalance
        self.friends = friends
        self.referralCode = referralCode
        self.invitedByUserId = invitedByUserId
        self.businesses = business
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
    func OpenBusiness(name: String, theme: String, type: String, icon: String) {
        
        let newBusiness = BusinessDataModel(businessName: name, businessTheme: theme, businessType: type, businessIcon: icon, totalTime: 0)
        self.businesses.append(newBusiness)
    }
    
    func MakeSession(time: Int) -> SessionDataModel {
        let time = time/60
        var businessSummaries: [BusinessSessionSummary] = []
        for business in self.businesses {
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
        return businesses.map { business in
            return [
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
}
