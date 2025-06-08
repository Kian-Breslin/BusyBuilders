//
//  Inventory.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 20/11/2024.
//

import SwiftUI
import SwiftData

struct DashboardInventoryView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Query var users : [UserDataModel]
    
    var upgradeItems: [item] {
        let user = users.first
        return [
            item(itemIcon: "banknote", itemName: "Cash Booster", itemAmount: user?.inventory["Cash Booster"] ?? 0, itemDescription: "This is a cash booster to use in your sessions"),
            item(itemIcon: "star", itemName: "Cost Reduction", itemAmount: user?.inventory["Cost Reduction"] ?? 0, itemDescription: "This is a cost reduction booster to use in your sessions"),
            item(itemIcon: "bag.badge.minus", itemName: "XP Booster", itemAmount: user?.inventory["XP Booster"] ?? 0, itemDescription: "This is an XP booster to use in your sessions"),
            item(itemIcon: "mug", itemName: "Break Booster", itemAmount: user?.inventory["Break Booster"] ?? 0, itemDescription: "This is a break booster to use in your sessions")
        ]
    }
    
    let upgradeIcons: [String] = ["banknote", "star", "bag.badge.minus", "mug"]
    let packIcons: [String] = ["suit.heart", "suit.diamond", "suit.club", "suit.spade"]
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            VStack (alignment: .leading, spacing: 5){
                Text("Upgrades")
                    .font(.title3)
                    .opacity(0.7)
                if users.first != nil {
                    HStack (alignment: .top){
                        VStack {
                            inventoryItem(item: upgradeItems[0])
                            inventoryItem(item: upgradeItems[1])
                        }
                        VStack {
                            inventoryItem(item: upgradeItems[2])
                            inventoryItem(item: upgradeItems[3])
//                            itemAmount: user.inventory["Break Booster"] ?? 0
                        }
                    }
                    .frame(width: screenWidth-20)
                }
            }
            
            VStack (alignment: .leading, spacing: 5){
                Text("Packs")
                    .font(.title3)
                    .opacity(0.7)
                HStack (alignment: .top){
                    VStack {
                        inventoryItem(item: upgradeItems[0])
                        inventoryItem(item: upgradeItems[1])
                    }
                    VStack {
                        inventoryItem(item: upgradeItems[2])
                        inventoryItem(item: upgradeItems[3])
                    }
                }
                .frame(width: screenWidth-20)
            }
        }
        .foregroundStyle(themeManager.mainColor)
    }
}

struct inventoryItem: View {
    
    @State var item : item
    @State var boxHeight = 60
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: (screenWidth-30)/2, height: CGFloat(boxHeight))
            .foregroundStyle(ThemeManager().mainColor)
            .overlay (alignment: .top){
                VStack {
                    HStack {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 40, height: 40)
                            .foregroundStyle(ThemeManager().textColor)
                            .overlay {
                                Image(systemName: "\(item.itemIcon)")
                                    .foregroundStyle(ThemeManager().mainColor)
                            }
                            .padding(.leading, 10)
                        
                        Text(item.itemName)
                            .font(.system(size: 15))
                            .frame(width: ((screenWidth-20)/2)/2, alignment: .leading)
                        Spacer()
                        
                        Text("\(item.itemAmount)")
                            .padding(.trailing, 10)
                    }
                    .padding(.top, 10)
                    .foregroundStyle(ThemeManager().textColor)
                    
                    VStack{
                        Text("\(item.itemDescription)")
                    }
                    .opacity(boxHeight == 60 ? 0 : 1)
                    .padding(10)
                    .foregroundStyle(ThemeManager().textColor)
                }
            }
            .onTapGesture {
                withAnimation(.bouncy(duration: 1)) {
                    if boxHeight == 60 {
                        boxHeight = 180
                    } else {
                        boxHeight = 60
                    }
                }
            }
    }
}

struct item {
    let itemIcon: String
    let itemName: String
    let itemAmount: Int
    let itemDescription: String
}

#Preview {
    DashboardInventoryView()
        .environmentObject(ThemeManager())
}

#Preview {
    inventoryItem(item: item(itemIcon: "banknote", itemName: "Cashbooster", itemAmount: 8, itemDescription: "Earn extra cash from your session witht this item"))
        .environmentObject(ThemeManager())
}
