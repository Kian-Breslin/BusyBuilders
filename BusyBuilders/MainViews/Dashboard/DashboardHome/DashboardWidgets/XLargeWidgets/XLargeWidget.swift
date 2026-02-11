//
//  XLargeWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 13/08/2025.
//

import SwiftUI
import SwiftData
import Charts

struct XLargeWidgetWeeklyGraph: View {
    @Query var users: [UserDataModel]
    @EnvironmentObject var userManager: UserManager
    let widgetSize = xLargeWidgetSize
    @State var data: [ChartData] = [
//            ChartData(day: "Mon", sessionValue: 1200, mgValue: 2800, fcValue: 1100),
//            ChartData(day: "Tue", sessionValue: 1800, mgValue: 2200, fcValue: 1900),
//            ChartData(day: "Wed", sessionValue: 1600, mgValue: 4200, fcValue: 2800),
//            ChartData(day: "Thur", sessionValue: 2800, mgValue: 1400, fcValue: 2300),
//            ChartData(day: "Fri", sessionValue: 4500, mgValue: 1800, fcValue: 1700),
//            ChartData(day: "Sat", sessionValue: 2200, mgValue: 4800, fcValue: 4200),
//            ChartData(day: "Sun", sessionValue: 3800, mgValue: 3600, fcValue: 3200)
        ]
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: widgetSize.width, height: widgetSize.height)
            .foregroundStyle(userManager.mainColor)
            .overlay (alignment:.bottom){
                Chart(data) { item in
                    BarMark(
                        x: .value("Day", item.day),
                        y: .value("Sessions", item.sessionValue)
                    )
                    .foregroundStyle(getColor("\(userManager.accentColor)"))
                    
                    BarMark(
                        x: .value("Day", item.day),
                        y: .value("Sessions", item.mgValue)
                    )
                    .foregroundStyle(getColor("\(userManager.accentColor)"))
                    .opacity(0.7)
                    
                    BarMark(
                        x: .value("Day", item.day),
                        y: .value("Sessions", item.fcValue)
                    )
                    .foregroundStyle(getColor("\(userManager.accentColor)"))
                    .opacity(0.4)
                }
                .chartXAxis {
                    AxisMarks(values: data.map { $0.day}) { day in
                        AxisValueLabel(centered: true)
                            .foregroundStyle(userManager.textColor)
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading) { value in
                        AxisValueLabel()
                            .foregroundStyle(userManager.textColor)
                    }
                }
                .chartPlotStyle { plot in
                    plot
                        .background(userManager.mainColor)
                }
                .frame(width: widgetSize.width-20, height: widgetSize.height-30)
                .padding(10)
                .foregroundStyle(userManager.textColor)
            }
            .onAppear {
                guard let user = users.first else { return }

                let allSessions = user.sessionHistory

                // Rolling last 7 days
                let startDate = Calendar.current.date(byAdding: .day, value: -6, to: Date())!

                let last7Days = allSessions
                    .filter { $0.date >= startDate }
                    .sorted { $0.date < $1.date }

                // Group sessions by day
                let grouped = Dictionary(grouping: last7Days) { session in
                    Calendar.current.startOfDay(for: session.date)
                }
                
                // Build 7-day window (even if empty)
                let days = (0..<7).compactMap {
                    Calendar.current.date(byAdding: .day, value: $0, to: startDate)
                }

                data = days.map { day in
                    let sessions = grouped[Calendar.current.startOfDay(for: day)] ?? []

                    let sessionTotal = sessions.reduce(0) { $0 + Double($1.total) }
                    let mgTotal = sessions.reduce(0) { $0 + Double($1.totalBusinessProductIncome) }
                    let fcTotal = sessions.reduce(0) { $0 + Double($1.totalBusinessServiceIncome) }

                    return ChartData(
                        day: DateFormatter.weekday.string(from: day),
                        sessionValue: sessionTotal,
                        mgValue: mgTotal,
                        fcValue: fcTotal
                    )
                }
            }
    }
}
struct ChartData: Identifiable {
    let id = UUID()
    let day: String
    let sessionValue: Double
    let mgValue: Double
    let fcValue: Double
}

extension DateFormatter {
    static let weekday: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "EEE" // Mon, Tue, Wed
        return df
    }()
}



#Preview {
    XLargeWidgetWeeklyGraph()
        .environmentObject(UserManager())
}
