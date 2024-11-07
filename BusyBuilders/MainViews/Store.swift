//
//  Store.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 15/10/2024.
//

import SwiftUI
import SwiftData

struct Store: View {
    
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel]
    @AppStorage("userColorPreference") var userColorPreference: String = "red"
    
    let upgrades = availableUpgrades
    @State private var selectedUpgrade = ""
    @State private var growOnAppear = false
    @State private var storeSelection = "Upgrades"
    
    let storeImageSelectionArray: [String] = ["wrench.and.screwdriver", "wand.and.stars", "gift", "tag"]
    let storeSelectionArray: [String] = ["Upgrades", "Cosmetics", "Packs", "Specials"]
    let iconSelectionArray: [String] = ["banknote", "star", "bag.badge.minus", "mug"]
    
    var body: some View {
        ZStack {
            getColor(userColorPreference)
                .ignoresSafeArea()
            
            VStack {
                // Top Section
                headerView
                
                Spacer()
                
                // Store Content
                storeContentView
            }
            .onAppear {
                growOnAppear = true
            }
            .animation(.linear(duration: 0.8), value: growOnAppear)
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 50), trigger: selectedUpgrade)
        }
    }
    
    private var headerView: some View {
        HStack {
            Text("Available Balance: ")
            Text("$\(users.first?.availableBalance ?? 10000)")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .onTapGesture {
                    // Handle tap if needed
                }
        }
        .padding()
    }
    
    private var storeContentView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .frame(width: screenWidth, height: growOnAppear ? screenHeight / 1 : screenHeight / 1.5)
            
            VStack(spacing: 10) {
                storePickerView
                storeDetailView
                Spacer()
            }
            .foregroundColor(getColor(userColorPreference))
        }
        .frame(width: screenWidth, height: (screenHeight-80) / 1.5)
    }
    
    private var storePickerView: some View {
        HStack {
            ForEach(0..<storeSelectionArray.count, id: \.self) { index in
                storePickerButton(for: index)
            }
        }
        .frame(width: screenWidth - 30, height: 110)
    }
    
    private func storePickerButton(for index: Int) -> some View {
        let selection = storeSelectionArray[index]
        return Rectangle()
            .frame(width: 80, height: 80)
            .foregroundColor(storeSelection == selection ? getColor(userColorPreference) : .white)
            .overlay {
                Rectangle()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.white)
                    .overlay {
                        Image(systemName: storeImageSelectionArray[index])
                            .font(.system(size: 35))
                    }
            }
            .onTapGesture {
                storeSelection = selection
            }
    }
    
    private var storeDetailView: some View {
        Group {
            if storeSelection == "Upgrades" {
                upgradesView
            } else if storeSelection == "Cosmetics" {
                Text("Placeholder: Cosmetics")
            } else if storeSelection == "Packs" {
                Text("Placeholder: Packs")
            } else if storeSelection == "Specials" {
                Text("Placeholder: Specials")
            }
        }
    }
    
    private var upgradesView: some View {
        ScrollView {
            ForEach(upgrades.indices, id: \.self) { index in
                upgradeItemView(for: upgrades[index], index: index)
            }
            .padding()
        }
        .padding(.horizontal)
    }
    
    private func upgradeItemView(for upgrade: UpgradesDataModel, index: Int) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth - 30, height: 140)
            .scaleEffect(upgrade.upgradeName == selectedUpgrade ? 1.05 : 1)
            .overlay {
                HStack(spacing: 15) {
                    Image(systemName: iconSelectionArray[index])
                        .font(.system(size: 60))
                    VStack(alignment: .leading, spacing: 5) {
                        Text(upgrade.upgradeName)
                            .font(.system(size: 25))
                            .bold()
                        Text(upgrade.upgradeDescription)
                            .font(.system(size: 12))
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .frame(height: 30)
                        buyButton(for: upgrade)
                    }
                    .frame(width: screenWidth / 2, alignment: .leading)
                }
                .foregroundStyle(.white)
                .padding()
            }
    }
    
    private func buyButton(for upgrade: UpgradesDataModel) -> some View {
        HStack {
            Spacer()
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 110, height: 30)
                .overlay {
                    Text("Buy: \(upgrade.cost)")
                        .foregroundColor(getColor(userColorPreference))
                        .onTapGesture {
                            purchaseUpgrade(upgrade)
                        }
                }
        }
    }
    
    private func purchaseUpgrade(_ upgrade: UpgradesDataModel) {
        selectedUpgrade = upgrade.upgradeName
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation {
                selectedUpgrade = ""
            }
        }
        
        guard let user = users.first else { return }
        
        if user.availableBalance >= upgrade.cost {
            user.inventory[upgrade.upgradeName, default: 0] += 1
            user.availableBalance -= upgrade.cost
            
            print("Purchased: \(upgrade.upgradeName)")
            
            do {
                try context.save()
            } catch {
                print("Failed to save user: \(error.localizedDescription)")
            }
        }
    }
}



#Preview {
    Store()
}
