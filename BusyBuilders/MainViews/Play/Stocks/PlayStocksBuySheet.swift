//
//  PlayStocksBuySheet.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 08/08/2025.
//

import SwiftUI
import SwiftData

struct PlayStocksBuySheet: View {
    @Query var users: [UserDataModel]
    @EnvironmentObject var userManager: UserManager
    let stock: Stock
    
    @State var amount = 0
    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    VStack (alignment: .leading){
                        Text("Name: \(stock.name ?? "")")
                        Text("Price: $\(stock.price ?? 0.0, specifier: "%.2f")")
                    }
                    Spacer()
                    VStack {
                        TextField("Amount", value: $amount, format: .number)
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 100)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.black)
                    }
                }

                if let price = stock.price {
                    let rawCost = Double(amount) * price
                    let totalCost = ceil(rawCost)
                    let tax = totalCost - rawCost
                    
                    Text("Tax: $\(tax, specifier: "%.2f")")
                    Text("Total Cost: $\(totalCost, specifier: "%.0f")")
                }

                HStack {
                    customButton(text: "Buy Stock", color: getColor(userManager.accentColor), width: screenWidth-30, height: 40) {
                        if let price = stock.price, let user = users.first {
                            let rawCost = Double(amount) * price
                            let totalCost = Int(ceil(rawCost))
                            
                            if user.availableBalance >= totalCost {
                                user.availableBalance -= totalCost
                                // Update stocksOwned dictionary
                                if let stockName = stock.name {
                                    user.stocksOwned[stockName, default: 0] += amount
                                }
                                
                                print("Bought \(amount) shares of \(stock.name ?? "") for $\(totalCost)")
                            } else {
                                print("Insufficient funds")
                            }
                        }
                    }
                    customButton(text: "Sell Stock", color: getColor(userManager.accentColor), width: screenWidth-30, height: 40) {
                        if let price = stock.price, let user = users.first, let stockName = stock.name {
                            let ownedAmount = user.stocksOwned[stockName] ?? 0
                            
                            if ownedAmount >= amount && amount > 0 {
                                let rawRefund = Double(amount) * price
                                let totalRefund = Int(ceil(rawRefund))
                                
                                let newAmount = ownedAmount - amount
                                if newAmount == 0 {
                                    user.stocksOwned.removeValue(forKey: stockName)
                                } else {
                                    user.stocksOwned[stockName] = newAmount
                                }
                                
                                user.availableBalance += totalRefund
                                
                                print("Sold \(amount) shares of \(stockName) for $\(totalRefund)")
                            } else {
                                print("Insufficient stock amount to sell")
                            }
                        }
                    }
                }
            }
            .foregroundStyle(userManager.textColor)
            .frame(width: screenWidth-20, height: 300, alignment: .leading)
        }
    }
}

#Preview {
    PlayStocksBuySheet(stock: Stock(id: "12345643454325", name: "MonNRG", price: 10.5, change: "0.4", percentChange: "4", lastUpdated: "", averageChange: "4.5"))
        .environmentObject(UserManager())
}
