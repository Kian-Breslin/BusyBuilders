//
//  publicDeclarations.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 25/09/2024.
//
//
import Foundation
import SwiftUI
import SwiftData

class UserManager: ObservableObject {
    @AppStorage("isUserCreated") var isUserCreated: Bool = false
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    @AppStorage("accentColor") var accentColor: String = "red"
    @Published var showSettings: Bool = false
    
    var mainColor: Color {
        isDarkMode ? getColor("black") : getColor("white")
    }
    
    var secondaryColor: Color {
        isDarkMode ? getColor("dark") : getColor("white")
    }
    
    var textColor: Color {
        isDarkMode ? getColor("white") : getColor("black")
    }
}


let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

func getColor(_ name: String) -> Color {
    switch name.lowercased() {
    case "red":
        return Color(red: 244/255, green: 73/255, blue: 73/255)
    case "green":
        return Color(red: 85/255, green: 107/255, blue: 47/255)
    case "blue":
        return Color(red: 70/255, green: 130/255, blue: 180/255) // Steel Blue
    case "yellow":
        return Color(red: 240/255, green: 210/255, blue: 80/255)
    case "purple":
        return Color.purple
    case "pink":
        return Color.pink
    case "cream":
        return Color(red: 241/255, green: 220/255, blue: 185/255)
    case "black":
        return Color(red: 60 / 255, green: 60 / 255, blue: 60 / 255)
    case "white":
        return Color(red: 221 / 255, green: 220 / 255, blue: 216 / 255)
    case "dark":
        return Color(red: 85/255, green: 85/255, blue: 85/255)
    case "light":
        return Color(red: 220, green: 200, blue: 200)
    default:
        return Color.gray // Fallback if no color matches
    }
}

extension Font {
    static func londrina(size: Int) -> Font {
        return Font.custom("LondrinaOutline-Regular", size: CGFloat(size) )
    }
}

let buildings: [Building] = [
    Building(name: "Garage", image: "garageBuilding", cost: 0, employeeCap: 50, bills: 50, rent: 0, boostPerSession: 0),
    Building(name: "Studio", image: "studioBuilding", cost: 25000, employeeCap: 100, bills: 100, rent: 500, boostPerSession: 5),
    Building(name: "Small Office", image: "smallOffice", cost: 50000, employeeCap: 150, bills: 150, rent: 1000, boostPerSession: 10),
    Building(name: "Shared Workspace", image: "sharedWorkspace", cost: 50000, employeeCap: 180, bills: 180, rent: 800, boostPerSession: 8),
    Building(name: "Downtown Office", image: "downtownOffice", cost: 100000, employeeCap: 300, bills: 300, rent: 2000, boostPerSession: 15),
    Building(name: "Industrial Loft", image: "industrialLoft", cost: 100000, employeeCap: 280, bills: 270, rent: 1800, boostPerSession: 12),
    Building(name: "Corporate Floor", image: "corporateFloor", cost: 200000, employeeCap: 500, bills: 450, rent: 4000, boostPerSession: 25),
    Building(name: "Tech Hub", image: "techHub", cost: 300000, employeeCap: 600, bills: 500, rent: 3500, boostPerSession: 30),
    Building(name: "Business Tower", image: "businessTower", cost: 500000, employeeCap: 1000, bills: 800, rent: 6000, boostPerSession: 50),
    Building(name: "Smart Campus", image: "smartCampus", cost: 750000, employeeCap: 1200, bills: 850, rent: 5500, boostPerSession: 60)
]
