//
//  SessionDataModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/10/2024.
//

import Foundation
import SwiftData

@Model
class SessionDataModel: Identifiable {
    var id: UUID // Unique identifier for each session
    var sessionDate: Date
    var sessionStart: String // Start time of the study session
    var sessionEnd: String // End time of the study session
    var businessId: UUID // The ID of the business related to this session
    
    // Session Stats
    var totalCashEarned : Int
    var totalCostIncurred : Int
    var totalXPEarned : Int
    var totalStudyTime: Int
    
    var productRevenue: Int
    
    // Upgrades Used
    var XPBUsed : Bool
    var CBUsed : Bool
    var CRUsed : Bool
    

    init(id: UUID, sessionDate: Date, sessionStart: String, sessionEnd: String, businessId: UUID, totalCashEarned: Int = 0, totalCostIncurred: Int = 0, totalXPEarned: Int = 0, totalStudyTime: Int = 0, XPBUsed: Bool = false, CBUsed: Bool = false, CRUsed: Bool = false, productRevenue: Int = 0) {
        self.id = UUID()
        self.sessionDate = sessionDate
        self.sessionStart = sessionStart
        self.sessionEnd = sessionEnd
        self.businessId = businessId
        self.totalCashEarned = totalCashEarned
        self.totalCostIncurred = totalCostIncurred
        self.totalXPEarned = totalXPEarned
        self.totalStudyTime = totalStudyTime
        self.XPBUsed = XPBUsed
        self.CBUsed = CBUsed
        self.CRUsed = CRUsed
        self.productRevenue = productRevenue
    }
}
