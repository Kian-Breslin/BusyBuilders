//
//  StartTask.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/09/2024.
//

import SwiftUI
import SwiftData

struct StartTask: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("userColorPreference") var userColorPreference: String = "red"
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel]
    @State var currentView = 0
    let Upgrades = availableUpgrades
    
    // Show Inventory
    @State var placeholderSheet = false
    @State var showInventory = "Inventory"
    @State var showInventoryMoney = 0.0
    
    // Show Warning - No "Modifiers" Available
    @State var isWarningShowing = false
    @State var warningErrorMessage = ""
    
    @State var selectedBusiness: BusinessDataModel?
    @State var businessName: String = ""
    
    // Timer
    @State var timeSeconds = 0
    @State var timeRemaining = 0
    @Binding var isTimerActive : Bool
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Final Calculations
    @State var timeElapsed = 0
    @State var totalCashEarned: Double = 0.0
    @State var experienceEarned = 0
    @State var timeStarted = ""
    @State var timeEnded = ""
    
    // Modifiers
    @State var isCashBoosterActive = false
    @State var isCostReductionActive = false
    @State var isXPBoosterActive = false
    
    // Dev Tests
    let devNames = ["Math Masters","Eco Innovators","Science Solutions","Code Creators","Design Depot","Robotics Realm","Tech Repair Hub","Game Forge","AI Insights","Physics Powerhouse"]

    var body: some View {
        if (currentView == 1) {
            // Active Task View
            ZStack {
                getColor(userColorPreference)
                    .ignoresSafeArea()
                
                Timer1(currentView: $currentView, selectedBusiness: $selectedBusiness, timeRemaining: $timeRemaining, timeElapsed: $timeElapsed, isTimerActive: $isTimerActive, timeStarted: $timeStarted, totalCashEarned: $totalCashEarned, cashBoosterActive: isCashBoosterActive, costReductionActive: isCostReductionActive, XPBoosterActive: isXPBoosterActive)
            }
        }
        else if (currentView == 2) {
            // Post Task View
            PostTask(currentView: $currentView, totalCashEarned: totalCashEarned)
        }
        else {
            // Start Task View
            ZStack {
                getColor(userColorPreference)
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        // Top Header
                        HStack {
                            VStack (alignment: .leading){
                                Text("Play")
                                    .font(.system(size: 35))
                                    .fontWeight(.bold)
                            }
                            .onTapGesture {
                                
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
                        .frame(width: screenWidth-30, height: 80)
                        
                        HStack {
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 60, height: 60)
                                    .overlay {
                                        Image(systemName: "\(isXPBoosterActive ? "star.fill" : "star")")
                                            .font(.system(size: 30))
                                            .foregroundStyle(getColor(userColorPreference))
                                    }
                                    .onTapGesture {
                                        isXPBoosterActive.toggle()
                                    }
                                Text("XP Booster")
                            }
                            .frame(width: 60, height: 80)
                            Spacer()
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 60, height: 60)
                                    .overlay {
                                        Image(systemName: "\(isCashBoosterActive ? "banknote.fill" : "banknote")")
                                            .font(.system(size: 30))
                                            .foregroundStyle(getColor(userColorPreference))
                                    }
                                    .onTapGesture {
                                        isCashBoosterActive.toggle()
                                        print(" \(users.first?.inventory["\(Upgrades[0].upgradeName)"] ?? 0)")
                                    }
                                Text("Cash Booster")
                            }
                            .frame(width: 60, height: 80)
                            Spacer()
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 60, height: 60)
                                    .overlay {
                                        Image(systemName: "\(isCostReductionActive ? "bag.fill.badge.minus" : "bag.badge.minus")")
                                            .font(.system(size: 30))
                                            .foregroundStyle(getColor(userColorPreference))
                                    }
                                    .onTapGesture {
                                        isCostReductionActive.toggle()
                                    }
                                Text("Cost Reduction")
                            }
                            .frame(width: 60, height: 80)
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
                                        placeholderSheet.toggle()
                                    }
                                Text("More Info")
                            }
                            .frame(width: 60, height: 80)
                        }
                        .frame(width: screenWidth-30, height: 80)
                        .font(.system(size: 12))
                    }
                    .foregroundStyle(getColor("white"))
                    .frame(width: screenWidth-30, height: 180)

                    ZStack {
                        // White Background
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: screenWidth, height: screenHeight/1.5)
                            .foregroundStyle(.white)
                        VStack {
                            // Everything inside the white background
                            Text("Start New Task")
                                .frame(width: screenWidth-30, alignment: .leading)
                                .font(.system(size: 35))
                                .bold()
                                .foregroundStyle(getColor(userColorPreference))
                                .padding(.top, 20)
                            VStack (alignment: .leading, spacing: 5){
                                Text("Chose a business: \(selectedBusiness?.businessName ?? "")")
                                    .font(.system(size: 15))
                                ScrollView (.horizontal){
                                    if !businesses.isEmpty {
                                        HStack {
                                            ForEach(businesses) { business in
                                                RoundedRectangle(cornerRadius: 10)
                                                    .frame(width: 120, height: 100)
                                                    .overlay {
                                                        VStack {
                                                            Text("\(business.businessName)")
                                                                .foregroundStyle(.white)
                                                            
                                                        }
                                                    }
                                                    .foregroundStyle(getColor(userColorPreference))
                                                    .onTapGesture {
                                                        selectedBusiness = business
                                                    }
                                            }
                                        }
                                    }
                                    else {
                                        
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: screenWidth-30, height: 100)
                                            .foregroundStyle(getColor(userColorPreference))
                                            .overlay {
                                                Text("Please add a business to begin!")
                                                    .bold()
                                                    .font(.system(size: 24))
                                                    .foregroundStyle(.white)
                                            }
                                            .onTapGesture {
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
                                                        UserDataModel(username: "Jay_09", name: "Jay", email: "JayYo@gmail.com"),
                                                        UserDataModel(username: "LilKimmy", name: "Kim", email: "Kim@gmail.com"),
                                                        UserDataModel(username: "LilJimmy", name: "Jim", email: "Jim@gmail.com"),
                                                        UserDataModel(username: "LilLimmy", name: "Lim", email: "Lim@gmail.com"),
                                                        UserDataModel(username: "LilPimmy", name: "Pim", email: "Pim@gmail.com"),
                                                        UserDataModel(username: "LilTimmy", name: "Tim", email: "Tim@gmail.com"),
                                                        UserDataModel(username: "LilRimmy", name: "Rim", email: "Rim@gmail.com")
                                                    ],
                                                    badges: ["10 Days Streak", "$1000 Earned", "First Upgrade", "", "", "", "", "", "", "",],
                                                    sessionHistory:
                                                        [SessionDataModel(
                                                            id: UUID(),
                                                            sessionDate: Date.now,
                                                            sessionStart: formatFullDateTime(date: Date()),
                                                            sessionEnd: formatFullDateTime(date: Date()),
                                                            totalStudyTime: 3600, businessId: UUID()),
                                                         SessionDataModel(
                                                             id: UUID(),
                                                             sessionDate: Date.now,
                                                             sessionStart: formatFullDateTime(date: Date()),
                                                             sessionEnd: formatFullDateTime(date: Date()),
                                                             totalStudyTime: 3600, businessId: UUID())
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
                                }
                            }
                            .frame(width: screenWidth-30, alignment: .leading)
                            
                            TimeSelect(moveFiveMins: $timeRemaining)
                            
                            Button("Clock In!"){
                                if selectedBusiness != nil && timeRemaining > 0 {
                                    isWarningShowing = false // Reset the warning showing flag

                                    // Check for Cash Booster
                                    if isCashBoosterActive {
                                        if let currentAmount = users.first?.inventory["\(Upgrades[0].upgradeName)"], currentAmount > 0 {
                                            users.first!.inventory["\(Upgrades[0].upgradeName)"] = currentAmount - 1
                                        } else {
                                            isWarningShowing = true
                                            warningErrorMessage = "Not Enough Cash Boosters"
                                        }
                                    }

                                    // Check for Cost Reduction
                                    if isCostReductionActive {
                                        if let currentAmountOfCostReductions = users.first?.inventory["\(Upgrades[2].upgradeName)"] {
                                            if currentAmountOfCostReductions > 0 {
                                                users.first!.inventory["\(Upgrades[2].upgradeName)"] = currentAmountOfCostReductions - 1
                                            } else {
                                                isWarningShowing = true
                                                warningErrorMessage = "Not Enough Cost Reductions"
                                            }
                                        }
                                    }

                                    // Check for XP Booster
                                    if isXPBoosterActive {
                                        if let currentAmount = users.first?.inventory["\(Upgrades[1].upgradeName)"], currentAmount > 0 {
                                            users.first!.inventory["\(Upgrades[1].upgradeName)"] = currentAmount - 1
                                        } else {
                                            isWarningShowing = true
                                            warningErrorMessage = "Not Enough XP Boosters"
                                        }
                                    }

                                    // If any warning is shown, handle the warning
                                    if isWarningShowing {
                                        print(warningErrorMessage) // Log the warning message
                                    } else {
                                        // Proceed with saving the context and starting the timer
                                        do {
                                            try context.save()
                                        } catch {
                                            print("Failed to save user: \(error.localizedDescription)")
                                        }

                                        timeElapsed = 0
                                        currentView = 1
                                        isTimerActive.toggle()

                                        timeStarted = formatFullDateTime(date: Date())
                                        print(timeStarted)
                                    }
                                } else {
                                    // Show a warning if no business is selected or time is not remaining
                                    print("Please select a business before starting a timer!")
                                    warningErrorMessage = "Please select a business before starting a timer!"
                                    isWarningShowing.toggle()
                                }
                            }
                            .frame(width: screenWidth-30, height: 50)
                            .background(getColor(userColorPreference))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            
                            Spacer()
                        }
                    }
                }
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 200, height: 110)
                    .foregroundStyle(.gray)
                    .overlay {
                        VStack {
                            Text("Cant Start Timer :")
                                .bold()
                            Text("\(warningErrorMessage)")
                                .font(.system(size: 15))
                            Divider()
                                .padding(5)
                            Button("Close"){
                                isWarningShowing.toggle()
                            }
                        }
                        .foregroundStyle(.white)
                    }
                    .opacity(isWarningShowing ? 1 : 0)
            }
            .foregroundStyle(.black)
            .onAppear {
                isCashBoosterActive = false
                isCostReductionActive = false
                isXPBoosterActive = false
            }
            .sheet(isPresented: $placeholderSheet) {
                DashboardTopButtons(title: $showInventory, totalNetWorth: $showInventoryMoney, userColor: getColor(userColorPreference))
                    .presentationDetents([.fraction(0.763)])
            }
        }
    }
}


#Preview {
    StartTask(isTimerActive: .constant(false))
        .modelContainer(for: UserDataModel.self)
}
