//
//  SlotTest.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 03/12/2024.
//

import SwiftUI

struct SlotMachine: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Binding var isGameActive : Bool
    
    @State var hasRolled = false
    @State var arrayItems = getRandomToolsArray()
    @State var rolled = false
    @State var winningImages : [String] = []
    @State var offsetValue = -205
    
    @State var totalNetWorth = 100000.0
    @State var selectedAmount = 0.0
    @State var gameCounter = 0
    @State var winCounter = 0
    
    
    
    var body: some View {
        VStack (spacing: 25){
            
            HStack {
                Text("$\(totalNetWorth, specifier: "%.f")")
                    .font(.largeTitle)
                    .foregroundStyle(themeManager.textColor)
                
                if hasRolled && winningImages.isEmpty == false {
                    // Logic Check
                    if winningImages[0] == winningImages[1] && winningImages[0] == winningImages[2]{
                        Text("+ $\((selectedAmount*(calculateReward(for: winningImages)))+selectedAmount, specifier: "%.f")")
                            .onAppear {
                                newSum(Int(calculateReward(for: winningImages)))
                                gameCounter += 1
                                winCounter += 1
                                print("\(winCounter) / \(gameCounter)")
                                print("\(calculateReward(for: winningImages))")
                                isGameActive = false
                            }
                    }
                    else {
                        Text("- $\(selectedAmount, specifier: "%.f")")
                            .onAppear {
                                gameCounter += 1
                                print("\(winCounter) / \(gameCounter)")
                                isGameActive = false
                            }
                    }
                }
                else {
                    Text("$\(selectedAmount, specifier: "%.f")")
                }
            }
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: screenWidth-30, height: 200)
                .foregroundStyle(themeManager.textColor)
                .overlay {
                    HStack {
                        slotTest1(rolled: $rolled, winningImages: $winningImages, offsetValue: $offsetValue)
                            .animation(.easeOut(duration: 1), value: rolled)
                        
                        slotTest1(rolled: $rolled, winningImages: $winningImages, offsetValue: $offsetValue)
                            .animation(.easeOut(duration: 1.5), value: rolled)
                        
                        slotTest1(rolled: $rolled, winningImages: $winningImages, offsetValue: $offsetValue)
                            .animation(.easeOut(duration: 2), value: rolled)
                    }
                }
                .clipped()
            
            if hasRolled == false {
                VStack(alignment: .leading, spacing: 15){
                    Text("Select an amount: $\(selectedAmount, specifier: "%.f")")
                    
                    Slider(
                        value: $selectedAmount,
                        in: 0...totalNetWorth,
                        step: 500
                    )
                    .tint(getColor(themeManager.secondaryColor))
                }
                .frame(width: screenWidth-30, height: 100)
            }
            else {
                Text("\(selectedAmount, specifier: "%.f")")
                    .font(.largeTitle)
                    .frame(width: screenWidth-30, height: 100)
            }
            
            if hasRolled == false {
                Button("Roll") {
                    totalNetWorth = totalNetWorth - selectedAmount
                    offsetValue = 205
                    winningImages.removeAll()
                    rolled.toggle()
                    hasRolled = true
                    isGameActive = true
                }
                .frame(width: 100, height: 50)
                .foregroundStyle(themeManager.mainColor)
                .background(themeManager.textColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.title)
            }
            else {
                Button("Try Again") {
                    offsetValue = -205
                    hasRolled = false
                    isGameActive = true
                }
                .frame(width: 100, height: 50)
                .foregroundStyle(themeManager.mainColor)
                .background(themeManager.textColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.title3)
            }
        }
        .animation(.linear, value: hasRolled)
        .onAppear {
            hasRolled = false
//            runSimulation()
        }
    }
    
    func runSimulation() {
        var screwdriverWins = 0
        var wrenchWins = 0
        var hammerWins = 0
        var starWins = 0
        var noWins = 0

        for _ in 1...100000 {
            let tools = getRandomToolsArray().prefix(3)
            let rewardMultiplier = calculateReward(for: Array(tools))

            if rewardMultiplier > 0 {
                switch tools[0] {
                case "screwdriver": screwdriverWins += 1
                case "wrench.adjustable": wrenchWins += 1
                case "hammer": hammerWins += 1
                case "star": starWins += 1
                default: break
                }
            } else {
                noWins += 1
            }
        }

        print("""
        Simulation Results (100000 runs):
        Screwdriver Wins: \(screwdriverWins)
        Screwdriver %: \((Double(screwdriverWins)/100000.0)*100)%
        Wrench Wins: \(wrenchWins)
        Wrench %: \((Double(wrenchWins)/100000.0)*100)%
        Hammer Wins: \(hammerWins)
        Star %: \((Double(hammerWins)/100000.0)*100)%
        Star Wins: \(starWins)
        Star %: \((Double(starWins)/100000.0)*100)%
        No Wins: \(noWins)
        Total Wins: \(screwdriverWins + wrenchWins + hammerWins + starWins)
        Win Rate: \((Double(screwdriverWins + wrenchWins + hammerWins + starWins) / 100000.0) * 100.0)%
        """)
    }
    
    func calculateReward(for tools: [String]) -> Double {
//        print("Tools: \(tools)") // Debugging
        
        if tools[0] == tools[1] && tools[0] == tools[2] {
            switch tools[0] {
            case "screwdriver":
                return 1.0
            case "wrench.adjustable":
                return 5.0
            case "hammer":
                return 10.0
            case "star":
                return 10000.0
            default:
                return 0.0
            }
        }
        return 0.0
    }
    
    func newSum(_ multiplier: Int) {
        let reward = (selectedAmount * Double(multiplier)) + selectedAmount
        totalNetWorth += reward
        print("Multiplier: \(multiplier), Bet: \(selectedAmount), Reward: \(reward), Total Net Worth: \(totalNetWorth)")
    }
}


struct slotTest1: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Binding var rolled: Bool
    @Binding var winningImages: [String]
    @Binding var offsetValue: Int
    @State var itemList = getRandomToolsArray()
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 100, height: 170)
            .foregroundStyle(themeManager.mainColor)
            .overlay {
                VStack {
                    ForEach(0..<10){ i in
                        Image(systemName: "\(itemList[i])")
                            .foregroundStyle(themeManager.textColor)
                            .font(.system(size: 30))
                            .frame(width: 40, height: 40)
                            .padding(5)
                    }
                    .offset(y: CGFloat(offsetValue))
                }
            }
            .onChange(of: rolled){
                itemList = getRandomToolsArray()
                winningImages.append(itemList[1])
            }
    }
}

#Preview {
    SlotMachine(isGameActive: .constant(true))
        .environmentObject(ThemeManager())
}
