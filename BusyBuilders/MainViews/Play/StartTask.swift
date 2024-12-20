//
//  StartTask.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/09/2024.
//

import SwiftUI
import SwiftData

struct StartTask: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.modelContext) var context
    @Environment(\.scenePhase) var scenePhase
    
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel]
    @State var currentView = 0
    let Upgrades = availableUpgrades
    
    // Show Inventory
    @State var placeholderSheet = false
    
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
    @State var showInventory = false
    
    // Dev Tests
    let devNames = ["Math Masters","Eco Innovators","Science Solutions","Code Creators","Design Depot","Robotics Realm","Tech Repair Hub","Game Forge","AI Insights","Physics Powerhouse"]
    
    @State var Title = "Play"
    @State var buttonImages = ["star", "banknote", "bag.badge.minus", "archivebox"]
    @State var buttonText = ["XP +", "Cash +", "Cost -", "Inventory"]
    @State var selectedScreen = ""

    var body: some View {
        if (currentView == 1) {
            // Active Task View
            ZStack {
                themeManager.mainColor
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
                themeManager.mainColor
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        // Top Header
                        HStack {
                            Text(Title)
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                            Spacer()
                            HStack (spacing: 15){
                                ZStack {
                                    Image(systemName: "bell.fill")
                                    Image(systemName: "2.circle.fill")
                                        .font(.system(size: 15))
                                        .offset(x: 10, y: -10)
                                        .onTapGesture {
                                            
                                        }
                                }
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 40, height: 40)
                                    .overlay(content: {
                                        Image("userImage-2")
                                            .resizable()
                                            .frame(width: 40,height: 40)
                                    })
                                    .onTapGesture {
                                        
                                        
                                    }
                            }
                            .font(.system(size: 25))
                        }
                        .frame(width: screenWidth-30, height: 60)
                        
                        HStack {
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 60, height: 60)
                                    .overlay {
                                        Image(systemName: isXPBoosterActive ? "\(buttonImages[0]).fill" : "\(buttonImages[0])")
                                            .font(.system(size: 30))
                                            .foregroundStyle(themeManager.mainColor)
                                        
                                    }
                                    .onTapGesture {
                                        isXPBoosterActive.toggle()
                                    }
                                
                                Text(buttonText[0])
                                    .font(.system(size: 10))
                                    .scaledToFit()
                            }
                            .frame(width: 60, height: 80)
                            Spacer()
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 60, height: 60)
                                    .overlay {
                                        Image(systemName: isCashBoosterActive ? "\(buttonImages[1]).fill" : "\(buttonImages[1])")
                                            .font(.system(size: 30))
                                            .foregroundStyle(themeManager.mainColor)
                                        
                                    }
                                    .onTapGesture {
                                        isCashBoosterActive.toggle()
                                    }
                                
                                Text(buttonText[1])
                                    .font(.system(size: 10))
                                    .scaledToFit()
                            }
                            .frame(width: 60, height: 80)
                            Spacer()
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 60, height: 60)
                                    .overlay {
                                        Image(systemName: isCostReductionActive ? "\(buttonImages[2]).fill" : "\(buttonImages[2])")
                                            .font(.system(size: 30))
                                            .foregroundStyle(themeManager.mainColor)
                                        
                                    }
                                    .onTapGesture {
                                        isCostReductionActive.toggle()
                                    }
                                
                                Text(buttonText[2])
                                    .font(.system(size: 10))
                                    .scaledToFit()
                            }
                            .frame(width: 60, height: 80)
                            Spacer()
                            VStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 60, height: 60)
                                    .overlay {
                                        Image(systemName: showInventory ? "\(buttonImages[3]).fill" : "\(buttonImages[3])")
                                            .font(.system(size: 30))
                                            .foregroundStyle(themeManager.mainColor)
                                        
                                    }
                                    .onTapGesture {
                                        showInventory.toggle()
                                    }
                                
                                Text(buttonText[3])
                                    .font(.system(size: 10))
                                    .scaledToFit()
                            }
                            .frame(width: 60, height: 80)
                            
                        }
                        .font(.system(size: 12))
                        .foregroundStyle(themeManager.textColor)
                        .frame(width: screenWidth-30, height: 100)
                    }
                    .frame(width: screenWidth-30, height: 160)
                    
                    // White Background
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: screenWidth)
                        .foregroundStyle(themeManager.textColor)
                        .overlay {
                            VStack {
                                // Everything inside the white background
                                Text("Start New Task")
                                    .frame(width: screenWidth-30, alignment: .leading)
                                    .font(.system(size: 35))
                                    .bold()
                                    .foregroundStyle(themeManager.mainColor)
                                    .padding(.top, 20)
                                VStack (alignment: .leading, spacing: 5){
                                    Text("Chose a business: \(selectedBusiness?.businessName ?? "")")
                                        .font(.system(size: 15))
                                        .foregroundStyle(themeManager.mainColor)
                                    ScrollView (.horizontal){
                                        if !businesses.isEmpty {
                                            HStack {
                                                ForEach(businesses) { business in
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .frame(width: 120, height: 100)
                                                        .overlay {
                                                            VStack {
                                                                Text("\(business.businessName)")
                                                                    .foregroundStyle(themeManager.textColor)
                                                                
                                                            }
                                                        }
                                                        .foregroundStyle(themeManager.mainColor)
                                                        .onTapGesture {
                                                            selectedBusiness = business
                                                        }
                                                }
                                            }
                                        }
                                        else {
                                            
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: screenWidth-30, height: 100)
                                                .foregroundStyle(themeManager.mainColor)
                                                .overlay {
                                                    Text("Please add a business to begin!")
                                                        .bold()
                                                        .font(.system(size: 24))
                                                        .foregroundStyle(themeManager.textColor)
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
                                                                businessId: UUID(),totalStudyTime: 3600),
                                                             SessionDataModel(
                                                                id: UUID(),
                                                                sessionDate: Date.now,
                                                                sessionStart: formatFullDateTime(date: Date()),
                                                                sessionEnd: formatFullDateTime(date: Date()),
                                                                businessId: UUID(),totalStudyTime: 3600)
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
                                .background(themeManager.mainColor)
                                .foregroundStyle(themeManager.textColor)
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
            .foregroundStyle(themeManager.textColor)
            .onAppear {
                isCashBoosterActive = false
                isCostReductionActive = false
                isXPBoosterActive = false
            }
        }
    }
}


#Preview {
    StartTask(isTimerActive: .constant(false))
        .modelContainer(for: UserDataModel.self)
        .environmentObject(ThemeManager())
        .environmentObject(UserManager())
}
