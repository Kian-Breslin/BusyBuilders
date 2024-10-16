//
//  publicDeclarations.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 25/09/2024.
//
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
        return Color.green
    case "blue":
        return Color.blue
    case "yellow":
        return Color.yellow
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


