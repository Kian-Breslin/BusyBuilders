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
