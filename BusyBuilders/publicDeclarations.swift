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
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    @AppStorage("secondaryColor") var secondaryColor: String = "red"
    @AppStorage("mainDark") var mainDark: String = "dark"

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
        return Color(red: 217 / 255, green: 217 / 255, blue: 217 / 255)
    case "black" :
        return Color.black
    default:
        return Color.teal
    }
}

public func getNumberArray() -> [Int] {
    var numbers : Set<Int> = []
    while numbers.count < 5 {
        let num = randomNumber(in: 1...10)
        numbers.insert(num)
    }
    return Array(numbers)
}

public func getRandomToolsArray() -> [String] {
    // Define the weighted pool
    let weightedTools = Array(repeating: "screwdriver", count: 40) +
                        Array(repeating: "wrench.adjustable", count: 15) +
                        Array(repeating: "hammer", count: 10) +
                        Array(repeating: "star", count: 1)
    
    var randomTools: [String] = []
    
    // Generate a random array of 10 items from the weighted pool
    while randomTools.count < 10 {
        if let randomTool = weightedTools.randomElement() {
            randomTools.append(randomTool)
        }
    }
    
    return randomTools
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

func createUserFromUsername(_ username : String) -> UserDataModel {
    let name = username
    let username = username
    let email = username+"@gmail.com"
    
    return UserDataModel(username: username, name: name, email: email)
}

func createBankAccountNumber() -> String {
    let accountNumber = String((100_000...999_999).randomElement()!)
    return accountNumber
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

public func convertSecondsToTime(_ seconds: Int) -> [Int] {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let remainingSeconds = seconds % 60
    return [hours, minutes, remainingSeconds]
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

public func transactionTime(from date: Date) -> String {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "EEEE"
    let day = dateFormatter.string(from: date)
    
    dateFormatter.dateFormat = "HH:MM"
    let time = dateFormatter.string(from: date)
    
    return "\(day), \(time)"
}

public func getDateComponents(from date: Date) -> [String] {
    let dateFormatter = DateFormatter()
    
    // Day (19)
    dateFormatter.dateFormat = "d"
    let day = dateFormatter.string(from: date)
    
    // Full Month Name (November)
    dateFormatter.dateFormat = "MMMM"
    let month = dateFormatter.string(from: date)
    
    // Full Year (2024)
    dateFormatter.dateFormat = "yyyy"
    let year = dateFormatter.string(from: date)
    
    // Abbreviated Weekday (Tue)
    dateFormatter.dateFormat = "EEEE"
    let weekday = dateFormatter.string(from: date)
    
    // Current Time in 24-hour format (00:00)
    dateFormatter.dateFormat = "HH:mm"
    let currentTime = dateFormatter.string(from: date)
        
    return [day, month, year, weekday, currentTime]
}

public func getDayMonthYear(from date: Date) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, d MMMM yyyy" // Format for "Monday, 9 September 2024"
    return formatter.string(from: date)
}

public func getDateFull(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMMM yyyy, HH:MM" // Format for "Monday, 9 September 2024"
    return formatter.string(from: date)
}

public func getDateMonthYear(from date: Date) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "d MMMM yyyy"
    return formatter.string(from: date)
}

public func getDateFormat(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/YY"
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
    return String(format: "%02d h %02d m %02d s", hours, minutes, seconds)
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

public func getPrestige(_ level: Int) -> String {
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

func isToday(date: Date) -> Bool {
    let calendar = Calendar.current
    return calendar.isDateInToday(date)
}

func isWithinLast7Days(date: Date) -> Bool {
    let calendar = Calendar.current
    let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
    return date >= sevenDaysAgo
}

func isWithinLast30Days(date: Date) -> Bool {
    let calendar = Calendar.current
    let thirtyDaysAgo = calendar.date(byAdding: .day, value: -30, to: Date())!
    return date >= thirtyDaysAgo
}

func calculateEarningsForPeriods(sessions: [SessionDataModel], miniGameSessions: [MiniGameSessionModel], flashcardSessions: [FlashcardSessionDataModel]) -> [Int] {
    // Initialize variables for today's, last 7 days', and last 30 days' earnings
    var todayEarnings = 0
    var last7DaysEarnings = 0
    var last30DaysEarnings = 0

    // Helper function to calculate earnings for SessionDataModel
    func calculateEarningsForSessionData(sessions: [SessionDataModel]) -> Int {
        return sessions.reduce(0) { $0 + ($1.totalCashEarned - $1.totalCostIncurred) }
    }
    
    // Helper function to calculate earnings for MiniGameSessionModel
    func calculateEarningsForMiniGameSessions(sessions: [MiniGameSessionModel]) -> Int {
        return sessions.reduce(0) { $0 + $1.sessionValue }
    }
    
    // Helper function to calculate earnings for FlashcardSessionDataModel
    func calculateEarningsForFlashcardSessions(sessions: [FlashcardSessionDataModel]) -> Int {
        return sessions.reduce(0) { $0 + $1.sessionValue }
    }

    // Filter and calculate earnings for SessionDataModel (Sessions)
    let todaySessions = sessions.filter { isToday(date: $0.sessionDate) }
    let last7DaysSessions = sessions.filter { isWithinLast7Days(date: $0.sessionDate) }
    let last30DaysSessions = sessions.filter { isWithinLast30Days(date: $0.sessionDate) }

    // Filter and calculate earnings for MiniGameSessionModel (Mini Game Sessions)
    let todayMiniGameSessions = miniGameSessions.filter { isToday(date: $0.sessionDate) }
    let last7DaysMiniGameSessions = miniGameSessions.filter { isWithinLast7Days(date: $0.sessionDate) }
    let last30DaysMiniGameSessions = miniGameSessions.filter { isWithinLast30Days(date: $0.sessionDate) }

    // Filter and calculate earnings for FlashcardSessionDataModel (Flashcard Sessions)
    let todayFlashcardSessions = flashcardSessions.filter { isToday(date: $0.sessionDate) }
    let last7DaysFlashcardSessions = flashcardSessions.filter { isWithinLast7Days(date: $0.sessionDate) }
    let last30DaysFlashcardSessions = flashcardSessions.filter { isWithinLast30Days(date: $0.sessionDate) }

    // Calculate earnings for Today
    todayEarnings = calculateEarningsForSessionData(sessions: todaySessions) +
                    calculateEarningsForMiniGameSessions(sessions: todayMiniGameSessions) +
                    calculateEarningsForFlashcardSessions(sessions: todayFlashcardSessions)
    
    // Calculate earnings for Last 7 Days
    last7DaysEarnings = calculateEarningsForSessionData(sessions: last7DaysSessions) +
                        calculateEarningsForMiniGameSessions(sessions: last7DaysMiniGameSessions) +
                        calculateEarningsForFlashcardSessions(sessions: last7DaysFlashcardSessions)

    // Calculate earnings for Last 30 Days
    last30DaysEarnings = calculateEarningsForSessionData(sessions: last30DaysSessions) +
                         calculateEarningsForMiniGameSessions(sessions: last30DaysMiniGameSessions) +
                         calculateEarningsForFlashcardSessions(sessions: last30DaysFlashcardSessions)

    // Return earnings for Today, Last 7 Days, and Last 30 Days
    return [todayEarnings, last7DaysEarnings, last30DaysEarnings]
}

func getWeeklyIncomeBreakdown(businesses: [BusinessDataModel], miniGameSessions: [MiniGameSessionModel], flashcardSessions: [FlashcardSessionDataModel]) -> [[Int]] {
    // Helper function to get the start of the week (Monday)
    func startOfWeek(for date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        return calendar.date(from: components) ?? date
    }
    
    let calendar = Calendar.current
    let today = Date()
    let weekStart = startOfWeek(for: today)
    
    // Initialize arrays for daily income breakdown
    var sessionIncome = [0, 0, 0, 0, 0, 0, 0] // Mon-Sun
    var miniGameIncome = [0, 0, 0, 0, 0, 0, 0] // Mon-Sun
    var flashcardIncome = [0, 0, 0, 0, 0, 0, 0] // Mon-Sun
    
    // Helper function to get the day of the week (Mon = 0, ..., Sun = 6)
    func getDayOfWeek(from date: Date) -> Int? {
        let weekday = calendar.component(.weekday, from: date)
        return (weekday == 1) ? 6 : weekday - 2 // Adjusting so that Monday = 0, ..., Sunday = 6
    }
    
    // Process session income from businesses
    for business in businesses {
        for session in business.sessionHistory {
            if let dayIndex = getDayOfWeek(from: session.sessionDate),
               session.sessionDate >= weekStart,
               session.sessionDate <= today {
                sessionIncome[dayIndex] += session.totalCashEarned - session.totalCostIncurred
            }
        }
    }
    
    // Process mini-game income
    for miniGameSession in miniGameSessions {
        if let dayIndex = getDayOfWeek(from: miniGameSession.sessionDate),
           miniGameSession.sessionDate >= weekStart,
           miniGameSession.sessionDate <= today {
            miniGameIncome[dayIndex] += miniGameSession.sessionValue
        }
    }
    
    // Process flashcard income
    for flashcardSession in flashcardSessions {
        if let dayIndex = getDayOfWeek(from: flashcardSession.sessionDate),
           flashcardSession.sessionDate >= weekStart,
           flashcardSession.sessionDate <= today {
            flashcardIncome[dayIndex] += flashcardSession.sessionValue
        }
    }
    
    // Combine daily incomes into a breakdown array
    var weeklyIncomeBreakdown: [[Int]] = []
    for day in 0..<7 {
        weeklyIncomeBreakdown.append([
            sessionIncome[day],
            miniGameIncome[day],
            flashcardIncome[day]
        ])
    }
    return weeklyIncomeBreakdown
}

func calculateTotalStudyTime(for businesses: [BusinessDataModel]) -> Int {
    var totalTime = 0
    
    for business in businesses {
//        print("Calculating for business: \(business.businessName)")
        for session in business.sessionHistory {
//            print("Session time: \(session.totalStudyTime) seconds")
            totalTime += session.totalStudyTime
        }
    }
    
//    print("Total calculated time: \(totalTime) seconds")
    return totalTime
}

func totalBusinessNetWorth(for user: UserDataModel) -> Int {
    var totalNetWorth: Int = 0
    for business in user.businesses {
        totalNetWorth += business.netWorth
    }
    return totalNetWorth
}

func SessionCount(for user: UserDataModel) -> Int {
    var totalCount: Int = 0
    for business in user.businesses {
        totalCount += business.sessionHistory.count
    }
    return totalCount
}

let allBusinessUpgrades: [BusinessUpgradeModel] = [
    BusinessUpgradeModel(upgradeName: "Study Boost",
                         upgradeIcon: "book",
                         upgradePrice: 5000,
                         upgradeRequiredLevel: 3600,
                         isUnlocked: false,
                         upgradeType: "XPBoost",
                         upgradeDescription: "Boosts XP gain by 10% during study sessions."),
    
    BusinessUpgradeModel(upgradeName: "Night Owl",
                         upgradeIcon: "moon",
                         upgradePrice: 7000,
                         upgradeRequiredLevel: 18000,
                         isUnlocked: false,
                         upgradeType: "XPBoost",
                         upgradeDescription: "Increases XP gain by 15% for late-night study sessions."),
    
    BusinessUpgradeModel(upgradeName: "Public Speaker",
                         upgradeIcon: "microphone",
                         upgradePrice: 10000,
                         upgradeRequiredLevel: 36000,
                         isUnlocked: false,
                         upgradeType: "CashBoost",
                         upgradeDescription: "Increases cash earned per session by 10%."),
    
    BusinessUpgradeModel(upgradeName: "Creative Mind",
                         upgradeIcon: "paintbrush",
                         upgradePrice: 12000,
                         upgradeRequiredLevel: 54000,
                         isUnlocked: false,
                         upgradeType: "XPBoost",
                         upgradeDescription: "Enhances creativity-based tasks with 12% more XP."),
    
    BusinessUpgradeModel(upgradeName: "Content Creator",
                         upgradeIcon: "tv",
                         upgradePrice: 15000,
                         upgradeRequiredLevel: 72000,
                         isUnlocked: false,
                         upgradeType: "CashBoost",
                         upgradeDescription: "Increases passive cash income by 8%."),
    
    BusinessUpgradeModel(upgradeName: "Networking Pro",
                         upgradeIcon: "person.3",
                         upgradePrice: 20000,
                         upgradeRequiredLevel: 90000,
                         isUnlocked: false,
                         upgradeType: "CashBoost",
                         upgradeDescription: "Boosts business earnings by 15% through networking."),
    
    BusinessUpgradeModel(upgradeName: "Financial Planner",
                         upgradeIcon: "creditcard",
                         upgradePrice: 25000,
                         upgradeRequiredLevel: 108000,
                         isUnlocked: false,
                         upgradeType: "CostReduction",
                         upgradeDescription: "Reduces upgrade costs by 10%."),
    
    BusinessUpgradeModel(upgradeName: "Music Focus",
                         upgradeIcon: "music.note.house",
                         upgradePrice: 30000,
                         upgradeRequiredLevel: 126000,
                         isUnlocked: false,
                         upgradeType: "XPBoost",
                         upgradeDescription: "Listening to music increases XP gain by 5%."),
    
    BusinessUpgradeModel(upgradeName: "Entrepreneurial Mindset",
                         upgradeIcon: "briefcase",
                         upgradePrice: 40000,
                         upgradeRequiredLevel: 144000,
                         isUnlocked: false,
                         upgradeType: "CashBoost",
                         upgradeDescription: "Boosts all business earnings by 20%."),
    
    BusinessUpgradeModel(upgradeName: "Smart Shopper",
                         upgradeIcon: "cart",
                         upgradePrice: 45000,
                         upgradeRequiredLevel: 162000,
                         isUnlocked: false,
                         upgradeType: "CostReduction",
                         upgradeDescription: "Reduces upgrade costs by 15%."),
    
    BusinessUpgradeModel(upgradeName: "Signature Style",
                         upgradeIcon: "signature",
                         upgradePrice: 50000,
                         upgradeRequiredLevel: 180000,
                         isUnlocked: false,
                         upgradeType: "XPBoost",
                         upgradeDescription: "Personal branding increases XP gain by 8%."),
    
    BusinessUpgradeModel(upgradeName: "High Achiever",
                         upgradeIcon: "star",
                         upgradePrice: 60000,
                         upgradeRequiredLevel: 198000,
                         isUnlocked: false,
                         upgradeType: "XPBoost",
                         upgradeDescription: "Boosts XP gain by 20% after long study sessions."),
    
    BusinessUpgradeModel(upgradeName: "Trusted Authority",
                         upgradeIcon: "checkmark.seal",
                         upgradePrice: 70000,
                         upgradeRequiredLevel: 216000,
                         isUnlocked: false,
                         upgradeType: "CashBoost",
                         upgradeDescription: "Your reputation boosts cash earnings by 25%."),
    
    BusinessUpgradeModel(upgradeName: "Peak Productivity",
                         upgradeIcon: "flame",
                         upgradePrice: 75000,
                         upgradeRequiredLevel: 234000,
                         isUnlocked: false,
                         upgradeType: "XPBoost",
                         upgradeDescription: "Doubles XP gain for sessions longer than 1 hour."),
    
    BusinessUpgradeModel(upgradeName: "Master Negotiator",
                         upgradeIcon: "tag",
                         upgradePrice: 80000,
                         upgradeRequiredLevel: 252000,
                         isUnlocked: false,
                         upgradeType: "CostReduction",
                         upgradeDescription: "Reduces all upgrade costs by 20%.")
]

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Start from the bottom-left corner of the rectangle
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        // Draw line to the top-center of the rectangle
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        // Draw line to the bottom-right corner of the rectangle
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        // Close the path (back to the bottom-left corner)
        path.closeSubpath()
        
        return path
    }
}

struct IrregularRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Starting point at the top-left corner
        path.move(to: CGPoint(x: rect.minX + 120, y: rect.minY)) // Start slightly inside for the curved effect
        
        // Top line (match Dynamic Island width, e.g., 320)
        path.addLine(to: CGPoint(x: rect.maxX - 120, y: rect.minY)) // End the top line slightly inside
        
        // Right line
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        // Bottom line
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        // Close the path back to the starting point
        path.closeSubpath()
        
        return path
    }
}
import AVFoundation

class AudioManager: ObservableObject {
    var audioPlayer: AVAudioPlayer?
    
    // Play sound method
    func playSound(named soundName: String) {
        if let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.numberOfLoops = -1  // Set looping before playing
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}

struct Code: Codable {
    let code: String
    let used: Bool
}

func fetchCodes() {
    guard let url = URL(string: "https://script.googleusercontent.com/macros/echo?user_content_key=PiU3eaU9Tc3DwH6sAUZ4KsS3Nmi79LTMRqAFV-9bPwMA_2Amg0ZbkBm0dJz-TCn0EjyKtI8JPEUkj-0JvptbWmBEXEWwzAMqm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnAY9Ptq-UmQWjKt6X2EN2DceMPnJ8IRAnLiwRiGcny8NK8aznCPnrzRK1zjx41Ex3-GgVcmjiWdZYnSfWncwkunXzrmbI4YLYdz9Jw9Md8uu&lib=MSiDQvAZ-zD7-JRHkuE1vt2C3QdPFZkf3") else { return }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        // Check for errors
        if let error = error {
            print("Error: \(error)")
            return
        }
        
        // Check if we got data
        guard let data = data else {
            print("No data received")
            return
        }
        
        do {
            // Decode the JSON response
            let codes = try JSONDecoder().decode([Code].self, from: data)
            
            // Print all the codes
            for code in codes {
                print("Code: \(code.code)")
            }
        } catch {
            print("Failed to decode data: \(error)")
        }
    }
    
    task.resume()
}

func redeemCode(code: String, email: String) {
    guard let url = URL(string: "https://script.google.com/macros/s/AKfycbzEx5Nk_A9wlMLVp66YepvFOsKfTk-QI0luOfcXgSHGuTnNFktdSN9ONIMlSdZoQMI3nw/exec") else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body: [String: Any] = ["code": code, "email": email]
    
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
    } catch {
        print("Error encoding data: \(error)")
        return
    }
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Request failed: \(error)")
            return
        }
        
        guard let data = data else {
            print("No data received")
            return
        }
        
        do {
            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            print("Response:", jsonResponse ?? "Invalid response")
        } catch {
            print("Failed to decode response: \(error)")
        }
    }.resume()
}

func exchangeAuthorizationCodeForToken(code: String, completion: @escaping (String?, String?) -> Void) {
    // Your OAuth2 client credentials
    let clientId = "405865461365-ai7hpaqcffg7ipemju741nk6iaomphuk.apps.googleusercontent.com"
    let clientSecret = "YOUR_CLIENT_SECRET"  // You should use your client secret
    let redirectUri = "busybuilder://oauth2callback"  // The same redirect URI used during authorization
    
    // Google OAuth Token Endpoint
    let tokenUrl = URL(string: "https://oauth2.googleapis.com/token")!
    
    var request = URLRequest(url: tokenUrl)
    request.httpMethod = "POST"
    
    // Set up body parameters
    let bodyParameters = [
        "code": code,
        "client_id": clientId,
        "client_secret": clientSecret,
        "redirect_uri": redirectUri,
        "grant_type": "authorization_code"
    ]
    
    // Format the body as `application/x-www-form-urlencoded`
    let bodyData = bodyParameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&").data(using: .utf8)
    request.httpBody = bodyData
    
    // Set the content type header
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    // Create the URLSession and send the request
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            completion(nil, nil)
            return
        }
        
        // Parse the response
        if let data = data {
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                // Extract access token and refresh token from the response
                let accessToken = jsonResponse?["access_token"] as? String
                let refreshToken = jsonResponse?["refresh_token"] as? String
                
                // Call the completion handler with the tokens
                completion(accessToken, refreshToken)
            } catch {
                print("Error parsing response: \(error)")
                completion(nil, nil)
            }
        }
    }.resume()
}
