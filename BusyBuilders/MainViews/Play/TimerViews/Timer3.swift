//
//  Timer3.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/11/2024.
//

import SwiftUI
import SwiftData

struct Timer3: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.verticalSizeClass) var heightSizeClass : UserInterfaceSizeClass?
    @Query var businesses: [BusinessDataModel]
    @Environment(\.modelContext) var context
    
    @State var selectedBusiness : BusinessDataModel
    
    @State var showEnd = false
    
    @State var setTime : Int
    @State var timeElapsed = 0
    
    // Upgrades
    @State var isXPBoosterActive : Bool
    @State var isCashBoosterActive : Bool
    @State var isCostReductionActive : Bool
    
    // Other
    @State var timeStarted = ""
    @State var timeCompleted = ""
    @Binding var isTimerActive : Bool
    @State var isTimeCounting = false
    let currentDate = getDateComponents(from: Date())
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    
    var body: some View {
        ZStack {
            themeManager.textColor
                .ignoresSafeArea()
            
            VStack (spacing: 50){
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 100, height: 100)
                    .foregroundStyle(getColor(themeManager.secondaryColor))
                    .overlay {
                        VStack {
                            Text("\(currentDate[1].uppercased())")
                            Text("\(currentDate[0])")
                                .font(.system(size: 25))
                                .bold()
                        }
                        .foregroundStyle(themeManager.textColor)
                    }
                    .padding(.top, 150)
                    .shadow(color: Color.teal, radius: 30)
                    .onTapGesture {
                        isTimerActive.toggle()
                    }
//                    .shadow(color: Color.green, radius: 25)
//                    .shadow(color: Color.teal, radius: 35)
                
                VStack (alignment: .center){
                    Text("\(currentDate[3].uppercased())")
                        .kerning(9)
                    .bold()
                    Text("SUNNY SHOWERS")
                        .kerning(4)
                        .font(.system(size: 10))
                    
                    HStack (spacing: 35){
                        HStack (spacing: 2){
                            Image(systemName: "thermometer")
                                .foregroundStyle(getColor("purple"))
                            Text("14°C")
                        }
                        .font(.system(size: 12))
                        HStack (spacing: 2){
                            Image(systemName: "wind")
                                .foregroundStyle(getColor("blue"))
                            Text("\(timeElapsed) m/s")
                        }
                        .font(.system(size: 12))
                        HStack (spacing: 2){
                            Image(systemName: "umbrella")
                                .foregroundStyle(getColor("pink"))
                            Text("12mm")
                        }
                        .font(.system(size: 12))
                    }
                    .padding(.top, 25)
                    
                    Text("\(currentDate[4])")
                        .font(.system(size: 15))
                        .padding(.top, 25)
                        .bold()
                }
                .frame(alignment: .center)
                
                
                VStack (spacing: 5){
                    Text("\((Double(timeElapsed) / 3600.0) * 100, specifier: "%.0f")%")
                        .font(.system(size: 12))
                    ZStack (alignment: .leading){
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: screenWidth-30, height: 20)
                            .foregroundStyle(getColor(themeManager.secondaryColor))
                        
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: (CGFloat(timeElapsed) / 3600)*(screenWidth-40), height: 10)
                            .foregroundStyle(getColor("white"))
                            .padding(.horizontal, 5)
                    }
                }
                
                Text("$\((selectedBusiness.cashPerMin/60) * timeElapsed)")
                    .font(.system(size: 60))
                
                
                HStack (spacing: 30){
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 120, height: 40)
                        .overlay {
                            Text("Pause")
                                .foregroundStyle(themeManager.textColor)
                        }
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 120, height: 40)
                        .overlay {
                            Text("Clock-Out")
                                .foregroundStyle(themeManager.textColor)
                        }
                        .onTapGesture {
                            isTimeCounting.toggle()
                            let totalIncomeCalculated = calculateEarnings(timeElapsed, selectedBusiness, false, false, false)[2]
                            let totalCostCalculated = calculateEarnings(timeElapsed, selectedBusiness, false, false, false)[1]
                            let totalXPCalculated = calculateEarnings(timeElapsed, selectedBusiness, false, false, false)[0]
//                            print("XP: \(calculateEarnings(timeElapsed, selectedBusiness, false, false, false)[0])")
//                            print("Cost: \(calculateEarnings(timeElapsed, selectedBusiness, false, false, false)[1])")
//                            print("Income: \(calculateEarnings(timeElapsed, selectedBusiness, false, false, false)[2])")
                            
                            selectedBusiness.netWorth += (totalIncomeCalculated - totalCostCalculated)
                            selectedBusiness.businessLevel += totalXPCalculated
                            selectedBusiness.time += timeElapsed
                            
                            let newSession = SessionDataModel(id: UUID(), sessionDate: Date(), sessionStart: "", sessionEnd: "", businessId: selectedBusiness.id)
//
                            selectedBusiness.sessionHistory.append(newSession)
                            
                            do {
                                try context.save()
                            } catch {
                                print("Couldnt update business")
                            }
                            
                            showEnd.toggle()
                            
                        }
                }
                .frame(width: screenWidth-30)
                .foregroundStyle(getColor(themeManager.secondaryColor))
                
                Spacer()
            }
            .foregroundStyle(themeManager.mainColor)
        }
        .onAppear {
            timeStarted = formatFullDateTime(date: Date())
            isTimeCounting.toggle()
        }
        .onReceive(timer) { time in
            guard isTimeCounting else {return}
            
            timeElapsed += 1
        }
        .onChange(of: scenePhase){
            if scenePhase == .active {
                isTimeCounting = true
            } else {
                isTimeCounting = false
            }
        }
        .sheet(isPresented: $showEnd) {
            VStack {
                Text("\(selectedBusiness.businessName)")
                
                Text("$\(selectedBusiness.netWorth)")
                Text("\(selectedBusiness.businessLevel)")
                
                Text("XP: \(calculateEarnings(timeElapsed, selectedBusiness, false, false, false)[0])")
                Text("Cost: $\(calculateEarnings(timeElapsed, selectedBusiness, false, false, false)[1])")
                Text("Income: $\(calculateEarnings(timeElapsed, selectedBusiness, false, false, false)[2])")
                
                
                
                Button("Done") {
                    isTimerActive.toggle()
                }
            }
            .presentationDetents([.fraction(0.50)])
        }
    }
    
    public func calculateEarnings(_ timeElapsed: Int, _ business: BusinessDataModel, _ XPA: Bool, _ CBA: Bool, _ CRA: Bool) -> [Int] {
        let cashPerMin = business.cashPerMin
        let costPerMin = business.costPerMin

        // Convert timeElapsed to minutes
        let timeElapsedInMinutes = Double(timeElapsed) / 60

        // Base calculations
        var totalIncome = Double(cashPerMin) * timeElapsedInMinutes
        var totalCost = Double(costPerMin) * timeElapsedInMinutes
        var totalXP = timeElapsedInMinutes

        // Apply upgrades
        if CBA {
            totalIncome *= 1.5 // 50% more income
        }
        if CRA {
            totalCost *= 0.5 // 50% less cost
        }
        if XPA {
            totalXP *= 1.5 // 50% more XP
        }

        return [
            Int(totalXP.rounded()), // Round to nearest Int for XP
            Int(totalCost.rounded()), // Round to nearest Int for cost
            Int(totalIncome.rounded()) // Round to nearest Int for income
        ]
    }
}

#Preview {
    Timer3(selectedBusiness: BusinessDataModel(businessName: "Cozy Coffee", businessTheme: "red", businessType: "Eco-Friendly", businessIcon: "triangle"), setTime: 0, isXPBoosterActive: false, isCashBoosterActive: false, isCostReductionActive: false, isTimerActive: .constant(false))
        .environmentObject(ThemeManager())
        .modelContainer(for: UserDataModel.self)
}
