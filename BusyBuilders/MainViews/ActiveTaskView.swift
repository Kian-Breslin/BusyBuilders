//
//  ActiveTaskView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 29/05/2024.
//

import SwiftUI
import SwiftData

struct ActiveTaskView: View {
    
    @Environment(\.modelContext) var context
    @Query var businesses : [BusinessDataModel]

    @State var timeRemaining : Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State var isActive = true
    
    var body: some View {
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
//                        Text("\(businesses[0].businessName)")
//                            .foregroundStyle(.white)
//                            .font(.title)
                    }
                
                HStack {
                    RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                        .frame(width: 180, height: 50)
                        .foregroundStyle(Color(red: 36/255, green: 36/255, blue: 36/255))
                        .overlay {
                            Text("Value : $300,000")
                        }
                    
                    RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                        .frame(width: 180, height: 50)
                        .foregroundStyle(Color(red: 36/255, green: 36/255, blue: 36/255))
                        .overlay {
                            Text("$ / Min : $500")
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
                            Text("$6,000")
                                .font(.title)
                                .foregroundStyle(.white)
                        }
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else {return}
            
            if timeRemaining > 0 {
                timeRemaining -= 1
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
    func timeFormatted(_ totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}


#Preview {
    ActiveTaskView(timeRemaining: 3600)
        .modelContainer(for: [BusinessDataModel.self])
}
