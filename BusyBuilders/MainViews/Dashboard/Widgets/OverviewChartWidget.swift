//
//  OverviewChartWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/11/2024.
//

import SwiftUI
import Charts

struct OverviewChartWidget: View {
    @EnvironmentObject var themeManager: ThemeManager
    // Example Data
    let data: [ChartData] = [
        ChartData(day: "Mon", value: 5000),
        ChartData(day: "Tue", value: 15000),
        ChartData(day: "Wed", value: 10000),
        ChartData(day: "Thur", value: 12000),
        ChartData(day: "Fri", value: 15000),
        ChartData(day: "Sat", value: 14000),
        ChartData(day: "Sun", value: 11050),
    ]
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(themeManager.mainColor)
            .frame(width: screenWidth-30, height: 250)
            .overlay {
                Chart(data) { item in
                    BarMark(
                        x: .value("Day", item.day),
                        y: .value("Sessions", item.value)
                    )
                    .foregroundStyle(getColor("\(themeManager.secondaryColor)").gradient) // Line color
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
                            .foregroundStyle(themeManager.textColor) // Y-axis label color (Sessions)
                    }
                }
                .chartPlotStyle { plot in
                    plot
                        .background(themeManager.mainColor)
                }
                .frame(height: 200) // Adjust chart height
                .padding()
            }
    }
}

struct ChartData: Identifiable {
    let id = UUID()
    let day: String
    let value: Double
}


#Preview {
    OverviewChartWidget()
        .environmentObject(ThemeManager())
}
