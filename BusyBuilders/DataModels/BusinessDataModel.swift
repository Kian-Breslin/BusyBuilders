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
    var netWorth: Int = 0
    // Owners and Investors
    var owners: [UUID: Int] = [:]
    var investors: [UUID: Int] = [:]
    // Time Studied and Level
    var totalTime : Int = 0
    var level : Int = 0
    var prestigeCount : Int = 0
    // Earning
    var cashPerMinute : Int = 100
    
    // Costs
    var costPerMinute : Int = 20
    
    // Add-ons
    // Departments
    var departments : [String : Bool] = [
        "Hiring Department" : false,
        "Operations Department" : false,
        "Reasearch and Development Department" : false,
        "Marketing Department" : false,
        "Finance Department" : false
    ]
    // Hiring Department : Can hire Employees
    var employees : Int = 0
    // Operations Department : Can upgrade Premises
    var building : String = ""
    // R&D Department : Can do Product Research
    var activeResearchProjects: [String] = []
    // Marketing Department : Can run Ad Campaigns
    var currentCampaigns: [String] = []
    // Finance Department : Can be Investmented in
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
