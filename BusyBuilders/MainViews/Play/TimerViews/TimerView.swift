//
//  TimerView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 02/12/2024.
//

import SwiftUI
import SwiftData

struct TimerView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Query var users : [UserDataModel]
    
    @Binding var isTaskActive : Bool
    
    let possibleUpgrades = ["Cash Booster", "Cost Reduction", "XP Booster"]
    
    @State var selectedBusiness : BusinessDataModel = BusinessDataModel(businessName: "", businessTheme: "", businessType: "", businessIcon: "")
    @State var selectedTime = 1800
    @State var selectedUpgrades: [String] = []
    
    var body: some View {
        if let user = users.first {
            VStack (alignment: .leading, spacing: 15){
                VStack(alignment: .leading, spacing: 2){
                    Text("Select a Business: \(selectedBusiness.businessName)")
                    ScrollView (.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(user.businesses) { b in
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 100, height: 50)
                                    .foregroundStyle(Color.black)
                                    .onTapGesture {
                                        selectedBusiness = b
                                    }
                            }
                        }
                    }
                }
                
                TimeSelect(moveFiveMins: $selectedTime)
                
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
            .frame(width: screenWidth-20, alignment: .leading)
        }
    }
}

#Preview {
    TimerView(isTaskActive: .constant(true))
        .environmentObject(ThemeManager())
}
