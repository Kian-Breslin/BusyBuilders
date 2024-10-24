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
    
    // Dev Tests
    let devNames = ["Math Masters","Eco Innovators","Science Solutions","Code Creators","Design Depot","Robotics Realm","Tech Repair Hub","Game Forge","AI Insights","Physics Powerhouse"]

    var body: some View {
        if (currentView == 1) {
            // Active Task View
            ZStack {
                getColor(userColorPreference)
                    .ignoresSafeArea()
                
                Timer1(currentView: $currentView, selectedBusiness: $selectedBusiness, timeRemaining: $timeRemaining, timeElapsed: $timeElapsed, isTimerActive: $isTimerActive, timeStarted: $timeStarted, totalCashEarned: $totalCashEarned)
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
                                Text("$\(selectedBusiness?.netWorth ?? 0, specifier: "%.f")")
                                    .font(.system(size: 35))
                                    .fontWeight(.bold)
                                    .onTapGesture {
                                        
                                    }
                                HStack (spacing: 35){
                                    Text("Net Worth")
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
                    .foregroundStyle(.white)

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
                                                let newBusiness = BusinessDataModel(businessName: "\(devNames[Int.random(in: 0..<10)])", businessTheme: "Red", businessType: "Eco Friendly", businessIcon: "triangle", cashPerMin: 1000)
                                                
                                                context.insert(newBusiness)
                                                
                                                do {
                                                    try context.save()
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
                                    
                                    timeElapsed = 0
                                    
                                    currentView = 1
                                    isTimerActive.toggle()
                                    
                                    timeStarted = formatFullDateTime(date: Date())
                                    print(timeStarted)
                                } else {
                                    print("Please select a business before starting a timer!")
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
            }
            .foregroundStyle(.black)
        }
    }
}


#Preview {
    StartTask(isTimerActive: .constant(false))
        .modelContainer(for: UserDataModel.self)
}
