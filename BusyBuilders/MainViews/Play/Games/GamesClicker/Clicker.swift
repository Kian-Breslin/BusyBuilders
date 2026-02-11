//
//  GamesClicker.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 29/07/2025.
//

import SwiftUI
import SwiftData

struct Clicker: View {
    @EnvironmentObject var userManager: UserManager

    @State private var cash = 0
    
    
    
    // Control
    @State var cashPerClick = 1
    var cashPerSecond : Int {
        return employees * 1
    }
    
    // Upgrades
    @State var autoClicker = 0
    
    @State var showEmployees = false
    @State var employees = 0
    
    @State var showInvestors = false

    
    @State private var timeRemaining = 600 // 10 minutes

    let timer = Timer.publish(every: 1, on: .main, in: .common)/*.autoconnect()*/

    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()

            VStack(spacing: 30) {
                Text("Time: \(secondsToMinutes(seconds: timeRemaining))")
                    .font(.largeTitle)
                    .bold()
                
                Text("Cash: $\(cash)")
                    .font(.largeTitle)
                    .bold()
                
                VStack (alignment: .leading){
                    Text("Cpc: $\(cashPerClick)")
                }
                .frame(width: screenWidth-20, alignment: .leading)
                
                HStack {
                    customImageButton(image: "cursorarrow", color: getColor(userManager.accentColor), width: 50, height: 50) {
                        if cash >= 10 {
                            cash -= 10
                            cashPerClick += 1
                        }
                    }
                    
                    customImageButton(image: "cursorarrow.motionlines", color: getColor(userManager.accentColor), width: 50, height: 50) {
                        if cash >= 10 {
                            cash -= 10
                            cashPerClick += 1
                        }
                    }
                    Spacer()
                }
                
                // Buildings
                VStack (alignment: .leading){
                    HStack {
                        Text("Employees: \(employees)")
                        Spacer()
                        Group {
                            Text("Show")
                            Image(systemName: "chevron.right")
                        }
                        .onTapGesture {
                            withAnimation(.linear){
                                showEmployees.toggle()
                            }
                        }
                    }
                    
                    if showEmployees {
                        Group {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: screenWidth-20, height: 120)
                                .foregroundStyle(userManager.secondaryColor)
                                .overlay {
                                    VStack (alignment: .leading){
                                        Text("Each Employee produces: $1")
                                        Text("\(employees) earning $\(employees * 1)/s")
                                    }
                                    .frame(width: screenWidth-30, alignment: .leading)
                                }
                            
                            HStack {
                                customButton(text: "Hire 1: $10", color: getColor(userManager.accentColor), width: (screenWidth-20)/2, height: 40) {
                                    employees += 1
                                }
                                customButton(text: "Hire 10: $100", color: getColor(userManager.accentColor), width: (screenWidth-20)/2, height: 40) {
                                    
                                }
                            }
                        }
                        .transition(.slide)
                    }
                }
                .frame(width: screenWidth-20, alignment: .leading)
                VStack (alignment: .leading){
                    HStack {
                        Text("Employees: \(employees)")
                        Spacer()
                        Group {
                            Text("Show")
                            Image(systemName: "chevron.right")
                        }
                        .onTapGesture {
                            withAnimation(.linear){
                                showEmployees.toggle()
                            }
                        }
                    }
                    
                    if showInvestors {
                        Group {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: screenWidth-20, height: 120)
                                .foregroundStyle(userManager.secondaryColor)
                                .overlay {
                                    VStack (alignment: .leading){
                                        Text("Each Employee produces: $1")
                                        Text("\(employees) earning $\(employees * 1)/s")
                                    }
                                    .frame(width: screenWidth-30, alignment: .leading)
                                }
                            
                            HStack {
                                customButton(text: "Hire 1: $10", color: getColor(userManager.accentColor), width: (screenWidth-20)/2, height: 40) {
                                    employees += 1
                                }
                                customButton(text: "Hire 10: $100", color: getColor(userManager.accentColor), width: (screenWidth-20)/2, height: 40) {
                                    
                                }
                            }
                        }
                        .transition(.move(edge: .leading).combined(with: .opacity))
                    }
                }
                .frame(width: screenWidth-20, alignment: .leading)
                
                Spacer()
                
                customButton(text: "Click Me", color: getColor(userManager.accentColor), width: 150, height: 50) {
                    cash += cashPerClick
                }
            }
            .foregroundStyle(userManager.textColor)
            .frame(width: screenWidth-20)
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    cash += cashPerSecond
                } else {
                    timer.connect().cancel()
                    // Game over logic here if needed
                }
            }
        }
    }
}

#Preview {
    Clicker()
        .environmentObject(UserManager())
}
