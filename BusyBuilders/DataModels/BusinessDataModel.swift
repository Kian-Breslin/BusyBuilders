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
        let baseCost = 20 + (level * 4)
        return baseCost + employeeCostperMinute
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
        return (baseHiringCost) + (4 * employees)
    }
    var employeeCashperMinute: Int {
        let baseIncome = 5
        let incomePerLevel = 2
        return employees * (baseIncome + (level * incomePerLevel))
    }
    var employeeCostperMinute: Int {
        let baseCost = 2
        let costPerLevel = 2
        let financeLevel = departments["Finance Department"]?.level ?? 0
        let discount = financeLevel * 2
        let adjustedCostPerEmployee = max(baseCost + (level * costPerLevel) - discount, 0)
        return employees * adjustedCostPerEmployee
    }
    var employees : Int = 0
    
    // Operations Department : Can upgrade Premises
    var buildings: [Building] = [Building(name: "Garage", image: "garageBuilding", cost: 0, employeeCap: 10, bills: 10, rent: 0, boostPerSession: 0)]
    var rentingBuildings: [Building] = []
    var rentedBuildings: [Building] = []
    // R&D Department : Can do Product Research
    var activeResearchProjects: [String] = []
    var products: [ProductModel] = []
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
    
    init(id: UUID = UUID(), businessName: String, businessTheme: String, businessType: String, businessIcon: String, creationDate: Date = Date.now, totalTime: Int) {
        self.id = id
        self.businessName = businessName
        self.businessTheme = businessTheme
        self.businessType = businessType
        self.businessIcon = businessIcon
        self.creationDate = creationDate
        self.totalTime = totalTime
    }
}

struct Building: Codable, Hashable {
    var name: String
    var image: String
    var cost: Int
    var employeeCap: Int
    var bills: Int
    var rent: Int
    var costPerSession: Int {
        return rent + bills
    }
    var boostPerSession: Int
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
        totalTime: 0
    )
    
    func upgradeDepartment(dept: String){
        if var department = departments[dept], department.isUnlocked {
            department.level += 1
            departments[dept] = department
        }
    }
    
    func buyDepartment(dept: String) {
        self.departments[dept]?.isUnlocked = true
    }
    
    func addEmployee() {
        employees += 1
    }

    func priceForNewDepartment() -> Int {
        let unlockedCount = departments.values.filter { $0.isUnlocked }.count
        return 25000 * (unlockedCount + 1)
    }
    
    func createProduct() {
        
    }
    
    func createPreviwProduct() {
        let productNames = ["Laptop", "Phone", "Bike", "Social App", "Cereal", "Car", "Delivery Service", "Gym"]
        let newProduct = ProductModel(name: "\(productNames[Int.random(in: 0..<8)])", type: .service, quantity: 0)
        self.products.append(newProduct)
    }
    
}




extension BusinessDataModel {
    func checkBuildingOwnership(buildingName: String) -> (Bool, String) {
        if buildings.contains(where: { $0.name == buildingName }) {
            return (true, "You already own this building")
        } else if rentingBuildings.contains(where: { $0.name == buildingName }) {
            return (true, "You are already renting this building")
        } else if rentedBuildings.contains(where: { $0.name == buildingName }) {
            return (true, "You are already renting out this buidling")
        } else {
            return (false, "not found")
        }
    }

    var ownedBuildings: [Building] {
        return buildings
    }
    
}
