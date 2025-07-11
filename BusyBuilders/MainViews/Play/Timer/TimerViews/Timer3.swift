//
//  Timer3.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 19/11/2024.
//

import SwiftUI
import SwiftData
import AVFoundation

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
    
    // Other
    @State var timeStarted = ""
    @State var timeCompleted = ""
    @Binding var isTimerActive : Bool
    @State var isTimeCounting = false
    let currentDate = getDateComponents(from: Date())
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    @StateObject private var audioManager = AudioManager()
    
    
    
    var body: some View {
        ZStack {
//            RainTimer()
            
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
                
                Text("$\(Int((Double(selectedBusiness.cashPerMin) / 60.0) * Double(timeElapsed)))")
                    .font(.system(size: 60))
                
                
                HStack (spacing: 30){
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 120, height: 40)
                        .overlay {
                            Text(isTimeCounting ? "Pause" : "Play")
                                .foregroundStyle(themeManager.textColor)
                        }
                        .onTapGesture {
                            isTimeCounting.toggle()
//                            audioManager.audioPlayer?.pause()
                        }
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 120, height: 40)
                        .overlay {
                            Text("Clock-Out")
                                .foregroundStyle(themeManager.textColor)
                        }
                        .onTapGesture {
                            isTimeCounting.toggle()
                            
                            let calculations = calculateEarnings(timeElapsed, selectedBusiness)
                            let totalIncomeCalculated = calculations["totalIncome"] as? Int ?? 0
                            let totalCostCalculated = calculations["totalCost"] as? Int ?? 0
                            let totalXPCalculated = calculations["totalXP"] as? Int ?? 0
                            print(totalXPCalculated)
                            
                            if let user = users.first {
//                                user.availableBalance += (totalIncomeCalculated - totalCostCalculated)
                                user.level += totalXPCalculated
                                print("\(user.level)")
                                
                                let newTransaction = TransactionDataModel(category: "Session Income", amount: (totalIncomeCalculated - totalCostCalculated), transactionDescription: "Session Income", createdAt: Date(), income: true)
                                
                                user.transactions.append(newTransaction)
                            }
                            else {
                                print("No USer Found ????")
                            }
                            selectedBusiness.netWorth += (totalIncomeCalculated - totalCostCalculated)
                            
                            selectedBusiness.time += timeElapsed
                            
                            let newSession = SessionDataModel(id: UUID(), sessionDate: Date(), sessionStart: "", sessionEnd: "", businessId: selectedBusiness.id, totalCashEarned: totalIncomeCalculated, totalCostIncurred: totalCostCalculated, totalXPEarned: totalXPCalculated, totalStudyTime: timeElapsed, productRevenue: calculations["totalProductsSold"] as? Int ?? 0)

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
//            audioManager.playSound(named: "CalmingRainSound")
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
            .presentationDetents([.fraction(0.55)])
            .interactiveDismissDisabled()
        }
    }
}

struct showSessionStats: View {
    @State var selectedBusiness : BusinessDataModel
    @State var timeElapsed : Int
    @Binding var isTimerActive : Bool
    @State private var earnings: [String: Any] = [:]
    @State private var elapsedTime = 0
    let statsTimer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            ThemeManager().mainColor.ignoresSafeArea()
            VStack (alignment: .leading, spacing: 10){
                let income = earnings["totalIncome"] as? Int ?? 0
                let cost = earnings["totalCost"] as? Int ?? 0
                let total = income - cost
                
                Text("\(selectedBusiness.businessName)")
                    .font(.system(size: 30))
                
                HStack {
                    Text("Net Worth: $\(selectedBusiness.netWorth)")
                    Spacer()
                    Text("Business Level: \(selectedBusiness.businessLevel)")
                }
                
                HStack {
                    let incomeMultiplier = earnings["incomeMultiplier"] as? Double ?? 1.0
                    let incomeBoostText = incomeMultiplier == 1.0 ? "0%" : "\(Int((incomeMultiplier - 1) * 100))%"
                    littleInfoBox(boxTitle: "Income Boost: ", boxInfo: "\(incomeBoostText)")
                        .opacity(elapsedTime >= 1 ? 1 : 0)
                        .animation(.easeInOut, value: elapsedTime)
                    let costMultiplier = earnings["costMultiplier"] as? Double ?? 1.0
                    let costReductionText = "\(Int(costMultiplier * 100))%"
                    littleInfoBox(boxTitle: "Cost Reduction: ", boxInfo: "\(costReductionText)")
                        .opacity(elapsedTime >= 2 ? 1 : 0)
                        .animation(.easeInOut, value: elapsedTime)
                }
                
                
                HStack {
                    littleInfoBox(boxTitle: "Experience :", boxInfo: "\(earnings["totalXP"] as? Int ?? 0)")
                        .opacity(elapsedTime >= 3 ? 1 : 0)
                        .animation(.easeInOut, value: elapsedTime)

                    littleInfoBox(boxTitle: "Income :", boxInfo: "$\(earnings["totalIncome"] as? Int ?? 0)")
                        .opacity(elapsedTime >= 4 ? 1 : 0)
                        .animation(.easeInOut, value: elapsedTime)
                }
                HStack {
                    littleInfoBox(boxTitle: "Cost :", boxInfo: "$\(earnings["totalCost"] as? Int ?? 0)")
                        .opacity(elapsedTime >= 5 ? 1 : 0)
                        .animation(.easeInOut, value: elapsedTime)
                    littleInfoBox(boxTitle: "Total Income: ", boxInfo: "$\(total)")
                        .opacity(elapsedTime >= 6 ? 1 : 0)
                        .animation(.easeInOut, value: elapsedTime)
                }
                
                HStack {
                    littleInfoBox(boxTitle: "Cost :", boxInfo: "\(selectedBusiness.products.filter({$0.isActive == true}).count)")
                        .opacity(elapsedTime >= 7 ? 1 : 0)
                        .animation(.easeInOut, value: elapsedTime)
                    littleInfoBox(boxTitle: "Products", boxInfo: "$\(earnings["totalProductsSold"] as? Int ?? 0)")
                        .opacity(elapsedTime >= 8 ? 1 : 0)
                        .animation(.easeInOut, value: elapsedTime)
                }
                

                
                
                HStack {
                    Spacer()
                    Button("Done") {
                        isTimerActive.toggle()
                    }
                    .disabled(elapsedTime <= 7)
                    .frame(width: 120, height: 50)
                    .background(getColor(ThemeManager().secondaryColor))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .font(.system(size: 25))
                    .opacity(elapsedTime >= 7 ? 1 : 0.5)
                    
                    Spacer()
                }
            }
            .foregroundStyle(ThemeManager().textColor)
            .frame(width: screenWidth-20)
        }
        .onAppear {
            earnings = calculateEarnings(timeElapsed, selectedBusiness)
        }
        .onReceive(statsTimer) { _ in
            if elapsedTime < 10 {
                elapsedTime += 1
            }
        }
    }
}

func calculateEarnings(_ timeElapsed: Int, _ business: BusinessDataModel) -> [String: Any] {
    let cashPerMin = business.cashPerMin
    let costPerMin = business.costPerMin

    let timeElapsedInMinutes = Double(timeElapsed) / 60

    // Department levels
    let FLevel = business.departmentLevels["Finance"] ?? 0
    let OLevel = business.departmentLevels["Operations"] ?? 0
    let HLevel = business.departmentLevels["HR"] ?? 0
    let RLevel = business.departmentLevels["R&D"] ?? 0
    let MLevel = business.departmentLevels["Marketing"] ?? 0
    
    func getDiscount(num: Int) -> Int {
        return min((num / 10), 10)
    }
    
    func productCalculations() -> Int {
        var totalAmountSold = 0
        
        for product in business.products.filter({($0.isActive == true)}) {
            let stockAvailable = product.quantity
            let randomStockSold = Int.random(in: 0..<stockAvailable)
            print(randomStockSold)
            
            product.quantity -= randomStockSold
            product.soldHistory.append(randomStockSold)
            totalAmountSold += product.pricePerUnit * randomStockSold
            product.totalSalesIncome += totalAmountSold
            print(totalAmountSold)
        }
        
        return totalAmountSold
    }
    
    // Department multipliers
    let financeDiscount = getDiscount(num: FLevel)
    let hrDiscount = getDiscount(num: HLevel)
    let combinedCostMultiplier = Double(financeDiscount + hrDiscount) / 100.0

    let incomeMultiplier = 1.0 + Double(OLevel) * 0.02
    let xpMultiplier = 1.0 + Double(RLevel) * 0.01 + Double(MLevel) * 0.015

    // Apply multipliers
    let totalIncome = Double(cashPerMin) * timeElapsedInMinutes * incomeMultiplier
    let totalCost = Double(costPerMin) * timeElapsedInMinutes * (1 - combinedCostMultiplier)
    let totalXP = timeElapsedInMinutes * xpMultiplier
    let totalProductsSold = productCalculations()

    return [
        "totalXP": Int(totalXP.rounded()),
        "totalCost": Int(totalCost.rounded()),
        "totalIncome": Int(totalIncome.rounded()),
        "xpMultiplier": xpMultiplier,
        "costMultiplier": combinedCostMultiplier,
        "incomeMultiplier": incomeMultiplier,
        "totalProductsSold": totalProductsSold
    ]
}

struct littleInfoBox: View {
    let boxWidth = (screenWidth-30)/2
    let boxHeight = 80
    let boxColor = getColor(ThemeManager().mainDark)
    let boxTitle : String
    let boxInfo : String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: CGFloat(boxWidth), height: CGFloat(boxHeight))
            .foregroundStyle(boxColor)
            .overlay {
                VStack (alignment: .leading, spacing: 10){
                    Text(boxTitle)
                    Text(boxInfo)
                }
                .font(.system(size: 25))
                .padding(5)
                .frame(width: CGFloat(boxWidth), alignment: .leading)
            }
    }
}

//#Preview {
//    showSessionStats(selectedBusiness: BusinessDataModel(businessName: "Cozy Coffee", businessTheme: "red", businessType: "Eco-Friendly", businessIcon: "triangle", netWorth: 300000), timeElapsed: 3600, isTimerActive: .constant(false))
//}


#Preview {
    Timer3(selectedBusiness: BusinessDataModel(businessName: "Cozy Coffee", businessTheme: "red", businessType: "Eco-Friendly", businessIcon: "triangle"), setTime: 0, isTimerActive: .constant(false))
        .environmentObject(ThemeManager())
        .modelContainer(for: UserDataModel.self)
}
