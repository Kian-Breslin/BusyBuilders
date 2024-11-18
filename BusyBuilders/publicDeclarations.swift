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

class AppSettings: ObservableObject {
    // Example of settings variables
    @Published var username: String = "Kian Breslin"
}

class UserManager: ObservableObject {
    @AppStorage("isUserCreated") var isUserCreated: Bool = false
    @AppStorage("colorScheme") var colorScheme: String = "Red"
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    @AppStorage("textColor") var textColor: String = "white"
}

import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("secondaryColor") var secondaryColor: String = "red"

    var mainColor: Color {
        isDarkMode ? getColor("black") : getColor("white")
    }
    
    var textColor: Color {
        isDarkMode ? getColor("white") : getColor("black")
    }
}


let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

func textColor(_ name: String) -> Color {
    switch name.lowercased() {
    case "white" :
        return Color(red: 237 / 255, green: 237 / 255, blue: 237 / 255)
    case "black" :
        return Color.black
    default:
        return Color.teal
    }
}

extension Color {
    static let main = Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255)
    static let secondary = Color(red: 0.949, green: 0.949, blue: 0.949)
}

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
    case "black":
        return Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255)
    case "white":
        return Color(red: 0.949, green: 0.949, blue: 0.949)
    // Add other colors as needed
    default:
        return Color.gray // Fallback if no color matches
    }
}

func createUserFromUsername(_ username : String) -> UserDataModel {
    let name = username
    let username = username
    let email = username+"@gmail.com"
    
    return UserDataModel(username: username, name: name, email: email)
}

extension Color {
    func inverted() -> Color {
        let uiColor = UIColor(self) // Convert SwiftUI Color to UIColor
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Invert the RGB values
        return Color(red: 1 - red, green: 1 - green, blue: 1 - blue)
    }
}

extension Color {
    // Function to calculate the luminance of a color
    func luminance() -> CGFloat {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        // Calculate luminance using standard formula
        return 0.299 * red + 0.587 * green + 0.114 * blue
    }
    
    // Function to decide between white or black text based on luminance
    func suitableTextColor() -> Color {
        return self.luminance() < 0.5 ? .white : .black
    }
}

public func timeFormattedSec(_ totalSeconds: Int) -> String {
    let minutes = totalSeconds / 60
    let seconds = totalSeconds % 60
    
    return String(format: "%02d:%02d", minutes, seconds)
}

public func timeFormattedSecToString ( _ totalSeconds : Int) -> String {
    let minutes = totalSeconds / 60
    let seconds = totalSeconds % 60
    
    return String(format: "%02dm %02ds", minutes, seconds)
}

func getDayOfMonth(from date: Date) -> Int? {
    let formatter = DateFormatter()
    formatter.dateFormat = "d" // 'd' corresponds to the day of the month
    if let day = Int(formatter.string(from: date)) {
        return day
    }
    return nil
}

public func getDayMonthYear(from date: Date) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, d MMMM yyyy" // Format for "Monday, 9 September 2024"
    return formatter.string(from: date)
}

public func getDateMonthYear(from date: Date) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMMM yyyy" // Format for "Monday, 9 September 2024"
    return formatter.string(from: date)
}

public func timeFormattedMins(_ totalSeconds: Int) -> String {
    let hours = totalSeconds / 3600
    let minutes = (totalSeconds % 3600) / 60
    
    return String(format: "%02d:%02d", hours, minutes)
}

func getBusinessName(business: BusinessDataModel) -> String {
    return business.businessName
}

public func timeFormatted(_ totalSeconds: Int) -> String {
    let hours = totalSeconds / 3600
    let minutes = (totalSeconds % 3600) / 60
    let seconds = totalSeconds % 60
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
}
public func timeFormattedWithText(_ totalSeconds: Int) -> String {
    let hours = totalSeconds / 3600
    let minutes = (totalSeconds % 3600) / 60
    let seconds = totalSeconds % 60
    return String(format: "%02d hrs %02d mins %02d secs", hours, minutes, seconds)
}

public func formatFullDateTime(date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE MMMM d, h:mma"
    formatter.amSymbol = "am"
    formatter.pmSymbol = "pm"
    formatter.timeZone = TimeZone.current  // Ensure local time zone
    return formatter.string(from: date)
}

public func currentHour() -> Int {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "HH" // 24-hour format
    let hourString = formatter.string(from: date)
    return Int(hourString) ?? 0 // Return as Int
}

public func randomNumber(in range: ClosedRange<Int>) -> Int {
    return Int.random(in: range)
}

public func getPrestige(_ level: Double) -> String {
    switch level {
    case 0..<21: // 0 - 10 hours (0 - 4 days)
        return "Start-Up" // ~0 - 4 days
    case 21..<51: // 11 - 50 hours (4 - 20 days)
        return "Low Level Business" // ~4 - 20 days
    case 51..<101: // 51 - 100 hours (20 - 40 days)
        return "Growing Business" // ~20 - 40 days
    case 101..<161: // 101 - 160 hours (40 - 64 days)
        return "Established Business" // ~40 - 64 days
    case 161..<221: // 161 - 220 hours (64 - 88 days)
        return "Corporate Entity" // ~64 - 88 days
    case 221..<301: // 221 - 300 hours (88 - 120 days)
        return "Industry Leader" // ~88 - 120 days
    case 301..<401: // 301 - 400 hours (120 - 168 days)
        return "Market Dominator" // ~120 - 168 days
    case 401..<501: // 401 - 500 hours (168 - 210 days)
        return "Global Corporation" // ~168 - 210 days
    case 501..<1000: // 501 - 600 hours (210 - 250 days)
        return "Multi-National Corporation" // ~210 - 250 days
    default:
        return "N/A"
    }}
public func getLevelFromSec(_ sec: Int) -> Int {
    
    let min = sec / 60
    let level = min / 60
    
    return level
}

func timeComponents(from seconds: Int) -> [Int] {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let secs = seconds % 60
    return [hours, minutes, secs]
}

