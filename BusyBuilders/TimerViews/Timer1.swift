//
//  Timer1.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/10/2024.
//

import SwiftUI
import SwiftData

struct Timer1: View {
    
    
    @AppStorage("userColorPreference") var userColorPreference: String = "red"
    @Environment(\.modelContext) var context
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.verticalSizeClass) var heightSizeClass : UserInterfaceSizeClass?
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel] // Query for businesses
    
    @Binding var currentView : Int
    @Binding var selectedBusiness : BusinessDataModel?
    
    // Timer
    @Binding var timeRemaining : Int
    @Binding var timeElapsed : Int
    @Binding var isTimerActive : Bool
    @Binding var timeStarted : String
    @Binding var totalCashEarned : Double
    @State var timerLengthAnimation = 0.0
   
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Final Calculation Variables
    @State var experienceEarned = 0
    @State var timeEnded = ""
    
    // Circle Timer
    @State var clockNumber = 0.0
    @State var clockCountDown = 60
    @State var clockTickerRotation = 180.0
    @State var cashEarnedSoFarVariable = 0
    @State var cashFlyAnimation = false
    
    
    var body: some View {
        Group {
            if heightSizeClass == .regular {
                ZStack {
                    ZStack (alignment: .top){
                        Color.black
                            .ignoresSafeArea()
                            
                        
                        Rectangle()
                            .frame(width: screenWidth, height: CGFloat(screenHeight - CGFloat(clockCountDown*10)))
                            .foregroundStyle(colorForName(userColorPreference))
                            .ignoresSafeArea()
                    }
                    
                    VStack {
                        ZStack {
                            Circle()
                                .fill(colorForName(userColorPreference))
                                .frame(width: 200, height: 200)
                            
                            Circle()
                                .stroke(Color.gray, style: StrokeStyle(lineWidth: 1))
                                .frame(width: 200, height: 200)

                            // Pizza slice shape
                            Circle()
                                .trim(from: clockNumber, to: 1)
                                .stroke(Color.white, style: StrokeStyle(lineWidth: 5))
                                .frame(width: 200, height: 200)
                                .rotationEffect(Angle(degrees: -90))
                                .overlay {
                                    ForEach(0..<12) { turn in
                                        let countdownValue = (60 - turn * 5) % 60
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: 3, height: (clockCountDown == (countdownValue) ? 50 : 30))
                                            .offset(x: 0, y: 50)
                                            .rotationEffect(Angle(degrees: Double(turn) * 30 - 180))
                                            .opacity(clockCountDown == (countdownValue) ? 1 : 0.3)
                                    }
                                }
                            Circle()
                                .frame(width: 105)
                                .foregroundStyle(colorForName(userColorPreference))
                                .overlay {
                                    Text("\(timeFormattedSec(clockCountDown))")
                                        .font(.system(size: 30))
                                }
                        }
                        .animation(.linear(duration: 0.2), value: clockNumber)
                        .padding()
                        
                        Spacer()
                        
                        ZStack {
                            //Background
//                            RoundedRectangle(cornerRadius: 10)
//                                .frame(width: 460, height: 50)
                            // Timer Background
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 300, height: 45)
                                .foregroundStyle(.white)
                            
                            VStack (alignment: .leading){
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: CGFloat(timerLengthAnimation), height: 40)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(colorForName(userColorPreference))
                                
                            }
                            .frame(width: 290, height: 40)
                            .animation(.linear, value: timerLengthAnimation)
                            
                                Text("\(timeFormatted(timeRemaining))")
                                    .font(.system(size: 30))
                                    .foregroundStyle(.black)
                        }
                        
                        Spacer()
                        
                        Button("Clock Out") {
                            isTimerActive.toggle()
                            currentView = 2
                            
                            // Do Calculations
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
                            
                            // Reset Numbers
                            timeRemaining = 0
                            
                        }
                        .frame(width: 200, height: 50)
                        .background(.clear)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(colorForName(userColorPreference))
                        .fontWeight(.bold)
                    }
                    .padding(50)
                }
            }
            else {
                ZStack {
                    colorForName(userColorPreference)
                        .ignoresSafeArea()
                    
                    HStack {
                        VStack {
                            ZStack {
                                Circle()
                                    .fill(colorForName(userColorPreference))
                                    .frame(width: 200, height: 200)
                                
                                Circle()
                                    .stroke(Color.gray, style: StrokeStyle(lineWidth: 1))
                                    .frame(width: 200, height: 200)

                                Circle()
                                    .trim(from: clockNumber, to: 1)
                                    .stroke(Color.white, style: StrokeStyle(lineWidth: 5))
                                    .frame(width: 200, height: 200)
                                    .rotationEffect(Angle(degrees: -90))
                                    .overlay {
                                        ForEach(0..<12) { turn in
                                            let countdownValue = (60 - turn * 5) % 60
                                            RoundedRectangle(cornerRadius: 5)
                                                .frame(width: 3, height: (clockCountDown == (countdownValue) ? 50 : 30))
                                                .offset(x: 0, y: 50)
                                                .rotationEffect(Angle(degrees: Double(turn) * 30 - 180))
                                                .opacity(clockCountDown == (countdownValue) ? 1 : 0.3)
                                        }
                                    }
                                Circle()
                                    .frame(width: 105)
                                    .foregroundStyle(colorForName(userColorPreference))
                                    .overlay {
                                        Text("\(timeFormattedSec(clockCountDown))")
                                            .font(.system(size: 30))
                                    }
                            }
                            .animation(.linear(duration: 0.2), value: clockNumber)
                            
                            Spacer()
                            
                            ZStack {
                                Text("Cash Earned : $\(cashEarnedSoFarVariable)")
                                    .onTapGesture {
                                        cashFlyAnimation.toggle()
                                    }
                                
                                HStack {
                                    Spacer()
                                    RoundedRectangle(cornerRadius: 5)
                                        .frame(width: 40, height: 20)
                                        .opacity(0.8)
                                        .overlay {
                                            Text("+$\(selectedBusiness?.cashPerMin ?? 1000)")
                                                .foregroundStyle(colorForName(userColorPreference))
                                                .font(.system(size: 8))
                                        }
                                }
                                .opacity(cashFlyAnimation ? 1 : 0)
                                .offset(x: cashFlyAnimation ? 20 : 0, y: cashFlyAnimation ? -30 : 0)
                                .animation(.linear(duration: 0.3), value: cashFlyAnimation)
                            }
                            .frame(width: 200, height: 20)
                        }
                        .padding(.vertical, 50)
                        
                        Divider()
                            .padding()
                        
                        VStack {
                            HStack {
                                Image("store")
                                    .resizable()
                                    .frame(width: 200, height: 200)
                                
                                Text("\(selectedBusiness?.businessName ?? "None")")
                                    .font(.system(size: 30))
                            }
                            
                            
                            // Timer
                            ZStack {
                                //Background
    //                            RoundedRectangle(cornerRadius: 10)
    //                                .frame(width: 460, height: 50)
                                // Timer Background
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 460, height: 45)
                                    .foregroundStyle(.white)
                                
                                VStack (alignment: .leading){
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: CGFloat(timerLengthAnimation), height: 40)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundStyle(colorForName(userColorPreference))
                                    
                                }
                                .frame(width: 450, height: 40)
                                .animation(.linear, value: timerLengthAnimation)
                                
                                    Text("\(timeFormatted(timeRemaining))")
                                        .font(.system(size: 30))
                                        .foregroundStyle(.black)
                            }
                            Button("Clock Out") {
                                // Do Calculations
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
                                
                                // Reset Numbers
                                timeRemaining = 0
                                
                            }
                            .frame(width: 200, height: 50)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .foregroundStyle(colorForName(userColorPreference))
                            .fontWeight(.bold)
                        }
                    }
                    
                    
                }
            }
        }
        .onReceive(timer) { time in
            guard isTimerActive else {return}
            
            if timeRemaining > 0 {
                
                //Cash
                timeRemaining -= 1
                timeElapsed += 1
                if timerLengthAnimation < 450{
                    timerLengthAnimation += 7.5
                }
                if clockCountDown > 0 && clockCountDown <= 60 {
                    clockNumber += 0.01667
                    clockCountDown -= 1
                    clockTickerRotation += 6
                    cashFlyAnimation = false
                    
                } else {
                    clockNumber = 0.01667
                    clockCountDown = 59
                    clockTickerRotation = 180
                    cashEarnedSoFarVariable += selectedBusiness?.cashPerMin ?? 0
                    cashFlyAnimation = true
                }
                
                //Experience
                experienceEarned += 10
            } else {
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
                
                // Reset Numbers
                timeRemaining = 0
            }
        }
        .onChange(of: scenePhase){
            if scenePhase == .active {
                isTimerActive = true
            } else {
                isTimerActive = false
            }
        }
    }
}

#Preview {
    Timer1(currentView: .constant(0), selectedBusiness: .constant(BusinessDataModel(businessName: "Kians Coffee Shop", businessTheme: "blue", businessType: "Eco", businessIcon: "circle", cashPerMin: 1000)), timeRemaining: .constant(1800), timeElapsed: .constant(0), isTimerActive: .constant(false), timeStarted: .constant(formatFullDateTime(date: Date())), totalCashEarned: .constant(0.0))
}
