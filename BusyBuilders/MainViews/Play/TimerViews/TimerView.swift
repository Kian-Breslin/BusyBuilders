//
//  TimerView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 02/12/2024.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var isTaskActive : Bool
    
    let possibleUpgrades = ["Cash Booster", "Cost Reduction", "XP Booster"]
    
    @State var selectedBusiness = 9999
    @State var selectedTime = 1800.0
    @State var selectedUpgrades: [String] = []
    
    var body: some View {
        VStack (alignment: .leading, spacing: 15){
            VStack(alignment: .leading, spacing: 2){
                Text("Select a Business")
                ScrollView (.horizontal, showsIndicators: false){
                    HStack {
                        ForEach(0..<10) { i in
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 100, height: 50)
                                .foregroundStyle(selectedBusiness == i ? Color.red : Color.black)
                                .onTapGesture {
                                    selectedBusiness = i
                                }
                        }
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 2){
                Text("Select a Time: \(timeFormattedMins(Int(selectedTime)))")
                
                Slider(
                    value: $selectedTime,
                    in: 300...3600,
                    step: 300
                )
                .tint(getColor(themeManager.secondaryColor))
            }
            
            VStack(alignment: .leading, spacing: 2){
                Text("Chose Upgrades")
                
                HStack {
                    ForEach(0..<3){ upgrade in
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 120, height: 50)
                            .opacity(selectedUpgrades.contains(possibleUpgrades[upgrade]) ? 1 : 0.5)
                            .overlay(content: {
                                Text("\(possibleUpgrades[upgrade])")
                                    .font(.system(size: 15))
                                    .foregroundStyle(themeManager.textColor)
                            })
                            .onTapGesture {
                                if selectedUpgrades.contains(possibleUpgrades[upgrade]) {
                                    selectedUpgrades.removeAll(where: { $0 == possibleUpgrades[upgrade] })
                                }
                                else {
                                    selectedUpgrades.append(possibleUpgrades[upgrade])
                                }
                            }
                        
                        if upgrade == 0 || upgrade == 1 {
                            Spacer()
                        }
                    }
                }
            }
            
        }
        .foregroundStyle(themeManager.mainColor)
        .frame(width: screenWidth-30, alignment: .leading)
    }
}

#Preview {
    TimerView(isTaskActive: .constant(true))
        .environmentObject(ThemeManager())
}
