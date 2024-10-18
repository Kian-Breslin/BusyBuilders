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
    @Query var businesses: [BusinessDataModel] // Query for businesses
    
    // Animate buy
    @State private var isScaled = false
    
    var body: some View {
        VStack {
            Text("Business Upgrades")
                .font(.system(size: 40))
            
            VStack (alignment: .leading){
                Text("$\(users.first?.availableBalance ?? 1)")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                Text("Total Available Balance")
            }
            
            ScrollView (.horizontal) {
                HStack (spacing: 20){
                    ForEach(availableUpgrades.indices, id: \.self){ u in
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: screenWidth-30, height: 200)
                                .foregroundStyle(.gray)
                                .overlay {
                                    VStack (alignment: .leading, spacing: 10){
                                        Text(availableUpgrades[u].upgradeName)
                                            .font(.title)
                                            .bold()
                                        Text(availableUpgrades[u].upgradeDescription)
                                            .font(.system(size: 15))
                                        Text("$\(availableUpgrades[u].cost)")
                                        Text("Level Required: \(availableUpgrades[u].levelRequired)")
                                    }
                                    .padding(10)
                                    .foregroundStyle(.white)
                                    .onTapGesture {
                                        print(availableUpgrades[u].upgradeName)
                                        withAnimation {
                                            isScaled = true // Scale up
                                        }
                                        // After a short delay, scale down
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            withAnimation {
                                                isScaled = false // Scale back down
                                            }
                                        }
                                        if let user = users.first {
                                            user.inventory["\(availableUpgrades[u].upgradeName)", default: 0] += 1
                                            user.availableBalance -= availableUpgrades[u].cost
                                        }
                                        do {
                                            try context.save()
                                        }
                                        catch {
                                            print("Failed to save user: \(error.localizedDescription)")
                                        }
                                    }
                                    .animation(.easeInOut(duration: 0.2), value: isScaled)
                                    .scaleEffect(isScaled ? 1.2 : 1.0)
                                }
                        }
                        .containerRelativeFrame(.horizontal, count: 1, spacing: 14)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }
}


#Preview {
    Store()
}
