//
//  InvestmentLogic.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 01/06/2025.
//

import SwiftUI
import SwiftData
import Foundation

@Model
class CompanyDataModel: Identifiable {
    var id: UUID
    var name: String
    var location: String
    var icon: String
    var stockPrice: Int
    var stocksAvailable: Int
    var stockHistory: [Int]
    var stockVolatility: String
    
    init(id: UUID, name: String, location: String, icon: String, stockPrice: Int, stocksAvailable: Int, stockHistory: [Int] = [], stockVolatility: String) {
        self.id = id
        self.name = name
        self.location = location
        self.icon = icon
        self.stockPrice = stockPrice
        self.stocksAvailable = stocksAvailable
        self.stockHistory = stockHistory
        self.stockVolatility = stockVolatility
    }
}

func createCompanies(context: ModelContext) {
    let existing = try? context.fetch(FetchDescriptor<CompanyDataModel>())
    if let existing = existing, !existing.isEmpty { return }
    
    let companies: [CompanyDataModel] = [
        CompanyDataModel(id: UUID(), name: "Techify", location: "New York", icon: "desktopcomputer", stockPrice: 120, stocksAvailable: 1000, stockHistory: [115, 118, 120], stockVolatility: "Medium"),
        CompanyDataModel(id: UUID(), name: "GreenCore", location: "Dublin", icon: "leaf.fill", stockPrice: 55, stocksAvailable: 800, stockHistory: [50, 52, 55], stockVolatility: "Low"),
        CompanyDataModel(id: UUID(), name: "HealthPlus", location: "Berlin", icon: "heart.fill", stockPrice: 3000, stocksAvailable: 200, stockHistory: [2800, 2950, 3000], stockVolatility: "High"),
        CompanyDataModel(id: UUID(), name: "AutoDrive", location: "Tokyo", icon: "car.fill", stockPrice: 75, stocksAvailable: 1200, stockHistory: [70, 74, 75], stockVolatility: "Low"),
        CompanyDataModel(id: UUID(), name: "EduSmart", location: "Toronto", icon: "book.fill", stockPrice: 200, stocksAvailable: 950, stockHistory: [190, 195, 200], stockVolatility: "Medium"),
        CompanyDataModel(id: UUID(), name: "Foodies", location: "Paris", icon: "fork.knife", stockPrice: 1100, stocksAvailable: 600, stockHistory: [1050, 1080, 1100], stockVolatility: "Medium"),
        CompanyDataModel(id: UUID(), name: "BuildIt", location: "Chicago", icon: "hammer.fill", stockPrice: 500, stocksAvailable: 750, stockHistory: [470, 490, 500], stockVolatility: "Low"),
        CompanyDataModel(id: UUID(), name: "CloudNet", location: "San Francisco", icon: "cloud.fill", stockPrice: 1500, stocksAvailable: 400, stockHistory: [1450, 1480, 1500], stockVolatility: "High"),
        CompanyDataModel(id: UUID(), name: "MediaWave", location: "London", icon: "tv.fill", stockPrice: 85, stocksAvailable: 1300, stockHistory: [83, 84, 85], stockVolatility: "Low"),
        CompanyDataModel(id: UUID(), name: "TravelX", location: "Sydney", icon: "airplane", stockPrice: 2500, stocksAvailable: 350, stockHistory: [2400, 2450, 2500], stockVolatility: "High")
    ]
    
    for company in companies {
        context.insert(company)
    }
}

@Model
class companyStocks {
    var id: UUID
    var company: CompanyDataModel
    var amount: Int
    var history: [Int]
    
    init(id: UUID, company: CompanyDataModel, amount: Int, history: [Int] = []) {
        self.id = id
        self.company = company
        self.amount = amount
        self.history = history
    }
}
