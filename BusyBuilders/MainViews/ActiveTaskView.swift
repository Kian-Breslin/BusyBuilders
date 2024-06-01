//
//  ActiveTaskView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 29/05/2024.
//

import SwiftUI
import SwiftData

struct ActiveTaskView: View {
    
    // Needs to take in a Business (Model)
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query var businesses : [BusinessDataModel]

    @State var busTestObject : BusinessDataModel
    @State var timeRemaining : Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State var isActive = true
    
    @State var totalEarnings = 0
    @State var cashMin = 500
    @State var revenueOverall = 0
    @State var timeElapsed = 0
    @State var finishTask = false
    @State var showSessionStats = false
    
    
    var body: some View {
        if showSessionStats {
            SessionStats(amount: totalEarnings)
        } else {
            ZStack {
                Color(red: 0.2, green: 0.2, blue: 0.2)
                    .ignoresSafeArea()
                VStack {
                    
                    ZStack {
                        Circle()
                            .frame(width: 205, height: 205)
                            .foregroundStyle(.red)
                        Circle()
                            .frame(width: 200, height: 200)
                            .foregroundStyle(Color(red: 0.1, green: 0.1, blue: 0.1))
                            .overlay {
                                Image("store")
                                    .resizable()
                            }
                    }
                    
                    RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                        .frame(width: 370, height: 50)
                        .foregroundStyle(Color(red: 36/255, green: 36/255, blue: 36/255))
                        .overlay {
                            Text("\(busTestObject.businessName)")
                                .foregroundStyle(.white)
                                .font(.title)
                        }
                    
                    HStack {
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .frame(width: 180, height: 50)
                            .foregroundStyle(Color(red: 36/255, green: 36/255, blue: 36/255))
                            .overlay {
                                Text("Value: $\(busTestObject.businessRevenueAmount)")
                            }
                        
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .frame(width: 180, height: 50)
                            .foregroundStyle(Color(red: 36/255, green: 36/255, blue: 36/255))
                            .overlay {
                                Text("$ / Min : $\(cashMin)")
                            }
                    }
                    .foregroundStyle(.white)
                    .font(.title3)
                    .padding(.horizontal, 10)
                    
                    VStack {
                        Text("Time Remaining")
                            .foregroundStyle(.white)
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
                    
                    VStack {
                        Text("Next Level")
                            .foregroundStyle(.white)
                            .opacity(0.4)
                        
                        HStack {
                            Text("18")
                                .frame(width: 35, height: 40)
                            ZStack (alignment: .leading){
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 300, height: 25)
                                    .foregroundStyle(Color(red: 36/255, green: 36/255, blue: 36/255))
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 200, height: 20)
                                    .foregroundStyle(.red)
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
                                Text("$\(totalEarnings)")
                                    .font(.title)
                                    .foregroundStyle(.white)
                            }
                    }
                    Button("Finish") {
                        if isActive == true {
                            print("Timer is running")
                            isActive = false
                            finishTask = true
                        }
                    }
                    .frame(width: 100, height: 40)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                }
            }
            .sheet(isPresented: $finishTask, content: {
                Text("Are you sure you want to finish?")
                HStack {
                    Button("Yes"){
                        revenueOverall = revenueOverall + totalEarnings
                        finishTask = false
                        showSessionStats = true
                    }
                    Button("No"){
                        isActive = true
                        finishTask = false
                    }
                }
                    .presentationDetents([.fraction(0.4)])
            })
            .onReceive(timer) { time in
                guard isActive else {return}
                
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    timeElapsed += 1
                    if timeElapsed == 2 {
                        timeElapsed = 0
                        totalEarnings = totalEarnings + (cashMin*1)
                    }
                }
            }
            .onChange(of: scenePhase){
                if scenePhase == .active {
                    isActive = true
                } else {
                    isActive = false
                }
            }
        }
    }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}


#Preview {
    do {
        let previewer = try Previewer()
        
        return ActiveTaskView(busTestObject: previewer.businesses, timeRemaining: 3600)
    } catch {
        return Text("Failed to create preview : \(error.localizedDescription)")
    }
}
