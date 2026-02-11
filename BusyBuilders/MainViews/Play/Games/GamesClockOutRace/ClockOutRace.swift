//
//  GamesClockOutRace.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 10/02/2026.
//

import SwiftUI
import SwiftData

struct ClockOutRace: View {
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userManager: UserManager
    
    @State var multiplier = 1.0
    var startingAmount : Double {
        return 1000 * multiplier
    }
    @State private var bombs: Set<Int> = []
    
    private func generateBombs(count: Int = 8) {
        bombs.removeAll()
        while bombs.count < count {
            bombs.insert(Int.random(in: 0..<64))
        }
    }
    
    @State var overallColor = Color.white
    @State private var clickedSet: Set<Int> = []
    @State private var gameOver: Bool = false
    @State private var revealBombs: Bool = false
    
    var body: some View {
        let amountText: String = {
            let value = (1000.0 * multiplier).rounded()
            return String(format: "$%.2f", value)
        }()
        let multiplierText: String = String(format: "x %.2f", multiplier)
        
        
        ZStack {
            Color.clear.onAppear { generateBombs() }
            userManager.mainColor.ignoresSafeArea()
            
            VStack {
                HStack (alignment: .center){
                    Text(amountText)
                        .font(.system(size: 40))
                    Text(multiplierText)
                        .font(.system(size: 20))
                }
                .foregroundStyle(userManager.textColor)
                
                let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 4), count: 8)
                LazyVGrid(columns: columns, spacing: 4) {
                    ForEach(0..<64, id: \.self) { i in
                        Rectangle()
                            .fill(clickedSet.contains(i) ? (bombs.contains(i) ? Color.red : Color.green) : overallColor)
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(4)
                            .overlay {
                                ZStack {
                                    // Reveal hint for bombs when debug toggle is on
                                    if revealBombs && bombs.contains(i) && !clickedSet.contains(i) {
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.red.opacity(0.6), lineWidth: 2)
                                    }
                                    if clickedSet.contains(i) {
                                        if bombs.contains(i) {
                                            Image(systemName: "xmark")
                                                .foregroundStyle(userManager.textColor)
                                        } else {
                                            Image(systemName: "banknote")
                                                .foregroundStyle(userManager.textColor)
                                        }
                                    }
                                }
                            }
                            .onTapGesture {
                                if !clickedSet.contains(i) {
                                    if bombs.contains(i) {
                                        overallColor = Color.red
                                        clickedSet.removeAll()
                                        multiplier = 0.0
                                        gameOver = true
                                    }
                                    else {
                                        clickedSet.insert(i)
                                        multiplier *= 1.5
                                    }
                                }
                            }
                    }
                }
                .padding()
                Spacer()
                
                HStack(spacing: 12) {
                    customButton(text: "Clock Out", color: getColor(userManager.accentColor), width: 120, height: 50) {
                        if let user = users.first {
                            user.availableBalance += Int(startingAmount)
                            dismiss()
                            do {
                                try context.save()
                            }
                            catch {
                                print("Error")
                            }
                        }
                        else {
                            print(Int(startingAmount))
                        }
                    }
//                    customButton(text: revealBombs ? "Hide Bombs" : "Reveal Bombs", color: .red.opacity(0.8), width: 140, height: 50) {
//                        revealBombs.toggle()
//                    }
                }
            }
        }
        .sheet(isPresented: $gameOver) {
            VStack(spacing: 16) {
                Text("Game Over")
                    .font(.title)
                Text("You hit the bomb! Try again.")
                customButton(text: "Play Again", color: getColor(userManager.accentColor), width: 160, height: 50) {
                    // Reset game state
                    clickedSet.removeAll()
                    multiplier = 1.0
                    overallColor = Color.white
                    generateBombs()
                    gameOver = false
                    revealBombs = false
                }
            }
            .padding()
        }
    }
}

#Preview {
    ClockOutRace()
        .environmentObject(UserManager())
}
