//
//  minigameStats.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/12/2024.
//

import SwiftUI
import SwiftData

struct minigameStats: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var mgSessions: [MiniGameSessionModel]
    
    @State var mgOption = "Higher Or Lower"
    let mgOptions = ["Higher Or Lower", "Slots", "Stocks"]
    var body: some View {
        VStack (alignment: .leading){
            
            Menu {
                Picker("User: ", selection: $mgOption) {
                    ForEach(mgOptions, id: \.self) { opt in
                        Text(opt)
                            .tag(opt)
                    }
                }
            }label: {
                HStack {
                    Text("Mini-Game Stats")
                        .foregroundStyle(themeManager.textColor)
                        .opacity(0.5)
                    Spacer()
                    Text(mgOption)
                        .foregroundStyle(getColor(themeManager.secondaryColor))
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.headline)
                }
                .foregroundStyle(themeManager.mainColor)
                .font(.system(size: 15))
            }
            
            ScrollView (.horizontal, showsIndicators: false){
                HStack {
                    if let user = users.first {
                        ForEach(user.miniGameSessions.filter {$0.sessionGame.rawValue == mgOption}) { game in
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(themeManager.mainColor)
                                .frame(width: 150, height: 100)
                                .overlay {
                                    if game.sessionGame.rawValue == "Higher Or Lower" {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("Value: $\(game.sessionValue)")
                                            Text(game.sessionWin ? "Win" : "Lost")
                                            Text("\(game.sessionScore)")
                                            Text(getDayMonthYear(from: game.sessionDate) ?? "No Date Found")
                                        }
                                        .foregroundStyle(themeManager.textColor)
                                        .font(.caption)
                                        .padding(8)
                                    }
                                    else {
                                        VStack(alignment: .leading, spacing: 4) {
                                            if game.sessionWin == true{
                                                Text("Value: $\(game.sessionValue)")
                                            }
                                            else {
                                                Text("Value: - $\(game.sessionValue)")
                                                    .foregroundStyle(.red)
                                            }
                                            Text(game.sessionWin ? "Win" : "Lost")
                                            Text(getDayMonthYear(from: game.sessionDate) ?? "No Date Found")
                                        }
                                        .foregroundStyle(themeManager.textColor)
                                        .font(.caption)
                                        .padding(8)

                                    }
                            }
                                .onLongPressGesture {
                                    user.miniGameSessions.removeAll { $0.id == game.id }
                                }
                        }
                    }
                    else {
                        Text("No Stats Found")
                    }
                }
            }
        }
    }
}

#Preview {
    minigameStats()
        .environmentObject(ThemeManager())
}
