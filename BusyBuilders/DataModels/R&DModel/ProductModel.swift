//
//  ProductModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 24/07/2025.
//

import Foundation

class ProductModel: Identifiable, Codable {
    var id = UUID()
    var name: String
    var type: ProductType
    var rating: Int = 0
    var quantity: Int = 0
    // History
    var lifetimeIncome: Int

    var costToProduce: Int {
        switch type {
        case .physical:
            return 200
        case .service:
            return 100
        case .software:
            return 30
        }
    }

    var price: Int {
        switch type {
        case .physical:
            return 300
        case .service:
            return 200
        case .software:
            return 90
        }
    }

    var profit: Int {
        return price - costToProduce
    }
    
    init(id: UUID = UUID(), name: String, type: ProductType, rating: Int = 0, quantity: Int, lifetimeIncome: Int = 0) {
        self.id = id
        self.name = name
        self.type = type
        self.rating = rating
        self.quantity = quantity
        self.lifetimeIncome = lifetimeIncome
    }
}


enum ProductType: Codable {
    case physical, software, service
}



extension ProductModel {
    func runProductSim() -> Int {
        guard quantity > 0 else {return 0}
        var quantitySold = Int.random(in: 0...quantity)
        self.quantity -= quantitySold
        self.lifetimeIncome += quantitySold * profit
        
        return quantitySold * profit
    }
}
