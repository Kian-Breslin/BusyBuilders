//
//  TopNavigation.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import SwiftData

struct TopNavigation: View {
    @Environment(\.modelContext) var context
    @Query var users : [UserDataModel]
    @EnvironmentObject var userManager: UserManager
    
    @State var title: String
    @State var iconNames: [String]
    @State var iconLabels: [String]
    @Binding var selectedIcon: String
    
    var body: some View {
        VStack (spacing: 30){
            HStack {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                Spacer()
                HStack {
                    Image(systemName: "bell.fill")
                        .font(.title2)
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 40, height: 40)
                        .foregroundStyle(userManager.secondaryColor)
                        .overlay(content: {
                            if users.first != nil {
                                Circle()
                                    .fill(.green)
                                    .frame(width: 20, height: 20)
                                    .onTapGesture {
                                        userManager.showSettings.toggle()
                                    }
                            } else {
                                Circle()
                                    .fill(.red)
                                    .frame(width: 20, height: 20)
                                    .onTapGesture {
                                        let newUser = UserDataModel(id: UUID(), username: "Keano317", name: "Kian", email: "kianbreslin@gmail.com", password: "Password", netWorth: 0, availableBalance: 0, friends: [], business: [], tokens: 0, sessionHistory: [], userLevel: 0, badges: [], inventory: [])
                                        context.insert(newUser)
                                        do {
                                            try context.save()
                                        } catch {
                                            print("Cannot save user: \(error)")
                                        }
                                        
                                    }
                            }
                        })
                }
            }
            
            HStack {
                TopNavIcon(icon: iconNames[0], textValue: iconLabels[0], selectedIcon: $selectedIcon)
                Spacer()
                TopNavIcon(icon: iconNames[1], textValue: iconLabels[1], selectedIcon: $selectedIcon)
                Spacer()
                TopNavIcon(icon: iconNames[2], textValue: iconLabels[2], selectedIcon: $selectedIcon)
                Spacer()
                TopNavIcon(icon: iconNames[3], textValue: iconLabels[3], selectedIcon: $selectedIcon)
            }
        }
        .padding(10)
        .frame(height: 160)
        .background(userManager.mainColor)
        .foregroundStyle(userManager.textColor)
    }
}

struct TopNavIcon: View {
    @EnvironmentObject var userManager: UserManager
    @State var icon: String
    @State var textValue: String
    @Binding var selectedIcon: String
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 60, height: 60)
                .foregroundStyle(userManager.secondaryColor)
                .overlay {
                    Image(systemName: "\(selectedIcon == icon ? "\(icon).fill" : "\(icon)")")
                        .font(.title)
                }
            Text(textValue)
                .font(.caption)
        }
        .foregroundColor(UserManager().textColor)
        .frame(maxWidth: 60)
        .onTapGesture {
            selectedIcon = icon
        }
    }
}

#Preview {
    TopNavigation(title: "Dashboard", iconNames: ["house", "banknote", "newspaper", ""], iconLabels: ["Home", "Bank", "News", ""], selectedIcon: .constant("house"))
        .environmentObject(UserManager())
}
