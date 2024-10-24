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
    @AppStorage("userColorPreference") var userColorPreference: String = "red"
    
    // Buy
    let Upgrades = availableUpgrades
    @State private var isScaled = false
    
    // Store Selection
    @State var storeSelection = "Upgrades"
    @State var storeSelectionArray : [String] = ["Upgrades", "Cosmetics", "Packs"]
    
    var body: some View {
        ZStack {
            
            getColor(userColorPreference)
                .ignoresSafeArea()
            
            // Top Section
            VStack {
                VStack {
                    // Top Header
                    HStack {
                        VStack (alignment: .leading){
                            Text("$\(users.first?.availableBalance ?? 1)")
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .onTapGesture {
                                    
                                }
                            HStack (spacing: 35){
                                Text("Available Balance")
                            }
                        }
                        Spacer()
                        HStack (spacing: 15){
                            ZStack {
                                Image(systemName: "bell.fill")
                                Image(systemName: "2.circle.fill")
                                    .font(.system(size: 15))
                                    .offset(x: 10, y: -10)
                            }
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 40, height: 40)
                                .onTapGesture {
                                    
                                    
                                }
                        }
                        .font(.system(size: 25))
                    }
                    .padding(15)
                    
                    HStack {
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 60, height: 60)
                                .overlay {
                                    Image(systemName: "dollarsign")
                                        .font(.system(size: 30))
                                        .foregroundStyle(getColor(userColorPreference))
                                }
                                .onTapGesture {
                                    
                                }
                            Text("Send Money")
                        }
                        Spacer()
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 60, height: 60)
                                .overlay {
                                    Image(systemName: "plus")
                                        .font(.system(size: 30))
                                        .foregroundStyle(getColor(userColorPreference))
                                }
                                .onTapGesture {
                                    
                                }
                            Text("Modifiers")
                        }
                        Spacer()
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 60, height: 60)
                                .overlay {
                                    Image(systemName: "menucard")
                                        .font(.system(size: 30))
                                        .foregroundStyle(getColor(userColorPreference))
                                }
                                .onTapGesture {
                                    
                                }
                            Text("Flash Cards")
                        }
                        Spacer()
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 60, height: 60)
                                .overlay {
                                    Image(systemName: "info")
                                        .font(.system(size: 30))
                                        .foregroundStyle(getColor(userColorPreference))
                                }
                                .onTapGesture {
                                    
                                }
                            Text("More Info")
                        }
                    }
                    .padding(.horizontal, 15)
                    .font(.system(size: 12))
                }
                
                Spacer()
                
                // White Background
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: screenWidth, height: screenHeight/1.5)
                        .foregroundStyle(.white)
                    
                    VStack (spacing: 10){
                        Text("Store")
                            .font(.system(size: 40))
                            .frame(width: screenWidth-30, alignment: .leading)
                            .padding(.top)
                        
                        //Picker
                        HStack {
                            ForEach(0..<3){ store in
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: (screenWidth-30)/3, height: 40)
                                    .foregroundStyle(getColor(userColorPreference))
                                    .opacity(storeSelection == storeSelectionArray[store] ?  1 : 0.5)
                                    .overlay {
                                        Text(storeSelectionArray[store])
                                            .foregroundStyle(.white)
                                    }
                                    .onTapGesture {
                                        storeSelection = storeSelectionArray[store]
                                    }
                            }
                        }
                        .frame(width: screenWidth-30, height: 80)
                        .foregroundStyle(getColor(userColorPreference))
                        
                        Divider()
                            .padding()
                        
                        // Type of Store
                        if storeSelection == "Upgrades" {
                            VStack {
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                                    ForEach(0..<4){ item in
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: (screenWidth-40)/2, height: 150)
                                            .overlay {
                                                Text("\(Upgrades[item].upgradeName)")
                                                    .foregroundStyle(.white)
                                            }
                                            .onTapGesture {
                                                print(Upgrades[item].upgradeName)
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
                                                    user.inventory["\(Upgrades[item].upgradeName)", default: 0] += 1
                                                    user.availableBalance -= Upgrades[item].cost
                                                }
                                                do {
                                                    try context.save()
                                                }
                                                catch {
                                                    print("Failed to save user: \(error.localizedDescription)")
                                                }
                                            }
                                            .animation(.easeInOut(duration: 0.2), value: isScaled)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        else if storeSelection == "Cosmetics" {
                            
                        }
                        else if storeSelection == "Packs" {
                            
                        }
                        
                        Spacer()
                    }
                    .foregroundStyle(getColor(userColorPreference))
                }
                .frame(width: screenWidth, height: screenHeight/1.5)
            }
        }
    }
}




#Preview {
    Store()
}
