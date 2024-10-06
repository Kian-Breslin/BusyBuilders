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
    @State var taskActive = false
    
    @State var selectedBusiness: BusinessDataModel?
    @State var businessName: String = ""
    
    // Timer
    @State var timeSeconds = 0
    @State var timeRemaining = 1800
    @State var timeElapsed = 0
    @State var isActive = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        if (taskActive) {
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
                        guard isActive else {return}
                        
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                            timeElapsed += 1
                        }
                    }
                    .onChange(of: scenePhase){
                        if scenePhase == .active {
                            isActive = true
                        } else {
                            isActive = false
                        }
                    }
                    
                    Button("Clock Out") {
                        isActive.toggle()
                        taskActive.toggle()
                    }
                    .frame(width: 300, height: 50)
                    .background(Color(red: 244/255, green: 73/255, blue: 73/255))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
                }
            }
        }
        else {
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
                                timeSeconds -= 300
                            }
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 150,height: 50)
                            .foregroundStyle(colorForName(userColorPreference))
                            .overlay {
                                Text("\(timeFormattedMins(timeSeconds))")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 40))
                            }
                        Image(systemName: "plus.circle")
                            .font(.system(size: 40))
                            .onTapGesture {
                                timeSeconds += 300
                            }
                    }
                    
                    Button("Clock In!"){
                        taskActive = true
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
    StartTask()
        .modelContainer(for: UserDataModel.self)
}
