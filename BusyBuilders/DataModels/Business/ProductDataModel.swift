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

    var soldHistory: [Int]
    var soldUnits: Int {
        soldHistory.reduce(0, +)
    }
    var totalSalesIncome: Int = 0
    var totalRevnueIncome: Int = 0
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
        soldHistory: [Int] = [],
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
        self.soldHistory = soldHistory
        self.isActive = isActive
        self.traits = traits
        self.business = business
    }
}

extension ProductDataModel {
    func SellSimulation() {
        guard
            let innovation = self.traits["Innovation"],
            let retention = self.traits["Retention"],
            let quality = self.traits["Quality"],
            let design = self.traits["Design"],
            let businessRD = self.business.departmentLevels["R&D"],
            let businessMarketing = self.business.departmentLevels["Marketing"]
        else { return }

        // get the audience
        var startingAudience = 200
        startingAudience += 100 * businessRD
        
        // get the buy chance
        let startingChance = min(max(Double(businessMarketing) * 0.05 + Double(design) * 0.05, 0.1), 0.9)
        
        // get product returns
        var returnRate = max(0.1, 0.5 - Double(retention) * 0.05)
        if quality <= 5 {
            returnRate += 0.1
        }
        
        print("=== SellSimulation Debug ===")
        print("Innovation: \(innovation), Retention: \(retention), Quality: \(quality), Design: \(design)")
        print("Business R&D: \(businessRD), Marketing: \(businessMarketing)")
        print("Starting Audience: \(startingAudience)")
        print("Starting Buy Chance: \(startingChance)")
        print("Return Rate: \(returnRate)")
        print("Interested Buyers: \(Double(startingAudience) * startingChance)")
        let interestedBuyers = Double(startingAudience) * startingChance
        let finalBuyers = interestedBuyers * (1.0 - returnRate)
        print("Final Buyers (After Returns): \(finalBuyers)")
        let sellableUnits = min(Int(finalBuyers.rounded()), self.quantity)
        print("Sellable Units (Capped by Stock): \(sellableUnits)")
        print("Price Per Unit: \(self.pricePerUnit)")
        print("Expected Revenue: \(self.pricePerUnit * sellableUnits)")

        // Calculate buyers
        

        // Update state
        self.quantity -= sellableUnits
        self.soldHistory.append(sellableUnits)

        let revenue = self.pricePerUnit * sellableUnits
        let productionCost = self.costToProduce * sellableUnits
        let tax = Int(Double(revenue) * 0.15)
        let netIncome = revenue - productionCost - tax

        // Scale down income to reflect 15-40% bonus on session income
        let incomeScale = Double.random(in: 0.15...0.40)
        let scaledRevenue = Int(Double(revenue) * incomeScale)
        let scaledNetIncome = Int(Double(netIncome) * incomeScale)

        self.totalSalesIncome += scaledRevenue
        self.totalRevnueIncome += scaledNetIncome
        
    }
    
    func buyStock(){
        self.quantity += 10000
    }
}
