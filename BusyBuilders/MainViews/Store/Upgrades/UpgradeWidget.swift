//
//  UpgradeWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/11/2024.
//

import SwiftUI
import SwiftData

struct UpgradeWidget: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Query var users : [UserDataModel]
    
    @State var Upgrade : UpgradesDataModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: (screenWidth-30)/2, height: 200)
            .foregroundStyle(themeManager.mainColor)
            .overlay {
                VStack (alignment: .leading){
                    HStack {
                        Image(systemName: "\(imageForUpgrade(Upgrade.effect))")
                            .font(.system(size: 50))
                        VStack (alignment: .leading){
                            Text("$\(Upgrade.cost)")
                                .font(.system(size: 20))
                                .kerning(1)
                                .bold()
                            
                            Text("\((amountOfUpgrade(Upgrade.effect))*100, specifier: "%.f")%")
                                .font(.system(size: 20))
                        }
                    }
                    .padding(.bottom, 5)
                    Text("\(Upgrade.upgradeName)")
                        .font(.system(size: 15))
                        .bold()
                    Text("\(Upgrade.upgradeDescription)")
                        .font(.system(size: 12))
                    Spacer()
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: (screenWidth-60)/2, height: 35)
                        .overlay {
                            HStack {
                                Image(systemName: "cart")
                                Text("BUY")
                            }
                            .font(.system(size: 20))
                            .foregroundStyle(themeManager.mainColor)
                        }
                        .onTapGesture {
                            print("\(Upgrade.upgradeName)")
                            if let user = users.first {
                                if user.availableBalance >= Upgrade.cost {
                                    user.inventory[Upgrade.upgradeName]! += 1
                                    user.availableBalance -= Upgrade.cost
                                    print("Bought : \(Upgrade.upgradeName)")
                                    let newTransacion = TransactionDataModel(image: "wrench.and.screwdriver", name: Upgrade.upgradeName, amount: Upgrade.cost, transactionDescription: "", createdAt: Date(), income: false)
                                    user.bankAccount?.transactions.append(newTransacion)
                                    print("Added \(Upgrade.upgradeName) transaction to bank.")
                                }
                                else {
                                    print("No no monies")
                                }
                            }
                            else {
                                print("Couldnt Buy : \(Upgrade.upgradeName)")
                            }
                        }
                }
                .foregroundStyle(themeManager.textColor)
                .padding(10)
            }
    }
    
    public func imageForUpgrade(_ effect : EffectType) -> String {
        
        let cashPerMinIncrease = effect.cashPerMinIncrease
        let costReduction = effect.costReduction
        let xpBoost = effect.xpBoost
        let breakBooster = effect.breakBooster
        
        if cashPerMinIncrease != nil {
            return "triangle"
        }
        
        if costReduction != nil {
            return "circle"
        }
        
        if xpBoost != nil {
            return "square"
        }
        
        if breakBooster != nil {
            return "hexagon"
        }
        
        return "N/A"
    }
    public func amountOfUpgrade(_ effect : EffectType) -> Double {
        
        let cashPerMinIncrease = effect.cashPerMinIncrease
        let costReduction = effect.costReduction
        let xpBoost = effect.xpBoost
        let breakBooster = effect.breakBooster
        
        if cashPerMinIncrease != nil {
            return cashPerMinIncrease!
        }
        
        if costReduction != nil {
            return costReduction!
        }
        
        if xpBoost != nil {
            return xpBoost!
        }
        
        if breakBooster != nil {
            return breakBooster!
        }
        
        return 0.0
    }
}

#Preview {
    UpgradeWidget(Upgrade: UpgradesDataModel(upgradeName: "Cash Booster", upgradeDescription: "This is a cash booster that will multiply your earnings by 5%", cost: 10000, effect: EffectType(cashPerMinIncrease: 0.05), levelRequired: 1))
        .environmentObject(ThemeManager())
}


//upgradeName: "Cash Booster",
//upgradeDescription: "This is a cash booster that will multiply your earnings by 5%",
//cost: 10000,
//effect: EffectType(cashPerMinIncrease: 0.05),
//levelRequired: 1
