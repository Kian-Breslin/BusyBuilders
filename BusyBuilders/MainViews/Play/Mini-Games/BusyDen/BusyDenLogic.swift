//
//  BusyDenLogic.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 27/05/2025.
//

import SwiftUI
import SwiftData
import Foundation

@Model
class Product: Identifiable{
    var id: UUID
    var name: String
    var icon: String
    var innovation: Int
    var design: Int
    var research: Int
    var scale: Int
    var demand: Int
    var price : Int = 0
    
    init(id: UUID, name: String, icon: String, innovation: Int, design: Int, research: Int, scale: Int, demand: Int, price: Int = 0) {
        self.id = id
        self.name = name
        self.icon = icon
        self.innovation = innovation
        self.design = design
        self.research = research
        self.scale = scale
        self.demand = demand
        self.price = price
    }
    
    func getAvg() -> Int {
        return (innovation + design + research + scale + demand) / 5
    }
}


@Model
class Investor {
    var name: String
    var age: Int
    var innovation: Int
    var design: Int
    var research: Int
    var scale: Int
    var demand: Int
    
    var netWorth : Int
    var strictness : Int
    var anger : Int
    
    init(name: String, age: Int, innovation: Int, design: Int, research: Int, scale: Int, demand: Int, netWorth: Int, strictness: Int, anger: Int) {
        self.name = name
        self.age = age
        self.innovation = innovation
        self.design = design
        self.research = research
        self.scale = scale
        self.demand = demand
        self.netWorth = netWorth
        self.strictness = strictness
        self.anger = anger
    }
    
    func rateProduct(product: Product) -> String {
        var rating = 0
        
        func getChance(rating: Int)-> Int {
            switch rating {
            case 0..<3:
                return 2
            case 3..<7:
                return 1
            default:
                return 0
            }
        }
        
        let innovationDiff = abs(product.innovation - self.innovation)
        rating += getChance(rating: innovationDiff)
        let designDiff = abs(product.design - self.design)
        rating += getChance(rating: designDiff)
        let researchDiff = abs(product.research - self.research)
        rating += getChance(rating: researchDiff)
        let scaleDiff = abs(product.scale - self.scale)
        rating += getChance(rating: scaleDiff)
        let demandDiff = abs(product.demand - self.demand)
        rating += getChance(rating: demandDiff)
        
//        rating += innovationDiff + designDiff + researchDiff + scaleDiff + demandDiff
        print("\(self.name)'s" + " investment % is " + "\(rating)")
        
        switch rating {
        case 0..<3:
            return "Highly likely"
        case 3..<5:
            return "Thinking about it"
        case 5..<8:
            return "Could be swayed"
        case 8...10:
            return "Not Interested"
        default:
            return "Not Sure"
        }
    }
    
    
}

func makeFakeInvestor() -> Investor {
    let fakeNames = ["Barry", "Ted", "Bob", "Sarah", "Kim", "Kian", "Daniel", "Gary", "Robert", "Keelyn"]
    
    let name = "\(fakeNames[Int.random(in: 0..<10)])"
    
    return Investor(name: name, age: Int.random(in: 20..<80), innovation: Int.random(in: 0...10), design: Int.random(in: 0...10), research: Int.random(in: 0...10), scale: Int.random(in: 0...10), demand: Int.random(in: 0...10), netWorth: Int.random(in: 0...10), strictness: Int.random(in: 0...10), anger: 0)
}

func makeFakeProduct(type : Int) -> Product {
    let products = [("Smart Mug", "cup.and.saucer.fill"), ("Eco Lamp", "lightbulb.fill"), ("AI Assistant", "brain.fill"), ("Wireless Charger", "bolt.fill"), ("Desk Plant", "leaf.fill"), ("Noise-Canceling Headphones", "headphones"), ("Smart Notebook", "book.fill"), ("Minimalist Desk", "table.fill"), ("Portable Projector", "display"), ("Water Bottle", "drop.fill")]
    switch type {
    case 0:
        return Product(id: UUID(), name: products.randomElement()!.0, icon: products.randomElement()!.1, innovation: 10, design: 10, research: 10, scale: 10, demand: 10)
    case 1:
        return Product(id: UUID(), name: products.randomElement()!.0, icon: products.randomElement()!.1, innovation: 0, design: 0, research: 0, scale: 0, demand: 0)
    case 2:
        return Product(id: UUID(), name: products.randomElement()!.0, icon: products.randomElement()!.1, innovation: 5, design: 5, research: 5, scale: 5, demand: 5)
    default:
        return Product(id: UUID(), name: products.randomElement()!.0, icon: products.randomElement()!.1, innovation: Int.random(in: 0...10), design: Int.random(in: 0...10), research: Int.random(in: 0...10), scale: Int.random(in: 0...10), demand: Int.random(in: 0...10))
    }
}
