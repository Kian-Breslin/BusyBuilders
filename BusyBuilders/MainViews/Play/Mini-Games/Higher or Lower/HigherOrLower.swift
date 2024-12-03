//
//  HigherOrLower.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 26/11/2024.
//

import SwiftUI

struct HigherOrLower: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Binding var isTaskActive : Bool
    
    @State var currentCardShowing = 0
    @State var chosenNums = getNumberArray()
    @State var gameOver = false
    @State var inputAmount = 100.0
    @State var winnings = 0
    @State var winner = false
    let endMessages = ["Unlucky!", "Better luck Next time!", "Keep Trying!", "Nearly There!", "Congratulations"]
    @State var higherOrLowerConfig = false
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack (spacing: 50){
                HStack {
                    Text("Higher or Lower")
//                    Text("\(chosenNums)")
                        .font(.largeTitle)
                    Spacer()
                    
                    Image(systemName: "info.circle")
                        .font(.title2)
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
                            }
                    }
                    else  {
                        Text("Congratulations You Won! ")
                            .onAppear {
                                gameOver = true
                                isTaskActive.toggle()
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
                            inputAmount *= 0.5
                            isTaskActive = false
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
            .frame(width: screenWidth-30)
            .foregroundStyle(themeManager.textColor)
        }
        .onAppear {
            isTaskActive.toggle()
        }
        .sheet(isPresented: $higherOrLowerConfig) {
            HigherOrLowerConfig(isTaskActive: $isTaskActive, sliderValue: $inputAmount)
                .presentationDetents([.fraction(0.3)])
                .interactiveDismissDisabled(true)
        }
        .sheet(isPresented: $winner) {
            Text("Congratulations! You Won $\(inputAmount)")
        }
    }
}

#Preview {
    HigherOrLower(isTaskActive: .constant(false))
        .environmentObject(ThemeManager())
}
