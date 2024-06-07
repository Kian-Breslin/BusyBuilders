//
//  TestView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 21/05/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State var showingSettings = false
    @State var showingProfile = false
    @State var taskActive = false
    @State var chosenTime = "30 mins"
    
    @State var username : String
    @State var totalRevenue : CDouble
    
//    @Query var user : [UserDataModel]
    @State var bestPerfoming : String
    
    
    
    var body: some View {
        
        if !taskActive {
            
            ZStack {
                LinearGradient(colors: [Color(red: 1, green: 74/255, blue: 74/255), .black],
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack {
                    
                    HStack {
                        HStack {
                            VStack (alignment: .leading){
                                Text("Hello!")
                                    .font(.system(size: 25))
                                    .fontWeight(.light)
                                Text("Kian Breslin")
                                    .font(.system(size: 40))
                            }
                            Image(systemName: "hand.raised")
                                .font(.system(size: 40))
                                .rotationEffect(Angle(degrees: -35))
                                .offset(y: 9)
                        }
                        Spacer()
                        
                        Image(systemName: "circle.fill")
                            .font(.system(size: 70))
                            .fontWeight(.thin)
                    }
                    .padding()
                    
                    HStack (spacing: 20){
                        SmallMainWidget(title: "Best Performing", amount: 60, dailyGoal: 100)
                        SmallMainWidget(title: "Total Revenue Today", amount: 30, dailyGoal: 50)
                    }
                    .padding(.horizontal,10)
                    
                    ScrollView {
                        LargeMainWidget()
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                        LargeMainWidget()
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                        LargeMainWidget()
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                        LargeMainWidget()
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                        LargeMainWidget()
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                    }
                }
                .padding(.vertical)
            }
            .foregroundStyle(.white)
            .sheet(isPresented: $showingProfile, content: {
                Profile(usernameTest: username)
                    .presentationDetents([.medium])
            })
            .sheet(isPresented: $showingSettings, content: {
//                Settings(selectedBusiness: $chosenBusiness, isActiveState: $taskActive, selectedTime: $chosenTime)
                Profile(usernameTest: username)
                    .presentationDetents([.fraction(0.8)])
            })
        } else {
//            ActiveTaskView(busTestObject: chosenBusiness, timeRemaining: timeRemainingFunc(chosenTime))
        }
    }
    
    func timeRemainingFunc(_ time : String) -> Int {
        switch time {
        case "30 mins":
            return 1800
        case "1 hour":
            return 3600
        case "1 hour 30":
            return 5400
        case "2 hours":
            return 7200
        default:
            return 0
        }
    }
}

#Preview {
    HomeView(username: "Kian Breslin", totalRevenue: 1.45, bestPerfoming: "")
    
//    do {
//        let previewer = try Previewer()
//        
//        return HomeView(username: "Kian Breslin", totalRevenue: 1.45, bestPerfoming: "")
//    } catch {
//        return Text("Failed to create preview : \(error.localizedDescription)")
//    }
}
 
