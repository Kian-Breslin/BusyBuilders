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

    var body: some View {
        if (currentView == 1) {
            // Active Task View
            ZStack {
                Color(red: 0.7, green: 0.7, blue: 0.7)
                    .ignoresSafeArea()
                
                VStack {
                    Text("\(selectedBusiness?.businessName ?? "Selected Business")")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                    
                    VStack {
                        Text("Time Remaining")
                            .foregroundStyle(.black)
                            .opacity(0.4)
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 370, height: 80)
                            .foregroundStyle(Color(red: 36/255, green: 36/255, blue: 36/255))
                            .overlay {
                                Text("\(timeFormatted(timeRemaining))")
                                    .font(.system(size: 40))
                                    .foregroundStyle(.white)
                            }
                    }
                    .onReceive(timer) { time in
                        guard isTimerActive else {return}
                        
                        if timeRemaining > 0 {
                            
                            //Cash
                            timeRemaining -= 1
                            timeElapsed += 1
                            
                            // Experience
                            experienceEarned += 10
                        }
                        else {
                            isTimerActive.toggle()
                            currentView = 2
                            
                            // Final Calculations
                            totalCashEarned = (Double(timeElapsed * (selectedBusiness?.cashPerMin ?? 0)) / 60).rounded()
                            print(totalCashEarned)
                            
                            // Add Cash earned to business
                            selectedBusiness?.netWorth = (selectedBusiness?.netWorth ?? 0) + totalCashEarned
                            // Add Experience
                            selectedBusiness?.businessLevel = (selectedBusiness?.businessLevel ?? 0) + timeElapsed/60
                            // Create new session entry
                            let session = SessionDataModel(sessionStart: timeStarted, sessionEnd: formatFullDateTime(date: Date()), totalStudyTime: timeElapsed, businessId: selectedBusiness?.id ?? UUID())
                            
                            // Add session to session history
                            selectedBusiness?.sessionHistory.append(session)
                        }
                    }
                    .onChange(of: scenePhase){
                        if scenePhase == .active {
                            isTimerActive = true
                        } else {
                            isTimerActive = false
                        }
                    }
                    
                    Button("Clock Out") {
                        isTimerActive.toggle()
                        currentView = 2
                        
                        // Final Calculations
                        totalCashEarned = (Double(timeElapsed * (selectedBusiness?.cashPerMin ?? 0)) / 60).rounded()
                        print(totalCashEarned)
                        
                        // Add Cash earned to business
                        selectedBusiness?.netWorth = (selectedBusiness?.netWorth ?? 0) + totalCashEarned
                        // Add Experience
                        selectedBusiness?.businessLevel = (selectedBusiness?.businessLevel ?? 0) + timeElapsed/60
                        // Create new session entry
                        let session = SessionDataModel(sessionStart: timeStarted, sessionEnd: formatFullDateTime(date: Date()), totalStudyTime: timeElapsed, businessId: selectedBusiness?.id ?? UUID())
                        
                        // Add session to session history
                        selectedBusiness?.sessionHistory.append(session)
                    }
                    .frame(width: 300, height: 50)
                    .background(Color(red: 244/255, green: 73/255, blue: 73/255))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                }
            }
        }
        else if (currentView == 2) {
            PostTask(currentView: $currentView, totalCashEarned: totalCashEarned)
        }
        else {
            // Start Task View
            ZStack {
                Color.gray
                    .ignoresSafeArea()
                VStack {
                    ScrollView (.horizontal){
                        HStack {
                            ForEach(businesses) { business in
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 150, height: 150)
                                    .overlay {
                                        VStack {
                                            Text("\(business.businessName)")
                                                .foregroundStyle(.white)
                                            
                                        }
                                    }
                                    .foregroundStyle(.red)
                                    .onTapGesture {
                                        selectedBusiness = business
                                    }
                            }
                        }
                        .padding()
                    }
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 250,height: 50)
                        .foregroundStyle(colorForName(userColorPreference))
                        .overlay {
                            Text("\(selectedBusiness?.businessName ?? "Selected Business")")
                                .foregroundStyle(.white)
                        }
                    
                    HStack {
                        Image(systemName: "minus.circle")
                            .font(.system(size: 40))
                            .onTapGesture {
                                timeRemaining -= 300
                            }
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 150,height: 50)
                            .foregroundStyle(colorForName(userColorPreference))
                            .overlay {
                                Text("\(timeFormattedMins(timeRemaining))")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 40))
                            }
                        Image(systemName: "plus.circle")
                            .font(.system(size: 40))
                            .onTapGesture {
                                timeRemaining += 300
                            }
                    }
                    
                    Button("Clock In!"){
                        currentView = 1
                        isTimerActive.toggle()
                        
                        timeStarted = formatFullDateTime(date: Date())
                        print(timeStarted)
                    }
                    .frame(width: 300, height: 50)
                    .background(Color(red: 244/255, green: 73/255, blue: 73/255))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)

                }
            }
        }
    }
}


#Preview {
    StartTask(isTimerActive: .constant(false))
        .modelContainer(for: UserDataModel.self)
}
