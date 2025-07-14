//
//  AdminTests.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 07/11/2024.
//

import SwiftUI
import SwiftData

struct AdminTests: View {
    
    @Environment(\.modelContext) var context
    @EnvironmentObject var themeManager: ThemeManager
    
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel]
    
    @State var selectedBusiness : BusinessDataModel?
    
    var body: some View {
        ZStack {
            themeManager.mainColor
                .ignoresSafeArea()
            VStack (alignment: .leading, spacing: 10){
                Text("Admin Tests")
                    .font(.system(size: 30))
                
                VStack (alignment: .leading){
                    Text("User Settings")
                        .font(.system(size: 12))
                    
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 150, height: 40)
                        .overlay {
                            Text("Reset User Stats")
                                .foregroundStyle(themeManager.mainColor)
                        }
                        .onTapGesture {
                            resetUserStats()
                        }
                    
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 220, height: 40)
                        .overlay {
                            Text("Delete: \(selectedBusiness?.businessName ?? "None")")
                                .foregroundStyle(themeManager.mainColor)
                        }
                        .onTapGesture {
                            context.delete(selectedBusiness!)
                        }
                }
                VStack (alignment: .leading){
                    Text("Business Settings")
                        .font(.system(size: 12))
                    
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 150, height: 40)
                        .overlay {
                            Text("Add Business")
                                .foregroundStyle(themeManager.mainColor)
                        }
                        .onTapGesture {
                            quickAddBusiness()
                        }
                        
                    ScrollView (.horizontal){
                        HStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 120, height: 40)
                                .foregroundStyle(.teal)
                            
                            if let user = users.first {
                                ForEach(user.businesses, id: \.self) { b in
                                    RoundedRectangle(cornerRadius: 5)
                                        .frame(width: 120, height: 40)
                                        .overlay {
                                            Text("\(b.businessName)")
                                                .foregroundStyle(getColor("\(b.businessTheme)"))
                                        }
                                        .onTapGesture {
                                            selectedBusiness = b
                                        }
                                        .onLongPressGesture {
                                            resetBusinessStats(b)
                                        }
                                }
                            }
                        }
                    }
                }
                VStack (alignment: .leading){
                    Text("Business Details")
                        .font(.system(size: 12))
                    
                    VStack (spacing: 10){
                        HStack {
                            Text("Net Worth: $\(selectedBusiness?.netWorth ?? 5000, specifier: "%.f")")
                            Spacer()
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    
                                }
                            Image(systemName: "minus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    
                                }
                        }
                        
                        HStack {
                            Text("Cash Per Min: $\(selectedBusiness?.cashPerMin ?? 1000)")
                            Spacer()
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    
                                }
                            Image(systemName: "minus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    
                                }
                        }
                        
                        HStack {
                            Text("Cost Per Min: $\(selectedBusiness?.costPerMin ?? 500, specifier: "%.f")")
                            Spacer()
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    
                                }
                            Image(systemName: "minus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                   
                                }
                        }
                        
                        HStack {
                            Text("Investment: $\(selectedBusiness?.investment ?? 10000)")
                            Spacer()
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    selectedBusiness?.investment += 1000
                                }
                            Image(systemName: "minus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    selectedBusiness?.investment -= 1000
                                }
                        }
                        
                        VStack {
                            HStack {
                                Text("Business Level: \(getLevelFromSec(selectedBusiness?.businessLevel ?? 3600))")
                                Spacer()
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 30))
                                    .onTapGesture {
                                        
                                    }
                                Image(systemName: "minus.circle")
                                    .font(.system(size: 30))
                                    .onTapGesture {
                                        if selectedBusiness?.businessLevel ?? 0 > 3600 {
                                        }
                                    }
                            }
                            
                            HStack {
                                Text("Insurance Level: \(getLevelFromSec(selectedBusiness?.insuranceLevel ?? 3600))")
                                Spacer()
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 30))
                                    .onTapGesture {
                                        selectedBusiness?.insuranceLevel += 3600
                                    }
                                Image(systemName: "minus.circle")
                                    .font(.system(size: 30))
                                    .onTapGesture {
                                        if selectedBusiness?.insuranceLevel ?? 0 > 3600 {
                                            selectedBusiness?.insuranceLevel -= 3600
                                        }
                                    }
                            }
                            
                            HStack {
                                Text("Security Level: \(getLevelFromSec(selectedBusiness?.securityLevel ?? 3600))")
                                Spacer()
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 30))
                                    .onTapGesture {
                                        selectedBusiness?.securityLevel += 3600
                                    }
                                Image(systemName: "minus.circle")
                                    .font(.system(size: 30))
                                    .onTapGesture {
                                        if selectedBusiness?.securityLevel ?? 0 > 3600 {
                                            selectedBusiness?.securityLevel -= 3600
                                        }
                                    }
                            }
                        }
                        
                        HStack {
                            Text("Streak: \(selectedBusiness?.streak ?? 10) days")
                            Spacer()
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    selectedBusiness?.streak += 1
                                }
                            Image(systemName: "minus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    selectedBusiness?.streak -= 1
                                }
                        }
                        
                        HStack {
                            Text("Add Quick Session: ")
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 120, height: 40)
                                .foregroundStyle(Color.indigo)
                                .overlay {
                                    Text("Add Session")
                                        .font(.system(size: 15))
                                }
                                .onTapGesture {
                                    addSession()
                                }
                        }
                    }
                    .font(.system(size: 20))
                    .foregroundStyle(themeManager.textColor)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 150, height: 40)
                        .overlay {
                            Text("Save")
                                .foregroundStyle(themeManager.mainColor)
                        }
                }
                
                Spacer()
            }
            .foregroundStyle(themeManager.textColor)
            .frame(width: screenWidth-20, alignment: .leading)
        }
    }
    
    private func addSession() {
        if users.first != nil {
//            let newMockSession = SessionDataModel(id: UUID(), sessionDate: Date.now, businessId: UUID(), totalCashEarned: 0, totalCostIncurred: 0, totalXPEarned: 0, totalStudyTime: 0, productsSnapshot: [])
//            selectedBusiness?.sessionHistory.append(newMockSession)
        }
    }
    
    private func addNetWorth() {
        print("Add $10,000")
        users.first?.availableBalance += 10000
    }
    
    private func resetUserStats() {
        print("Reset User Stats")
        users.first?.availableBalance = 0
        users.first?.inventory = [
            "Cash Booster" : 0,
            "Experience Booster" : 0,
            "Cost Reduction" : 0,
            "Break Booster" : 0
        ]
    }
    
    private func resetBusinessStats(_ business : BusinessDataModel) {
        business.streak = 0
        business.sessionHistory = []
        business.securityLevel = 0
        business.insuranceLevel = 0
        
        do {
            try context.save()
        } catch {
            print("Couldnt Reset Business")
        }
    }
    
    private func quickAddBusiness() {
        print("Quick add Business")
        let newBusiness = BusinessDataModel(
            businessName: "Kians Shop",
            businessTheme: "Blue",
            businessType: "Economic",
            businessIcon: "triangle",
            owners: [UserDataModel(username: "Kian_17", name: "Kian", email: "Kianbreslin@gmail.com")],
            investors: [
                UserDataModel(username: "Kimberly_01", name: "Kim", email: "KimberlyLeon@gmail.com"),
                UserDataModel(username: "Jack_00", name: "Jack", email: "JackJake@gmail.com"),
                UserDataModel(username: "Jay_09", name: "Jay", email: "JayYo@gmail.com")
            ],
            badges: ["10 Days Streak", "$1000 Earned", "First Upgrade", "", "", "", "", "", "", "",],
            sessionHistory: [],
            businessPrestige: "Growing Business")
        
        context.insert(newBusiness)
        
        do {
            try context.save()
            print("Made Placeholder Business")
        } catch {
            print("Failed to save new business: \(error)")
        }
    }
}

#Preview {
    AdminTests()
        .modelContainer(for: UserDataModel.self)
        .environmentObject(ThemeManager())
}
