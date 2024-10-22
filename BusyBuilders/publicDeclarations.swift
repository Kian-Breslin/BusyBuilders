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


let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

func colorForName(_ name: String) -> Color {
    switch name.lowercased() {
    case "red":
        return Color(red: 244/255, green: 73/255, blue: 73/255)
    case "green":
        return Color(red: 85/255, green: 107/255, blue: 47/255)
    case "blue":
        return Color(red: 70/255, green: 130/255, blue: 180/255) // Steel Blue
    case "purple":
        return Color.purple
    case "pink":
        return Color.pink
    // Add other colors as needed
    default:
        return Color.gray // Fallback if no color matches
    }
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

func getDayOfMonth(from date: Date) -> Int? {
    let formatter = DateFormatter()
    formatter.dateFormat = "d" // 'd' corresponds to the day of the month
    if let day = Int(formatter.string(from: date)) {
        return day
    }
    return nil
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

