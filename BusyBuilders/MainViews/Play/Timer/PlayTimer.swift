//
//  PlayTimer.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import SwiftData

struct PlayTimer: View {
    @EnvironmentObject var userManager: UserManager
    @Query var users: [UserDataModel]
    @State private var isTimerActive = false
    @State private var selectedTimer = "Beach"
    
    private let timers = [
        ("Beach", "Beach"),
        ("GrayMountain", "Sunset"),
        ("RedMountain", "Red Mountain"),
        ("Lighthouse", "Lighthouse")
    ]
    
    var body: some View {
        VStack {
            HStack (alignment: .top, spacing: 50){
                VStack {
                    ForEach(timers, id: \.0) { timerKey, timerName in
                        customButton(text: timerName, color: selectedTimer == timerKey ? getColor(userManager.accentColor) : .black, width: 150, height: 50, action: {
                            withAnimation(.linear){
                                selectedTimer = timerKey
                            }
                        })
                        .animation(.easeInOut, value: selectedTimer)
                    }
                }
                
                Image("\(selectedTimer)BB")
                    .resizable()
                    .frame(width: 120, height: 225)
                    .transition(.slide)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .frame(width: screenWidth-20)
            Spacer()
            
//            ScrollView (.horizontal) {
//                HStack {
//                    if let user = users.first {
//                        ForEach(user.plannedSessions ?? [], id: \.self){ session in
//                            plannedSessionItem(session: session)
//                                .padding()
//                                .onTapGesture {
//                                    session.completed?.toggle()
//                                }
//                                .onLongPressGesture {
//                                    user.plannedSessions?.removeAll(where: {$0.id == session.id})
//                                }
//                        }
//                    }
//                }
//            }
            
//            customButton(text: "Start Upcoming Session", color: .white, width: 200, height: 50) {
//                guard let user = users.first else { return }
//                
//                let now = Date()
//                let oneHourFromNow = now.addingTimeInterval(60 * 60)
//
//                var count = 0
//                for session in user.plannedSessions ?? [] {
//                    if let start = session.startTime, start >= now && start <= oneHourFromNow {
//                        count += 1
//                    }
//                }
//
//                print("Sessions starting within the next hour:", count)
//            }
            
            
            customButton(text: "Start", color: .white, width: 150, height: 50, action: {
                isTimerActive.toggle()
            })
        }
        .padding(.top, 15)
        .padding(.bottom, 75)
        .frame(width: screenWidth, height: screenHeight - 240)
        .background(userManager.secondaryColor)
        .foregroundColor(userManager.mainColor)
        .fullScreenCover(isPresented: $isTimerActive) {
            switch selectedTimer {
            case "Beach":
                BeachViewTimer()
            case "GrayMountain":
                TimerSunset()
            case "RedMountain":
                RedMountainTimer()
            case "Lighthouse":
                TimerLighthouse()
            default:
                EmptyView()
            }
        }
    }
}
    

#Preview {
    Play()
        .environmentObject(UserManager())
}
