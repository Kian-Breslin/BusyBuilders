//
//  StartTaskView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 01/06/2024.
//

import SwiftUI
import SwiftData

struct StartTaskView: View {
    
    // Variables
    @State var timeRemaining = 3600
    @State var isActiveTimer = false
    
    @State var isShowingSheet = false
    
    // Take in a business
    @State var chosenBusiness : BusinessDataModel
    @State var chosenBusinessIndex : Int
    @Query var businesses : [BusinessDataModel]
    
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .gray], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack (spacing: 20){
                // Chosen Business Image
                Circle()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(.white)
                    .overlay(content: {
                        Image("store")
                            .resizable()
                    })
                
                // Chosen Business Name
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 350, height: 50)
                    .foregroundStyle(Color(red: 36/255, green: 36/255, blue: 36/255))
                    .overlay {
                        Text("Business Name")
                            .font(.system(size: 30))
                            .foregroundStyle(.white)
                    }
                
                // Chosen Business TotalRevenue & Cash/min
                HStack (spacing: 10){
                    // Total Revenue
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 170, height: 50)
                        .foregroundStyle(Color(red: 36/255, green: 36/255, blue: 36/255))
                        .overlay {
                            Text("Value : $250,000")
                        }
                    
                    // Cash/min
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 170, height: 50)
                        .foregroundStyle(Color(red: 36/255, green: 36/255, blue: 36/255))
                        .overlay {
                            Text("$/min : 4000")
                        }
                }
                .foregroundStyle(.white)
                .font(.title3)
                .padding(.horizontal, 10)
                
                TimerView(timeRemaining: $timeRemaining, isActive: $isActiveTimer)
                
                VStack {
                    Text("Next Level")
                        .foregroundStyle(.white)
                        .opacity(0.4)
                    
                    HStack {
                        Text("18")
                            .frame(width: 35, height: 40)
                        ZStack (alignment: .leading){
                            RoundedRectangle(cornerRadius: 15)
                                .frame(width: 300, height: 25)
                                .foregroundStyle(Color(red: 36/255, green: 36/255, blue: 36/255))
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 200, height: 20)
                                .foregroundStyle(.red)
                                .offset(x: 3)
                        }
                        Text("19")
                            .frame(width: 35, height: 40)
                    }
                }
                
                VStack {
                    Text("Total Earnings")
                        .foregroundStyle(.white)
                        .opacity(0.4)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 50)
                        .foregroundStyle(Color(red: 36/255, green: 36/255, blue: 36/255))
                        .overlay {
                            Text("$1000")
                                .font(.title)
                                .foregroundStyle(.white)
                        }
                }
                
                Button("Finish") {
//                    if isActive == true {
//                        print("Timer is running")
//                        isActive = false
//                        finishTask = true
//                    }
                }
                .frame(width: 100, height: 40)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()

                
                // End of Vstack
            }
            
            
        }
        .sheet(isPresented: $isShowingSheet, content: {
            
            StartTaskViewSettings(chosenBusiness: $chosenBusiness)
            .presentationDetents([.fraction(0.8)])
            .interactiveDismissDisabled()
        })
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return StartTaskView(chosenBusiness: previewer.businesses[0], chosenBusinessIndex: 0)
    } catch {
        return Text("Failed to create preview : \(error.localizedDescription)")
    }
}
