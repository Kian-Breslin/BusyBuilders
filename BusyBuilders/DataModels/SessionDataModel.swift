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
    // Income
    var totalBusinessProductIncome: Int {
        var base = 0
        for business in businessSummaries {
            base += business.productIncome
        }
        return base
    }
    var totalBusinessBaseIncome: Int {
        businessSummaries.reduce(0) { $0 + $1.baseIncome }
    }
    var totalBusinessRentalIncome: Int {
        businessSummaries.reduce(0) { $0 + $1.rentalIncome }
    }
    var totalBusinessServiceIncome: Int {
        businessSummaries.reduce(0) { $0 + $1.serviceIncome }
    }
    var totalBusinessIncome: Int {
        var total = 0
        for businessSummary in businessSummaries {
            total += businessSummary.totalIncome
        }
        return total
    }
    // Costs
    var totalBusinessTaxCost: Int {
        businessSummaries.reduce(0) { $0 + $1.taxCost }
    }
    var totalBusinessWageCost: Int {
        businessSummaries.reduce(0) { $0 + $1.wageCost }
    }
    var totalBusinessPremisesCost: Int {
        businessSummaries.reduce(0) { $0 + $1.premisesCost }
    }
    var totalBusinessProductStorageCost: Int {
        businessSummaries.reduce(0) { $0 + $1.productStorageCost }
    }
    var totalBusinessAdCampaignCost: Int {
        businessSummaries.reduce(0) { $0 + $1.adCampaignCost }
    }
    var totalBusinessResearchCost: Int {
        businessSummaries.reduce(0) { $0 + $1.researchCost }
    }
    var totalBusinessFinesCost: Int {
        businessSummaries.reduce(0) { $0 + $1.finesCost }
    }
    var totalBusinessSecurityCost: Int {
        businessSummaries.reduce(0) { $0 + $1.securityCost }
    }
    var totalBusinessInsuranceCost: Int {
        businessSummaries.reduce(0) { $0 + $1.insuranceCost }
    }
    var totalBusinessCosts: Int {
        var total = 0
        for businessSummary in businessSummaries {
            total += businessSummary.totalCost
        }
        return total
    }
    
    // Total
    var total: Int {
        return totalBusinessIncome - totalBusinessCosts
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
    static let sessionForPreview = SessionDataModel(
        date: Date.now,
        totalTime: 60,
        businessSummaries: [
            BusinessSessionSummary(businessId: UUID(), baseIncome: 6000, productIncome: 100, rentalIncome: 100, serviceIncome: 100, taxCost: 1000, wageCost: 100, premisesCost: 200, productStorageCost: 100, adCampaignCost: 100, researchCost: 100, finesCost: 0, securityCost: 0, insuranceCost: 0)
        ])
}
