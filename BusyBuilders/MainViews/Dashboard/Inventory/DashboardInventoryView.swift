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
    
    let upgradeIcons: [String] = ["banknote", "star", "bag.badge.minus", "mug"]
    let playTokenIcons: [String] = ["arrow.up", "dice", "rectangle.grid.1x2", "grid"]
    let packIcons: [String] = ["suit.heart", "suit.diamond", "suit.club", "suit.spade"]
    let cosmeticsIcons: [String] = ["paintbrush.pointed", "eyedropper", "scribble", "person"]
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            VStack (alignment: .leading, spacing: 5){
                Text("Upgrades")
                    .font(.title3)
                    .opacity(0.7)
                if let user = users.first {
                    HStack {
                        VStack {
                            inventoryItem(itemIcon: upgradeIcons[0], itemName: "Cash Booster", itemAmount: user.inventory["Cash Booster"] ?? 0)
                            inventoryItem(itemIcon: upgradeIcons[2], itemName: "Cost Reduction", itemAmount: user.inventory["Cost Reduction"] ?? 0)
                        }
                        VStack {
                            inventoryItem(itemIcon: upgradeIcons[1], itemName: "XP Booster", itemAmount: user.inventory["Experience Booster"] ?? 0)
                            inventoryItem(itemIcon: upgradeIcons[3], itemName: "Break Booster", itemAmount: user.inventory["Break Booster"] ?? 0)
                        }
                    }
                    .frame(width: screenWidth-20)
                }
            }
            
            VStack (alignment: .leading, spacing: 5){
                Text("Play Tokens")
                    .font(.title3)
                    .opacity(0.7)
                
                HStack {
                    VStack {
                        inventoryItem(itemIcon: playTokenIcons[0], itemName: "Higher or Lower", itemAmount: 10)
                        inventoryItem(itemIcon: playTokenIcons[2], itemName: "Bingo", itemAmount: 6)
                    }
                    VStack {
                        inventoryItem(itemIcon: playTokenIcons[1], itemName: "Slots", itemAmount: 10)
                        inventoryItem(itemIcon: playTokenIcons[3], itemName: "Spin", itemAmount: 6)
                    }
                }
                
            }
            
            VStack (alignment: .leading, spacing: 5){
                Text("Packs")
                    .font(.title3)
                    .opacity(0.7)
                HStack {
                    VStack {
                        inventoryItem(itemIcon: packIcons[0], itemName: "Common", itemAmount: 10)
                        inventoryItem(itemIcon: packIcons[2], itemName: "Rare", itemAmount: 6)
                    }
                    VStack {
                        inventoryItem(itemIcon: packIcons[1], itemName: "Ultra", itemAmount: 10)
                        inventoryItem(itemIcon: packIcons[3], itemName: "Ledgendary", itemAmount: 6)
                    }
                }
                .frame(width: screenWidth-20)
            }
            
            VStack (alignment: .leading, spacing: 5){
                Text("Cosmetics")
                    .font(.title3)
                    .opacity(0.7)
                HStack {
                    VStack {
                        inventoryItem(itemIcon: cosmeticsIcons[0], itemName: "Colors", itemAmount: 10)
                        inventoryItem(itemIcon: cosmeticsIcons[2], itemName: "Cities", itemAmount: 6)
                    }
                    VStack {
                        inventoryItem(itemIcon: cosmeticsIcons[1], itemName: "Buildings", itemAmount: 10)
                        inventoryItem(itemIcon: cosmeticsIcons[3], itemName: "Profile", itemAmount: 6)
                    }
                }
                .frame(width: screenWidth-20)
            }
        }
        .foregroundStyle(themeManager.mainColor)
    }
}

struct inventoryItem: View {
    
    @State var itemIcon: String = "banknote"
    @State var itemName: String = "Cash Booster"
    @State var itemAmount: Int = 10
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: (screenWidth-20)/2, height: 60)
            .foregroundStyle(ThemeManager().mainColor)
            .overlay {
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 40, height: 40)
                        .foregroundStyle(ThemeManager().textColor)
                        .overlay {
                            Image(systemName: "\(itemIcon)")
                                .foregroundStyle(ThemeManager().mainColor)
                        }
                        .padding(.leading, 10)
                    
                    Text(itemName)
                        .font(.system(size: 15))
                        .frame(width: ((screenWidth-20)/2)/2, alignment: .leading)
                    Spacer()
                    
                    Text("\(itemAmount)")
                        .padding(.trailing, 10)
                }
                .foregroundStyle(ThemeManager().textColor)
            }
    }
}

#Preview {
    DashboardInventoryView()
        .environmentObject(ThemeManager())
}
