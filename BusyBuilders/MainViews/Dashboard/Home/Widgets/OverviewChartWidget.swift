//
//  OverviewChartWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/11/2024.
//

import SwiftUI
import SwiftData
import Charts

struct OverviewChartWidget: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Query var users : [UserDataModel]
    @Query var MainSessions : [SessionDataModel]
    
    // Example Data
    @State var data: [ChartData] = [
        ChartData(day: "Mon", sessionValue: 1000, mgValue: 2500, fcValue: 1000),
        ChartData(day: "Tue", sessionValue: 2000, mgValue: 2000, fcValue: 2000),
        ChartData(day: "Wed", sessionValue: 1500, mgValue: 5000, fcValue: 3000),
        ChartData(day: "Thur", sessionValue: 3000, mgValue: 1000, fcValue: 2500),
        ChartData(day: "Fri", sessionValue: 5000, mgValue: 2000, fcValue: 1500),
        ChartData(day: "Sat", sessionValue: 2500, mgValue: 5000, fcValue: 5000),
        ChartData(day: "Sun", sessionValue: 4000, mgValue: 4000, fcValue: 3500)
    ]
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(themeManager.mainColor)
            .frame(width: screenWidth-20, height: 250)
            .overlay {
                Chart(data) { item in
                    BarMark(
                        x: .value("Day", item.day),
                        y: .value("Sessions", item.sessionValue)
                    )
                    
                    
                    BarMark(
                        x: .value("Day", item.day),
                        y: .value("Sessions", item.mgValue)
                    )
                    .foregroundStyle(getColor("\(themeManager.secondaryColor)"))
                    .opacity(0.7)// Line color
                    
                    BarMark(
                        x: .value("Day", item.day),
                        y: .value("Sessions", item.fcValue)
                    )
                    .foregroundStyle(getColor("\(themeManager.secondaryColor)")) // Line color
                    .opacity(0.4)// Line color
                    
                }
                .chartXAxis {
                    AxisMarks(values: data.map { $0.day}) { day in
                        AxisValueLabel(centered: true)
                            .foregroundStyle(themeManager.textColor)
                    }
                    
                }
                .chartYAxis {
                    AxisMarks(position: .leading) { value in
                        AxisValueLabel()
                            .foregroundStyle(themeManager.textColor)
                    }
                }
                .chartPlotStyle { plot in
                    plot
                        .background(themeManager.mainColor)
                }
                .frame(height: 200)
                .padding()
            }
            .onAppear {
                if let user = users.first {
                    print("User found: \(user.username)")
                    print("Businesses: \(user.businesses)")
                    print("MiniGame Sessions: \(user.miniGameSessions)")
                    print("Flashcard Sessions: \(user.flashcardSessions)")

                    let results = getWeeklyIncomeBreakdown(
                        businesses: user.businesses,
                        miniGameSessions: user.miniGameSessions,
                        flashcardSessions: user.flashcardSessions
                    )
                    
                    print("Results: \(results)") // Debugging output to verify results
                    
                    for i in 0..<data.count {
                        data[i].sessionValue = Double(results[i][0])
                        data[i].mgValue = Double(results[i][1])
                        data[i].fcValue = Double(results[i][2])
                    }
                } else {
                    print("No user found!")
                }
            }
    }
}

struct ChartData: Identifiable {
    let id = UUID()
    let day: String
    var sessionValue: Double
    var mgValue: Double
    var fcValue: Double
}


#Preview {
    OverviewChartWidget()
        .environmentObject(ThemeManager())
}
