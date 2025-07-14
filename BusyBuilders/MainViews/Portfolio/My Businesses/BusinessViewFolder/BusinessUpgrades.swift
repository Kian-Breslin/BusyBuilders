//
//  BusinessUpgrades.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 03/06/2025.
//

import SwiftUI
import SwiftData

struct BusinessUpgrades: View {
    @EnvironmentObject var themeManager: ThemeManager
    let business : BusinessDataModel
    @Environment(\.modelContext) var context
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack {
                let departmentOrder = ["Finance", "Operations", "Marketing", "HR", "R&D"]
                ForEach(departmentOrder, id: \.self) { dept in
                    upgradeItem(business: business, deptName: dept)
                }
                
                Button("Reset") {
                    for key in business.departmentLevels.keys {
                        business.departmentLevels[key] = 0
                    }
                    do {
                        try context.save()
                    } catch {
                        print("Failed to reset department levels")
                    }
                }
                .frame(width: 100, height: 40)
                .foregroundStyle(themeManager.mainColor)
                .background(themeManager.textColor)
            }
        }
    }
}

struct upgradeItem: View {
    let business: BusinessDataModel
    let deptName: String
    @Environment(\.modelContext) var context
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth-20, height: 80)
            .foregroundStyle(ThemeManager().textColor)
            .overlay {
                HStack {
                    VStack (alignment: .leading){
                        Text("\(deptName) Dept: ") + Text("\(business.departmentLevels[deptName] ?? 0)").bold()
                        Spacer()
                        Text("Upgrade Cost: $\(calcUpgradePrice(currentLevel: business.departmentLevels[deptName] ?? 0))")
                            .font(.system(size: 20))
                    }
                    Spacer()
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 100, height: 60)
                        .shadow(color: .black, radius: 2)
                        .foregroundStyle(getColor(ThemeManager().secondaryColor))
                        .overlay {
                            Text("Upgrade")
                                .font(.system(size: 20))
                        }
                }
                .font(.system(size: 25))
                .padding(10)
                .foregroundStyle(ThemeManager().mainColor)
            }
            .onTapGesture {
                if business.netWorth >= calcUpgradePrice(currentLevel: business.departmentLevels[deptName] ?? 0) {
                    business.upgradeDept(dept: deptName)
                    print("Upgraded \(deptName)")
                    
                    do {
                        try context.save()
                    }
                    catch {
                        print("Couldnt save upgrading business")
                    }
                }
                else {
                    print("Dont have enough money")
                }
            }
    }
    func calcUpgradePrice(currentLevel: Int) -> Int{
        switch currentLevel {
        case 0..<10:
            return 5000
        case 10..<20:
            return 10000
        case 20..<30:
            return 15000
        default:
            return 0
        }
    }
}

#Preview {
    VStack (spacing: 0){
        Rectangle()
            .frame(width: screenWidth, height: 230)
        
        BusinessUpgrades(business: BusinessDataModel(businessName: "Kians Company", businessTheme: "red", businessType: "Eco-friendly", businessIcon: "controller"))
            .environmentObject(ThemeManager())
        Spacer()
    }
    .ignoresSafeArea()
}
