//
//  BusinessDataModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 16/07/2025.
//

import SwiftUI
import SwiftData

@Model
class BusinessDataModel : ObservableObject, Identifiable {
    var id: UUID
    // Details
    var businessName: String
    var businessTheme: String
    var businessType: String
    var businessIcon: String
    var creationDate: Date
    var netWorth: Int {
        var value = 0
        value += level * 1000
        value += employees * 100
        for (_, dept) in departments {
            if dept.isUnlocked {
                value += 10_000 + (dept.level * 10_000)
            }
        }
        return value
    }
    // Owners and Investors
    var owners: [UUID: Int] = [:]
    var investors: [UUID: Int] = [:]
    // Time Studied and Level
    var totalTime : Int = 0
    var level: Int {
        return totalTime / 60
    }
    var prestigeCount : Int = 0
    // Earning
    var cashPerMinute: Int {
        let baseRate = 100 + (level * 10)
        // Employees
        
        return baseRate + employeeCashperMinute
    }
    
    // Costs
    var costPerMinute: Int {
        let baseCost = 20 + (level * 10)
        return baseCost + employeeCostperMinute + taxAmount
    }
    
    // Add-ons
    // Departments
    var departments: [String: DepartmentInfo] = [
        "Hiring Department": DepartmentInfo(isUnlocked: false, level: 0),
        "Operations Department": DepartmentInfo(isUnlocked: false, level: 0),
        "Research and Development Department": DepartmentInfo(isUnlocked: false, level: 0),
        "Marketing Department": DepartmentInfo(isUnlocked: false, level: 0),
        "Finance Department": DepartmentInfo(isUnlocked: false, level: 0)
    ]
    // Hiring Department : Can hire Employees
    var hiringCost: Int {
        let baseHiringCost = 100
        let hiringLevel = departments["Hiring Department"]?.level ?? 0
        let discount = min(hiringLevel * 10, 50) // Max 50% discount
        return baseHiringCost * (100 - discount) / 100
    }
    var employeeCashperMinute : Int {
        let levelFactor = max(0, (level - 1) / 5)
        let employeeCash = employees * (2 + (levelFactor * 5))
        return employeeCash
    }
    var employeeCostperMinute : Int {
        let levelFactor = max(0, (level - 1) / 5)
        let employeeCost = employees * (2 + (levelFactor * 4))
        return employeeCost
    }
    var employees : Int = 0
    
    // Operations Department : Can upgrade Premises
    var building : String = ""
    // R&D Department : Can do Product Research
    var activeResearchProjects: [String] = []
    // Marketing Department : Can run Ad Campaigns
    var currentCampaigns: [String] = []
    // Finance Department : Can be Investmented in
    var taxAmount: Int {
        let baseTaxRate = 0.30
        let financeLevel = departments["Finance Department"]?.level ?? 0
        let taxReduction = Double(min(financeLevel, 30)) * 0.01
        let finalTaxRate = max(0, baseTaxRate - taxReduction)
        return Int(Double(cashPerMinute) * finalTaxRate)
    }
    var investmentPortfolio: [String: Double] = [:]
    
    init(id: UUID = UUID(), businessName: String, businessTheme: String, businessType: String, businessIcon: String, creationDate: Date = Date.now, totalTime: Int, building: String) {
        self.id = id
        self.businessName = businessName
        self.businessTheme = businessTheme
        self.businessType = businessType
        self.businessIcon = businessIcon
        self.creationDate = creationDate
        self.totalTime = totalTime
        self.building = building
    }
}

struct DepartmentInfo: Codable, Hashable {
    var isUnlocked: Bool
    var level: Int
}

extension BusinessDataModel {
    static let previewBusiness = BusinessDataModel(
        businessName: "Kian's Coffee",
        businessTheme: "red",
        businessType: "Eco",
        businessIcon: "cup.and.saucer",
        totalTime: 0,
        building: "Corner Shop"
    )
}

