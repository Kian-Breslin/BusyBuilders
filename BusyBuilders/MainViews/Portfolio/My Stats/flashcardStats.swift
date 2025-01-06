//
//  flashcardStats.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/12/2024.
//

import SwiftUI
import SwiftData

struct flashcardStats: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var mgSessions: [MiniGameSessionModel]
    
    @State var deckSize = "Single-Deck"
    let deckOptions = ["Single-Deck", "Mulit-Deck"]
    
    var body: some View {
        VStack (alignment: .leading){
            
            Menu {
                Picker("Deck Size: ", selection: $deckSize) {
                    ForEach(deckOptions, id: \.self) { opt in
                        Text(opt)
                            .tag(opt)
                    }
                }
            }label: {
                HStack {
                    Text("Flashcard Stats")
                        .foregroundStyle(themeManager.textColor)
                        .opacity(0.5)
                    Spacer()
                    Text(deckSize)
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
                        ForEach(user.flashcardSessions) { game in
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(themeManager.mainColor)
                                .frame(width: 150, height: 100)
                                .overlay {
                                    flashcardStatsDetails(game: game)
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

struct flashcardStatsDetails: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State var game: FlashcardSessionDataModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Value: $\(game.sessionValue)")
            Text(game.sessionWin ? "Win" : "Lost")
            Text(game.sessionType.rawValue)
            Text(getDayMonthYear(from: game.sessionDate) ?? "No Date Found")
        }
        .foregroundStyle(themeManager.textColor)
        .font(.caption)
        .padding(8)
    }
}

#Preview {
    flashcardStats()
        .environmentObject(ThemeManager())
}
