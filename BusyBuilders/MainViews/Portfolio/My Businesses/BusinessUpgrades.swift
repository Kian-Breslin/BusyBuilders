//
//  BusinessUpgrades.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 13/02/2025.
//

import SwiftUI
import SwiftData

struct BusinessUpgrades: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Query var users : [UserDataModel]
    @State var business : BusinessDataModel
    
    let iconArray = ["book", "moon", "microphone", "paintbrush", "tv", "person.3", "creditcard", "music.note.house", "briefcase", "cart", "signature", "star", "checkmark.seal", "flame", "tag"]
    
    let businessUpgrades = allBusinessUpgrades
    
    @State var canPurchase = 0
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack (spacing: 20){
                VStack {
                    HStack {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 25))
                            .foregroundStyle(.white)
                            .onTapGesture {
                                dismiss()
                            }
                        Spacer()
                        Text("\(business.businessName)")
                            .font(.system(size: 25))
                            .onTapGesture {
                                for upgrade in business.upgrades {
                                    print(upgrade.upgradeName)
                                }
                            }
                        Spacer()
                        Image(systemName: "arrow.left")
                            .font(.system(size: 25))
                            .foregroundStyle(themeManager.mainColor)
                    }
                    .frame(width: screenWidth-20)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: screenWidth-20, height: 80)
                        .foregroundStyle(getColor(themeManager.mainDark))
                        .overlay {
                            VStack (alignment: .leading){
                                Text("Level: ") + Text("\(getLevelFromSec(business.businessLevel))").bold().font(.system(size: 20))
                                if let user = users.first {
                                    Text("Available Balance: ") + Text("\(user.availableBalance)")
                                } else {
                                    Text("Availabale Balance: ") + Text("$100,000").bold().font(.system(size: 20))
                                }
                            }
                            .frame(width: screenWidth-40, alignment: .leading)
                        }
                }
                
                VStack (alignment: .leading, spacing: 40){
                    HStack (alignment: .center, spacing: 10){
                        UpgradeBox(upgrade: businessUpgrades[0], business: business)
                        UpgradeBoxJoiner()
                        UpgradeBox(upgrade: businessUpgrades[1], business: business)
                        UpgradeBoxJoiner()
                        UpgradeBox(upgrade: businessUpgrades[2], business: business)
                        UpgradeBoxCornerJoinerRight()
                    }
                    HStack (alignment: .center, spacing: 10){
                        UpgradeBoxCornerJoinerLeft()
                        UpgradeBox(upgrade: businessUpgrades[5], business: business)
                        UpgradeBoxJoiner()
                        UpgradeBox(upgrade: businessUpgrades[4], business: business)
                        UpgradeBoxJoiner()
                        UpgradeBox(upgrade: businessUpgrades[3], business: business)
                    }
                    .padding(.leading, 10)
                    HStack (alignment: .center, spacing: 10){
                        UpgradeBox(upgrade: businessUpgrades[6], business: business)
                        UpgradeBoxJoiner()
                        UpgradeBox(upgrade: businessUpgrades[7], business: business)
                        UpgradeBoxJoiner()
                        UpgradeBox(upgrade: businessUpgrades[8], business: business)
                        UpgradeBoxCornerJoinerRight()
                    }
                    HStack (alignment: .center, spacing: 10){
                        UpgradeBoxCornerJoinerLeft()
                        UpgradeBox(upgrade: businessUpgrades[11], business: business)
                        UpgradeBoxJoiner()
                        UpgradeBox(upgrade: businessUpgrades[10], business: business)
                        UpgradeBoxJoiner()
                        UpgradeBox(upgrade: businessUpgrades[9], business: business)
                    }
                    .padding(.leading, 10)
                    HStack (alignment: .center, spacing: 10){
                        UpgradeBox(upgrade: businessUpgrades[12], business: business)
                        UpgradeBoxJoiner()
                        UpgradeBox(upgrade: businessUpgrades[13], business: business)
                        UpgradeBoxJoiner()
                        UpgradeBox(upgrade: businessUpgrades[14], business: business)
                    }
                }
                .frame(width: screenWidth-20, alignment: .leading)
                Spacer()
            }
            .foregroundStyle(themeManager.textColor)
        }
    }
}

struct UpgradeBox: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.modelContext) var context
    @Query var users : [UserDataModel]
    let upgrade : BusinessUpgradeModel
    @State var business: BusinessDataModel!
    
    @State var isUpgradeInTheBusiness = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 50, height: 50)
            .foregroundStyle(Color.testColor)
            .shadow(color: .black, radius: 5, x: 3, y: 3)
            .overlay {
                if business.upgrades.contains(upgrade) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 50, height: 50)
                        .foregroundStyle(.black)
                        .opacity(0.5)
                }
                
                Image(systemName: "\(upgrade.upgradeIcon)")
                    .foregroundStyle(themeManager.mainColor)
                    .font(.system(size: 25))
            }
            .onTapGesture {
                if let user = users.first {
                    if business.businessLevel >= upgrade.upgradeRequiredLevel && user.availableBalance >= upgrade.upgradePrice && business.upgrades.contains(upgrade) == false {
                        
                        business.upgrades.append(upgrade)
                        print("Successfully bought \(upgrade.upgradeName) for \(upgrade.upgradePrice)")
                        user.availableBalance -= upgrade.upgradePrice
                        
                        do {
                            try context.save()
                        } catch {
                            print("Couldnt save upgrade to business")
                        }
                        
                    } else {
                        print("Cannot Get upgrade : Level is too low")
                    }
                } else {
                    print("Couldnt get business upgrade : No User found")
                }
            }
            .onLongPressGesture {
//                business.upgrades.removeAll{$0 == upgrade}
//                print("Removed : \(upgrade.upgradeName)")
                business.upgrades.removeAll()
            }
    }
}
struct UpgradeBoxJoiner: View {
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 50, height: 2)
            .foregroundStyle(themeManager.textColor)
    }
}
struct UpgradeBoxCornerJoinerRight: View {
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 50, height: 2)
            .foregroundStyle(themeManager.textColor)
        
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 2, height: 50)
            .foregroundStyle(themeManager.textColor)
            .offset(x: -12, y: 25)
        
    }
}
struct UpgradeBoxCornerJoinerLeft: View {
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 2, height: 50)
            .foregroundStyle(themeManager.textColor)
            .offset(x: 12, y: 25)
        
        RoundedRectangle(cornerRadius: 5)
            .frame(width: 50, height: 2)
            .foregroundStyle(themeManager.textColor)
    }
}


#Preview {
    BusinessUpgrades(business: BusinessDataModel(businessName: "Kians Coffee Shop", businessTheme: "blue", businessType: "Eco-Firendly", businessIcon: "pentagon", upgrades: [], businessLevel: 45000))
        .environmentObject(ThemeManager())
}
