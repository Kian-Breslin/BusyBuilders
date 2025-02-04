//
//  MyStats.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 14/11/2024.
//

import SwiftUI
import SwiftData

struct MyStats: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var mgSessions: [MiniGameSessionModel]
    
    @State var totalTimeStudied = [0,0,0]
    
    var body: some View {
        if let user = users.first {
            VStack (alignment: .leading){
                
                miniModules(isTime: false, title: "Total Net Worth", textDetail: "$\(user.availableBalance)")
                VStack (alignment: .leading){
                    Text("Total Time Studied")
                        .opacity(0.5)
                        .font(.system(size: 15))
                    HStack (alignment: .bottom){
                        Text("\(totalTimeStudied[0])")
                        Text("hrs")
                            .font(.system(size: 15))
                        Text("\(totalTimeStudied[1])")
                        Text("mins")
                            .font(.system(size: 15))
                        Text("\(totalTimeStudied[2])")
                        Text("secs")
                            .font(.system(size: 15))
                    }
                    .font(.system(size: 35))
                }
                miniModules(isTime: false, title: "Total Sessions Completed", textDetail: "\(SessionCount(for: user))")
                miniModules(isTime: false, title: "Longest Streak", textDetail: "12")
                miniModules(isTime: false, title: "Level", textDetail: "\(user.level)")
                minigameStats()
                flashcardStats()
                Spacer()
            }
            .foregroundStyle(themeManager.textColor)
            .frame(width: screenWidth-20, height: (screenHeight-90) / 1.4, alignment: .leading)
            .onAppear {
                let totalTime = calculateTotalStudyTime(for: user.businesses)
                totalTimeStudied = timeComponents(from: totalTime)
            }
        }
        else {
            Text("No User Found")
        }
    }
}

#Preview {
    MyStats()
        .modelContainer(for: [UserDataModel.self])
        .environmentObject(ThemeManager())
}
