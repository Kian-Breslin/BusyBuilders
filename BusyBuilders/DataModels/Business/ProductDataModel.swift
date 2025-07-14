//
//  ProductDataModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 08/06/2025.
//

import SwiftData
import SwiftUI

@Model
class ProductDataModel: Identifiable {
    var id: UUID
    var productName: String
    var productCreationDate: Date

    var pricePerUnit: Int {
        Int(Double(costToProduce) * (1.0 + Double(markupPercentage) / 100.0))
    }
    var quantity: Int
    var costToProduce: Int {
        let baseCost = 100
        let innovation = traits["Innovation"] ?? 0
        let quality = traits["Quality"] ?? 0
        
        let innovationDiscount = Double(innovation) * 0.05 // 5% cost reduction per point
        let qualityPremium = Double(quality) * 0.10        // 10% cost increase per point
        
        let modifiedCost = Double(baseCost) * (1.0 - innovationDiscount + qualityPremium)
        return max(Int(modifiedCost), 1) // Prevent negative or zero cost
    }
    var markupPercentage: Int
    var priceHistory: [Int]

    var productType: String // e.g., "Phone", "Clothing", "Gadget"
    var icon: String // SF Symbol
    var isActive: Bool
    
    // Product Stats
    var traits: [String: Int] = [
        "Innovation": 0,
        "Retention": 0,
        "Quality": 0,
        "Design": 0,
    ]
    
    var productRating: Int {
        guard !traits.isEmpty else { return 0 }
        let total = traits.values.reduce(0, +)
        return total
    }

    // Relationship to the owning business
    @Relationship var business: BusinessDataModel

    init(
        id: UUID = UUID(),
        productName: String,
        productCreationDate: Date = .now,
        quantity: Int,
        markupPercentage: Int,
        priceHistory: [Int] = [],
        productType: String,
        icon: String,
        isActive: Bool = true,
        traits: [String: Int] = [
            "Innovation": 0,
            "Retention": 0,
            "Quality": 0,
            "Design": 0
        ],
        business: BusinessDataModel
    ) {
        self.id = id
        self.productName = productName
        self.productCreationDate = productCreationDate
        self.quantity = quantity
        self.markupPercentage = markupPercentage
        self.priceHistory = priceHistory
        self.productType = productType
        self.icon = icon
        self.isActive = isActive
        self.traits = traits
        self.business = business
    }
}

struct ProductSellingSession: Identifiable, Codable, Hashable {
    var id: UUID
    var sessionDate: Date
    var productId: UUID

    var startingQuantity: Int
    var soldQuantity: Int
    var endingQuantity: Int

    var pricePerUnit: Int
    var costPerUnit: Int

    var totalRevenue: Int
    var totalCost: Int
    var taxPaid: Int
    var netIncome: Int

    var traitsSnapshot: [String: Int]
}

extension ProductDataModel {
    
    func sellSimulation() -> ProductSellingSession? {
        guard
            let innovation = self.traits["Innovation"],
            let retention = self.traits["Retention"],
            let quality = self.traits["Quality"],
            let design = self.traits["Design"],
            let businessRD = self.business.departmentLevels["R&D"],
            let businessMarketing = self.business.departmentLevels["Marketing"]
        else { return nil }

        let startingQuantity = self.quantity

        // Audience calculation
        var startingAudience = 200
        startingAudience += 100 * businessRD

        // Buy chance calculation
        let startingChance = min(max(Double(businessMarketing) * 0.05 + Double(design) * 0.05, 0.1), 0.9)

        // Return rate calculation
        var returnRate = max(0.1, 0.5 - Double(retention) * 0.05)
        if quality <= 5 {
            returnRate += 0.1
        }

        let interestedBuyers = Double(startingAudience) * startingChance
        let finalBuyers = interestedBuyers * (1.0 - returnRate)
        let sellableUnits = min(Int(finalBuyers.rounded()), startingQuantity)

        // Update quantity after sale
        self.quantity -= sellableUnits
        let endingQuantity = self.quantity

        // Financials
        let revenue = self.pricePerUnit * sellableUnits
        let productionCost = self.costToProduce * sellableUnits
        let taxPaid = Int(Double(revenue) * 0.15)
        let netIncome = revenue - productionCost - taxPaid

        // Traits snapshot copy
        let traitsSnapshotCopy = self.traits

        // Build and return ProductSellingSession
        let session = ProductSellingSession(
            id: UUID(),
            sessionDate: Date(),
            productId: self.id,
            startingQuantity: startingQuantity,
            soldQuantity: sellableUnits,
            endingQuantity: endingQuantity,
            pricePerUnit: self.pricePerUnit,
            costPerUnit: self.costToProduce,
            totalRevenue: revenue,
            totalCost: productionCost,
            taxPaid: taxPaid,
            netIncome: netIncome,
            traitsSnapshot: traitsSnapshotCopy
        )

        return session
    }
    
    func buyStock(){
        self.quantity += 10000
    }
}
