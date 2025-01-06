//
//  WeeklyGoal.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 14/11/2024.
//

import SwiftUI

struct WeeklyStudyGoal: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var goalProgress = 0.6705
    @State var goalType = "Study Time"
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(themeManager.mainColor)
            .frame(width: screenWidth-20, height: 100)
            .overlay {
                HStack {
                    VStack (alignment: .leading, spacing: 5){
                        HStack {
                            Text("Weekly Study Goal")
                                .font(.system(size: 20))
                                .bold()
                            
//                            Text(goalType)
                        }
                        Text("Current: 2 hr 40 min 33 sec")
                            .font(.system(size: 15))
                        Text("Goal: 4 hr 0 min 0 sec ")
                            .font(.system(size: 15))
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .trim(from: goalProgress, to: 1)
                            .stroke(themeManager.textColor,style: StrokeStyle(lineWidth: 5, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .frame(width: 80)
                        
                        Circle()
                            .trim(from: 0, to: goalProgress)
                            .stroke(getColor("\(themeManager.secondaryColor)"),style: StrokeStyle(lineWidth: 5, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .frame(width: 80)
                        
                        Text("\(goalProgress*100, specifier: "%.f")%")
                            .font(.system(size: 20))
                            .bold()
                    }
                }
                .foregroundStyle(themeManager.textColor)
                .padding()
            }
    }
}

#Preview {
    WeeklyStudyGoal()
        .environmentObject(ThemeManager())
}
