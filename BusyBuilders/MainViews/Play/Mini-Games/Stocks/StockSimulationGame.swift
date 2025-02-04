//
//  StockSimulationGame.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 03/01/2025.
//


import SwiftUI
import SwiftData
import Charts

struct StockSimulationGame: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Query var users : [UserDataModel]
    @Environment(\.modelContext) var context
    @Binding var isGameOver : Bool
    @Binding var price : Double
    @State var stockPrice: [Double] = [100.0]
    @State var currentWeek = 0
    @State var stocksBought : Int
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: screenWidth-20, height: 400)
                .foregroundStyle(getColor(themeManager.mainDark))
                .overlay {
                    VStack {
                        
                        Text("$\(price, specifier: "%.2f")")
                            .font(.system(size: 30))
                        
                        // LineGraphView - Displaying the stock price over time
                        LineGraphView(stockPrice: $stockPrice)
                            .frame(height: 200)
                            .padding()

                        Spacer()
                        Text("Current Week: \(currentWeek)")
                        HStack {
                            Button("Simulate Week") {
                                let num = randomNumber(in: 1...3)
                                if num == 1 {
                                    if randomNumber(in: 0...20) == 1 {
                                        price = 0
                                    } else {
                                        price *= Double.random(in: 0.3...0.9)
                                    }
                                } else if num == 2 {
                                    price += 0
                                } else if num == 3 {
                                    if randomNumber(in: 0...20) == 1 {
                                        price *= 3
                                    } else {
                                        price *= Double.random(in: 1.1...1.9)
                                    }
                                }
                                
                                // Add the updated price to stockPrice array
                                stockPrice.append(price)
                                currentWeek += 1
                            }
                            .disabled(price == 0  || currentWeek == 52 || isGameOver == true)
                            .frame(width: 120, height: 50)
                            .foregroundStyle(themeManager.textColor)
                            .background(themeManager.mainColor)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Button("Cash Out") {
                                
                                if let user = users.first {
                                    let newTransaction = TransactionDataModel(amount: Int(price) * stocksBought, transactionDescription: "Stocks Investment Payout", createdAt: Date(), income: true)
                                    user.transactions.append(newTransaction)
                                    do {
                                        try context.save()
                                    } catch {
                                        print("Error: Couldnt save new Stocks transaction for mini-game")
                                    }
                                }
                                print("Cashed Out")
                                isGameOver = true
                            }
                            .frame(width: 120, height: 50)
                            .foregroundStyle(themeManager.textColor)
                            .background(getColor("green"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding(10)
                }
                .foregroundStyle(themeManager.textColor)
        }
    }
}

struct LineGraphView: View {
    @Binding var stockPrice: [Double]
    
    var body: some View {
        Chart {
            ForEach(stockPrice.indices, id: \.self) { index in
                LineMark(
                    x: .value("Week", index),
                    y: .value("Price", stockPrice[index])
                )
                .interpolationMethod(.monotone)
                .foregroundStyle(.red)
            }
        }
        .chartXAxis {
            AxisMarks(values: .automatic) {
                AxisValueLabel()
                    .foregroundStyle(Color.white) // Change the style of the label
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading) {
                AxisValueLabel()
                    .foregroundStyle(Color.white) // Change the style of the label
            }
        }
        .chartPlotStyle { plotArea in
            plotArea.background(.clear) // Ensure no background lines
        }
        .frame(height: 200)
        .padding()
    }
}

#Preview {
    StockSimulationGame(isGameOver: .constant(false), price: .constant(100.0), stocksBought: 0)
        .environmentObject(ThemeManager())
}
