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
    @Query var users : [UserDataModel]
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
            themeManager.mainColor
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
                            
                            let calculations = calculateEarnings(timeElapsed, selectedBusiness, isXPBoosterActive, isCashBoosterActive, isCostReductionActive)
                            let totalIncomeCalculated = calculations[2]
                            let totalCostCalculated = calculations[1]
                            let totalXPCalculated = calculations[0]
                            print(totalXPCalculated)
                            
                            if let user = users.first {
                                user.availableBalance += (totalIncomeCalculated - totalCostCalculated)
                                user.level += totalXPCalculated
                                print("\(user.level)")
                                
                                let newTransaction = TransactionDataModel(amount: (totalIncomeCalculated - totalCostCalculated), transactionDescription: "Session Income", createdAt: Date(), income: true)
                                
                                user.transactions.append(newTransaction)
                            }
                            else {
                                print("No USer Found ????")
                            }
//                            selectedBusiness.netWorth += (totalIncomeCalculated - totalCostCalculated)
                            selectedBusiness.businessLevel += totalXPCalculated
                            selectedBusiness.time += timeElapsed
                            
                            let newSession = SessionDataModel(id: UUID(), sessionDate: Date(), sessionStart: "", sessionEnd: "", businessId: selectedBusiness.id, totalCashEarned: totalIncomeCalculated, totalCostIncurred: totalCostCalculated, totalXPEarned: totalXPCalculated, totalStudyTime: timeElapsed)

                            selectedBusiness.sessionHistory.append(newSession)
                            
                            do {
                                try context.save()
                            } catch {
                                print("Couldnt update business")
                            }
                            
                            showEnd.toggle()
                            
                        }
                }
                .frame(width: screenWidth-20)
                .foregroundStyle(getColor(themeManager.secondaryColor))
                
                Spacer()
            }
            .foregroundStyle(themeManager.textColor)
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
            showSessionStats(selectedBusiness: selectedBusiness, timeElapsed: timeElapsed, isTimerActive: $isTimerActive)
            .presentationDetents([.fraction(0.50)])
        }
    }
}

struct showSessionStats: View {
    @State var selectedBusiness : BusinessDataModel
    @State var timeElapsed : Int
    @Binding var isTimerActive : Bool
    
    var body: some View {
        ZStack {
            ThemeManager().mainColor.ignoresSafeArea()
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
            .foregroundStyle(ThemeManager().textColor)
        }
    }
}

 func calculateEarnings(_ timeElapsed: Int, _ business: BusinessDataModel, _ XPA: Bool, _ CBA: Bool, _ CRA: Bool) -> [Int] {
    let cashPerMin = business.cashPerMin
    let costPerMin = business.costPerMin

    // Convert timeElapsed to minutes
    let timeElapsedInMinutes = Double(timeElapsed) / 60

    // Base calculations
    var totalIncome = Double(cashPerMin) * timeElapsedInMinutes
    var totalCost = Double(costPerMin) * timeElapsedInMinutes
    var totalXP = timeElapsedInMinutes
    
    print("Total XP: \(Int(totalXP.rounded()))")

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

#Preview {
    Timer3(selectedBusiness: BusinessDataModel(businessName: "Cozy Coffee", businessTheme: "red", businessType: "Eco-Friendly", businessIcon: "triangle"), setTime: 0, isXPBoosterActive: false, isCashBoosterActive: false, isCostReductionActive: false, isTimerActive: .constant(false))
        .environmentObject(ThemeManager())
        .modelContainer(for: UserDataModel.self)
}
