//
//  SessionDataModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 16/07/2025.
//

import SwiftUI
import Foundation

struct SessionDataModel: Codable, Hashable {
    let date: Date
    var totalTime: Int
    var businessSummaries: [BusinessSessionSummary]
    var totalBusinessIncome: Int {
        var total = 0
        for businessSummary in businessSummaries {
            total += businessSummary.total
        }
        return total
    }
    var totalBusinessCosts: Int {
        var total = 0
        for businessSummary in businessSummaries {
            total += businessSummary.totalCost
        }
        return total
    }
}


// MARK: - Business Session Summary
struct BusinessSessionSummary: Codable, Hashable {
    let businessId: UUID
    
    // Income sources
    let baseIncome: Int        // From time studied (cash per minute)
    let productIncome: Int     // From selling products
    let rentalIncome: Int      // From leasing previous buildings
    let serviceIncome: Int     // From offering services
    
    var totalIncome: Int {
        return baseIncome + productIncome + rentalIncome + serviceIncome
    }
    
    // Cost sources
    let taxCost: Int
    let wageCost: Int
    let premisesCost: Int
    let productStorageCost: Int
    let adCampaignCost: Int
    let researchCost: Int
    let finesCost: Int
    let securityCost: Int
    let insuranceCost: Int

    var totalCost: Int {
        taxCost + wageCost + premisesCost + productStorageCost +
        adCampaignCost + researchCost + finesCost + securityCost + insuranceCost
    }
    
    var total: Int {
        return totalIncome - totalCost
    }
}

extension SessionDataModel {
    static let sessionForPreview = SessionDataModel(date: Date.now, totalTime: 60, businessSummaries: [])
}
