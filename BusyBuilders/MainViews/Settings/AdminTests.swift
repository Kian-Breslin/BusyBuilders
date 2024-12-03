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
                        .frame(width: 180, height: 40)
                        .overlay {
                            Text("Add NetWorth")
                                .foregroundStyle(themeManager.mainColor)
                        }
                        .onTapGesture {
                            addNetWorth()
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
                                .frame(width: 40, height: 40)
                                .overlay {
                                    Image(systemName: "flag")
                                        .foregroundStyle(getColor("blue"))
                                }
                            
                            ForEach(businesses, id: \.self) { b in
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 40, height: 40)
                                    .overlay {
                                        Image(systemName: "\(b.businessIcon)")
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
                                    selectedBusiness?.netWorth += 100
                                }
                            Image(systemName: "minus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    selectedBusiness?.netWorth -= 100
                                }
                        }
                        
                        HStack {
                            Text("Cash Per Min: $\(selectedBusiness?.cashPerMin ?? 1000)")
                            Spacer()
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    selectedBusiness?.cashPerMin += 100
                                }
                            Image(systemName: "minus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    selectedBusiness?.cashPerMin -= 100
                                }
                        }
                        
                        HStack {
                            Text("Cost Per Min: $\(selectedBusiness?.costPerMin ?? 500, specifier: "%.f")")
                            Spacer()
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    selectedBusiness?.costPerMin += 100
                                }
                            Image(systemName: "minus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    selectedBusiness?.costPerMin -= 100
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
                                        selectedBusiness?.businessLevel += 3600
                                    }
                                Image(systemName: "minus.circle")
                                    .font(.system(size: 30))
                                    .onTapGesture {
                                        if selectedBusiness?.businessLevel ?? 0 > 3600 {
                                            selectedBusiness?.businessLevel -= 3600
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
                            Text("Leaderboard Position: \(selectedBusiness?.leaderboardPosition ?? 10)")
                            Spacer()
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    selectedBusiness?.leaderboardPosition += 1
                                }
                            Image(systemName: "minus.circle")
                                .font(.system(size: 30))
                                .onTapGesture {
                                    selectedBusiness?.leaderboardPosition -= 1
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
            .frame(width: screenWidth-30, alignment: .leading)
        }
    }
    
    private func addNetWorth() {
        print("Add $10,000")
        users.first?.netWorth += 10000
    }
    
    // Functions
    private func resetUserStats() {
        print("Reset User Stats")
        users.first?.netWorth = 0
        users.first?.availableBalance = 0
        users.first?.inventory = [
            "Cash Booster" : 0,
            "Experience Booster" : 0,
            "Cost Reduction" : 0,
            "Break Booster" : 0
        ]
    }
    
    private func resetBusinessStats(_ business : BusinessDataModel) {
        business.netWorth = 0
        business.businessLevel = 0
        business.cashPerMin = 1000
        business.costPerMin = 500
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
            cashPerMin: 3000,
            netWorth: 6000,
            investors: [
                UserDataModel(username: "Kimberly_01", name: "Kim", email: "KimberlyLeon@gmail.com"),
                UserDataModel(username: "Jack_00", name: "Jack", email: "JackJake@gmail.com"),
                UserDataModel(username: "Jay_09", name: "Jay", email: "JayYo@gmail.com")
            ],
            badges: ["10 Days Streak", "$1000 Earned", "First Upgrade", "", "", "", "", "", "", "",],
            sessionHistory:
                [SessionDataModel(
                    id: UUID(),
                    sessionDate: Date.now,
                    sessionStart: formatFullDateTime(date: Date()),
                    sessionEnd: formatFullDateTime(date: Date()),
                    businessId: UUID(), totalStudyTime: 3600),
                 SessionDataModel(
                     id: UUID(),
                     sessionDate: Date.now,
                     sessionStart: formatFullDateTime(date: Date()),
                     sessionEnd: formatFullDateTime(date: Date()),
                     businessId: UUID(), totalStudyTime: 3600)
                ],
            businessLevel: 7200,
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
