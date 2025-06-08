//
//  CompanyView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 01/06/2025.
//

import SwiftUI
import SwiftData
import Charts

struct CompanyView: View {
    @Query var users : [UserDataModel]
    @EnvironmentObject var themeManager: ThemeManager
    let company : CompanyDataModel
    @State var showBuyScreen = false
    
    
    // Computed property to find the owned amount for this company
    var ownedAmount: Int {
        if let user = users.first {
            return user.stocks.first(where: { $0.id == company.id })?.amount ?? 0
        }
        return 0
    }
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            ScrollView {
                VStack (spacing: 15){
                    Image(systemName: company.icon)
                        .font(.system(size: 80))
                    Text(company.name)
                        .font(.system(size: 30))
                    
                    VStack (alignment: .leading, spacing: 15){
                        Text("Current Price: $\(company.stockPrice)")
                        Text("Stock Remaining: \(company.stocksAvailable)")
                        
                        if let user = users.first {
                            let ownedAmount = user.stocks.first(where: { $0.id == company.id })?.amount ?? 0
                            Text("You Own: \(ownedAmount) shares")
                        }
                        
                        Text("Stock History:")
                    }
                    .font(.system(size: 25))
                    .frame(width: screenWidth-20, alignment: .leading)
                    
                    
                    // Chart below the details
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: screenWidth-20, height: 200)
                        .foregroundStyle(themeManager.textColor)
                        .overlay {
                            let chartData = company.stockHistory.enumerated().map { StockDataPoint(day: $0.offset + 1, price: $0.element) }
                            Chart(chartData) {
                                LineMark(
                                    x: .value("Day", $0.day),
                                    y: .value("Price", $0.price)
                                )
                                .interpolationMethod(.catmullRom)
                                .lineStyle(.init(lineWidth: 3))
                                .foregroundStyle(getColor(themeManager.secondaryColor))
                            }
                            .chartXAxis {
                                AxisMarks(values: chartData.map { $0.day}) { day in
                                    AxisValueLabel(centered: true)
                                        .foregroundStyle(themeManager.mainColor)
                                }
                            }
                            .chartYAxis {
                                AxisMarks(position: .leading) { value in
                                    AxisValueLabel()
                                        .foregroundStyle(themeManager.mainColor)
                                }
                            }
                            .frame(height: 150)
                            .padding()
                    }
                    
                    Button("Buy Stock"){
                        showBuyScreen.toggle()
                    }
                }
                .foregroundStyle(themeManager.textColor)
            }
        }
        .sheet(isPresented: $showBuyScreen) {
            if users.first != nil{
                BuyScreen(comp: company)
                    .presentationDetents([.fraction(0.3)])
            }
        }
    }
}
struct BuyScreen: View {
    @Environment(\.modelContext) var context
    @Query var Users : [UserDataModel]
    @State var amount = 1
    let comp : CompanyDataModel
    
    var body: some View {
        VStack(spacing: 20) {
            if let user = Users.first {
                Text("Available Balance: $\(user.availableBalance)")
                    .font(.system(size: 20))
            }
            
            Stepper("Quantity: \(amount)", value: $amount, in: 1...comp.stocksAvailable)
            
            Text("Total: $\(amount * comp.stockPrice)")
                .font(.subheadline)
            
            Button("Buy") {
                let totalCost = amount * comp.stockPrice
                if let User = Users.first {
                    if User.availableBalance >= totalCost {
                        User.objectWillChange.send()
                        User.availableBalance -= totalCost
                        User.transactions.append(TransactionDataModel(amount: totalCost, transactionDescription: "Bought Stocks in \(comp.name)", createdAt: Date.now, income: false))
                        if let index = User.stocks.firstIndex(where: { $0.id == comp.id }) {
                            User.stocks[index].amount += amount
                        } else {
                            User.stocks.append(companyStocks(id: comp.id, company: comp, amount: amount))
                        }
                        do {
                            try context.save()
                            print("Saved")
                        } catch {
                            print("Failed to save user changes: \(error)")
                        }
                    }
                    else {
                        print("User doesnt have enough cash")
                    }
                }
                else {
                    print("No User")
                }
                print("User bought \(amount) shares of \(comp.name)")
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            Spacer()
        }
        .foregroundStyle(ThemeManager().textColor)
        .padding()
    }
}


struct StockDataPoint: Identifiable {
    let id = UUID()
    let day: Int
    let price: Int
}

#Preview {
    CompanyView(company: CompanyDataModel(id: UUID(), name: "Apple", location: "Los Angeles", icon: "apple.logo", stockPrice: 100, stocksAvailable: 10000, stockHistory: [115, 118, 120, 90, 100, 102, 130, 120, 110, 100, 90], stockVolatility: "medium"))
        .environmentObject(ThemeManager())
}
