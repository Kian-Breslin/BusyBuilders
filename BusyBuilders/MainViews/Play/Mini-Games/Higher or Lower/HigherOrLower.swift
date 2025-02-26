//
//  HigherOrLower.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 26/11/2024.
//

import SwiftUI
import SwiftData

struct HigherOrLower: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var mgSessions: [MiniGameSessionModel]
    @Environment(\.dismiss) var dismiss
    
    @Binding var isTaskActive : Bool
    
    @State var currentCardShowing = 0
    @State var chosenNums = getNumberArray()
    @State var gameOver = false
    @State var inputAmount = 100.0
    @State var winnings = 0
    @State var winner = false
    let endMessages = ["Unlucky!", "Better luck Next time!", "Keep Trying!", "Nearly There!", "Congratulations"]
    @State var higherOrLowerConfig = false
    
    // Session Tracker
    @State var sessionDate : Date = Date()
    @State var sessionWin: Bool = false
    @State var sessionScore: Int = 0
    @State var sessionValue: Int = 0
    
    // Dismiss Everything
    @State var dismissEverything = false
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack (spacing: 50){
                HStack {
                    Text("Higher or Lower")
                    Text("\(chosenNums)")
                        .font(.largeTitle)
                    Spacer()
                    
                    Image(systemName: "info.circle")
                        .font(.title2)
                        .onTapGesture {
                            dismiss()
                        }
                }
                
                HStack (spacing: 10){
                    ForEach(0..<5) { i in
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: (screenWidth-70)/5, height: 100)
                            .overlay {
                                Text("\(chosenNums[i])")
                                    .foregroundStyle(themeManager.mainColor)
                                    .font(.largeTitle)
                                    .opacity(i <= currentCardShowing ? 1 : 0)
                            }
                    }
                }
                .padding(.bottom, 50)
                
                Text("$\(inputAmount, specifier: "%.f")")
                    .font(.largeTitle)
                
                if currentCardShowing != 4 && !gameOver {
                    HStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 100, height: 50)
                            .overlay {
                                Text("Lower")
                                    .foregroundStyle(themeManager.mainColor)
                            }
                            .onTapGesture {
                                if currentCardShowing <= 3 {
                                    currentCardShowing += 1
                                    if chosenNums[currentCardShowing-1] > chosenNums[currentCardShowing] {
                                        inputAmount *= 2
                                    }
                                    else {
                                        gameOver = true
                                        isTaskActive.toggle()
                                    }
                                }
                                else {
                                    gameOver = true
                                    isTaskActive.toggle()
                                }
                            }
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 100, height: 50)
                            .overlay {
                                Text("Higher")
                                    .foregroundStyle(themeManager.mainColor)
                            }
                            .onTapGesture {
                                if currentCardShowing <= 3 {
                                    currentCardShowing += 1
                                    if chosenNums[currentCardShowing-1] < chosenNums[currentCardShowing] {
                                        inputAmount *= 2
                                    }
                                    else {
                                        gameOver = true
                                        isTaskActive.toggle()
                                    }
                                }
                                else {
                                    gameOver = true
                                    isTaskActive.toggle()
                                }
                            }
                    }
                }
                else {
                    if currentCardShowing < 4 && gameOver {
                        Text("Game Over!")
                            .onAppear {
                                gameOver = true
                                isTaskActive.toggle()
                                
                                sessionDate = Date()
                                sessionWin = false
                                sessionScore = currentCardShowing
                                sessionValue = 0
                                
                                makeSession(sessionDate, sessionWin, sessionScore, sessionValue)
                            }
                    }
                    else {
                        Text("Congratulations You Won!")
                            .onAppear {
                                if let user = users.first {
                                    user.availableBalance += Int(inputAmount)
                                    user.level += getLevel(currentCardShowing)
                                    
                                    let newTransaction = TransactionDataModel(category: "Minigame", amount: Int(inputAmount), transactionDescription: "Higher or Lower Payout", createdAt: Date(), income: true)
                                    
                                    user.transactions.append(newTransaction)
                                    
                                    do {
                                        try context.save()
                                    } catch {
                                        print("Error when savings Higher or Lower Payout")
                                    }
                                }
                                
                                gameOver = true
                                isTaskActive.toggle()
                                
                                sessionDate = Date()
                                sessionWin = true
                                sessionScore = 4
                                sessionValue = Int(inputAmount)
                                
                                makeSession(sessionDate, sessionWin, sessionScore, sessionValue)
                            }
                    }
                }
                
                if !gameOver {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 100, height: 50)
                        .overlay {
                            Text("Cash Out")
                                .foregroundStyle(themeManager.mainColor)
                        }
                        .onTapGesture {
                            gameOver = true
                            isTaskActive = false
                            
                            sessionDate = Date()
                            sessionWin = false
                            sessionScore = currentCardShowing
                            sessionValue = Int(inputAmount)
                            
                            makeSession(sessionDate, sessionWin, sessionScore, sessionValue)
                            
                            if let user = users.first {
                                user.availableBalance += Int(inputAmount)
                                user.level += getLevel(currentCardShowing)
                                
                                let newTransaction = TransactionDataModel(category: "Minigame",amount: Int(inputAmount), transactionDescription: "Higher or Lower Payout", createdAt: Date(), income: true)
                                
                                user.transactions.append(newTransaction)
                                
                                do {
                                    try context.save()
                                } catch {
                                    print("Error when savings Higher or Lower Payout")
                                }
                            }
                            
                        }
                }
                else {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 100, height: 50)
                        .overlay {
                            Text("Try Again")
                                .foregroundStyle(themeManager.mainColor)
                        }
                        .onTapGesture {
                            gameOver = false
                            higherOrLowerConfig.toggle()
                            chosenNums = getNumberArray()
                            currentCardShowing = 0
                            inputAmount = 1
                            isTaskActive = true
                        }
                }
                
                Spacer()
            }
            .frame(width: screenWidth-20)
            .foregroundStyle(themeManager.textColor)
        }
        .onChange(of: dismissEverything, initial: false, { oldValue, newValue in
            if newValue == true {
                dismiss()
            }
        })
        .onAppear {
            isTaskActive.toggle()
            higherOrLowerConfig.toggle()
        }
        .sheet(isPresented: $higherOrLowerConfig) {
            HigherOrLowerConfig(dismissEverything: $dismissEverything, isTaskActive: $isTaskActive, sliderValue: $inputAmount)
                .presentationDetents([.fraction(0.3)])
//                .interactiveDismissDisabled(true)
        }
        .sheet(isPresented: $winner) {
            Text("Congratulations! You Won $\(inputAmount)")
        }
    }
    
    func makeSession(_ sessionDate: Date, _ sessionWin: Bool, _ sessionScore: Int, _ sessionValue: Int){
        print("Ran Function")
        let newSession = MiniGameSessionModel(sessionDate: sessionDate, sessionWin: sessionWin, sessionScore: sessionScore, sessionValue: sessionValue, sessionGame: .HigherOrLower)
        
        if let user = users.first {
            user.miniGameSessions.append(newSession)
        }
        
        do {
            try context.save()
            print("Ran Function, Saved MiniGame Session")
        } catch {
            print("Error: Couldnt save new mini game session")
        }
    }
    
    func getAmount(_ currentScore: Int, _ inputAmount: Double) -> Int {
        switch currentScore {
        case 1:
            return Int(inputAmount * 0.5)
        case 2:
            return Int(inputAmount * 0.6)
        case 3:
            return Int(inputAmount * 0.75)
        default:
            return 0
        }
    }
    
    func getLevel(_ currentScore: Int) -> Int{
        switch currentScore {
        case 1:
            return 1440
        case 2:
            return 2520
        case 3:
            return 3600
        default:
            return 0
        }
    }
}

#Preview {
    HigherOrLower(isTaskActive: .constant(false))
        .environmentObject(ThemeManager())
}
