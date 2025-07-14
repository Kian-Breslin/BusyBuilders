//
//  MediumModularWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 21/11/2024.
//

import SwiftUI
import SwiftData

struct MediumModularWidget: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Query var users : [UserDataModel]
    var MainSessions: [SessionDataModel]
    
    @State var selectedViewTime = "Today"
    @State var selectedViewAmount = 31000
    @State var selectedViewGrowth = 30
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: (screenWidth-20)/2, height: ((screenWidth - 45) / 2 - 5) / 2)
            .foregroundStyle(themeManager.mainColor)
            .overlay {
                VStack (alignment: .leading, spacing: 5){
                    HStack {
                        Text("Revenue - \(selectedViewTime)")
                            .opacity(0.7)
                        
                        HStack (spacing: 2){
                            Text("\(selectedViewGrowth)%")
                            Image(systemName: "arrow.up")
                                .font(.system(size: 10))
                                .rotationEffect(Angle(degrees: 45))
                        }
                        .font(.system(size: 15))
                        .foregroundStyle(getColor("\(themeManager.secondaryColor)"))
                        
                    }
                    .padding(.leading, 10)
                    .font(.system(size: 15))
                    
                    Text("$\(selectedViewAmount)")
                        .font(.system(size: 35))
                        .padding(.horizontal, 10)
                    
                }
                .frame(width: (screenWidth-20)/2, alignment: .leading)
                .foregroundStyle(themeManager.textColor)
            }
            .onTapGesture {
                if let user = users.first {
                    let todayEarnings = calculateEarningsForPeriods(sessions: MainSessions, miniGameSessions: user.miniGameSessions, flashcardSessions: user.flashcardSessions)
                    
                    
                    if selectedViewTime == "Today" {
                        selectedViewTime = "Week"
                        selectedViewAmount = todayEarnings[0]
                        selectedViewGrowth = 12
                    }
                    else if selectedViewTime == "Week"{
                        selectedViewTime = "Month"
                        selectedViewAmount = todayEarnings[1]
                        selectedViewGrowth = 44
                    }
                    else if selectedViewTime == "Month"{
                        selectedViewTime = "Today"
                        selectedViewAmount = todayEarnings[2]
                        selectedViewGrowth = 30
                    }
                }
            }
            .onAppear {
                if let user = users.first {
                    let todayEarnings = calculateEarningsForPeriods(sessions: MainSessions, miniGameSessions: user.miniGameSessions, flashcardSessions: user.flashcardSessions)
                    selectedViewAmount = todayEarnings[0]
                }
            }
    }
}

#Preview {
    MediumModularWidget(MainSessions: [])
        .environmentObject(ThemeManager())
        .modelContainer(for: [UserDataModel.self], inMemory: true)
}
