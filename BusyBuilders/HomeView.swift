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
                    // Settings
                    HStack {
                        Spacer()
                        
                        Image(systemName: "gear")
                            .foregroundStyle(.white)
                            .font(.title)
                            .onTapGesture {
                                print("Settings")
                                showingSettings.toggle()
                            }
                    }
                    .padding(.horizontal)
                    
                    // User Name and Total Revenue
                    HStack {
                        Group {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 40))
                            Text("\(username)")
                                .font(.system(size: 28))
                            }
                        .onTapGesture {
                            print("Show Profile")
                            showingProfile.toggle()
                        }
                        Spacer()
                        Text("$\(totalRevenue, specifier: "%.2f")M")
                            .font(.system(size: 20))
                    }
                    .padding()
                    .padding(.vertical)
                    
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
                        Text("\(AddNumbers(2, 4))")
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
                Settings(isActiveState: $taskActive, selectedTime: $chosenTime)
                    .presentationDetents([.fraction(0.8)])
            })
        } else {
            ActiveTaskView(timeRemaining: timeRemainingFunc(chosenTime))
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
        .modelContainer(for: [BusinessDataModel.self, UserDataModel.self], inMemory: true)
}
 
