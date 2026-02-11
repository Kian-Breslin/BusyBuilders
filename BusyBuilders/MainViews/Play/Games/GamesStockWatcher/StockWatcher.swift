//
//  StockWatcher.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 25/01/2026.
//

import SwiftUI
import Charts

struct WeeklyData: Identifiable {
    let id = UUID()
    var week: Int
    var value: Double
}

struct StockWatcher: View {
    @EnvironmentObject var userManager: UserManager
    @Environment(\.dismiss) var dismiss
    @State var currentWeek = 1
    @State var stockPrice = 10.0
    @State var startingTotal = 1.0
    @State var volitility = "Low"
    @State var selectedStock: StockWatcherItem = StockWatcherItem(icon: "🍏", price: 1.0)
    @State var amountToBuy: Double = 1.0
    
    @State var sampleData: [WeeklyData] = []
    
    @State var showSettings: Bool = true
    
    var body: some View {
        ZStack {
            userManager.mainColor.ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Quit")
                        .underline()
                        .onTapGesture {
                            dismiss()
                        }
                    Spacer()
                    
                    Image(systemName: "gear")
                }
                .font(.system(size: 25))
                .foregroundStyle(getColor(userManager.accentColor))
                
                VStack (alignment: .leading){
                    HStack {
                        Label("$\(stockPrice, specifier: "%.2f")", systemImage: "chart.line.flattrend.xyaxis")
                        Spacer()
                        Label("$\(selectedStock.price, specifier: "%.2f")", systemImage: "chart.line.uptrend.xyaxis")
                        
                    }
                    HStack {
                        Label("$\(startingTotal, specifier: "%.2f")", systemImage: "cart")
                        Spacer()
                        Label("$\(amountToBuy*selectedStock.price, specifier: "%.2f")", systemImage: "creditcard")
                    }
                }
//                Text("Showing: \(showSettings)")
                Spacer()
                
                Chart(sampleData) { data in
                    LineMark(
                        x: .value("Week", data.week),
                        y: .value("Value", data.value)
                    )
                    .foregroundStyle(.red)
                }
                .chartXAxis {
                    AxisMarks(values: .automatic) { value in
                        AxisValueLabel()
                            .foregroundStyle(.white) // Make sure labels are visible
                    }
                }
                .chartYAxis {
                    AxisMarks(position: .leading,values: .automatic) { value in
                        AxisValueLabel()
                            .foregroundStyle(.white) // Make sure labels are visible
                    }
                }
                .frame(width: screenWidth-20, height: 250)
                
                Spacer()
                
                customButton(text: "Next Week", color: .red, width: 150, height: 50) {
                    selectedStock.price = changeStockPrice(volitility: volitility, stockPrice: selectedStock.price)
                    
                    
                    sampleData.append(WeeklyData(week: currentWeek, value: selectedStock.price))
                    currentWeek += 1
                }
            }
            .foregroundStyle(userManager.textColor)
            .frame(width: screenWidth-20)
        }
        .onChange(of: showSettings, { oldValue, newValue in
            stockPrice = selectedStock.price
            startingTotal = selectedStock.price * amountToBuy
            sampleData.append(WeeklyData(week: 0, value: stockPrice))
        })
        .sheet(isPresented: $showSettings){
            StockWatcherSettings(volitility: $volitility, selectedStock: $selectedStock, amountToBuy: $amountToBuy)
                .presentationDetents([.fraction(0.5)])
        }
    }
}

func changeStockPrice(volitility: String, stockPrice: Double) -> Double {
    switch volitility {
    case "Low":
        let upOrDown = Bool.random()
        if upOrDown {
            return stockPrice * Double.random(in: 1.0..<1.2)
        }
        else {
            return stockPrice * Double.random(in: 0.8..<1.0)
        }
    case "Medium":
        let upOrDown = Bool.random()
        if upOrDown {
            return stockPrice * Double.random(in: 1.4..<1.6)
        }
        else {
            return stockPrice * Double.random(in: 0.4..<0.6)
        }
    case "High":
        let upOrDown = Bool.random()
        if upOrDown {
            return stockPrice * Double.random(in: 2.0..<5.0)
        }
        else {
            return stockPrice * Double.random(in: 0.0..<1.0)
        }
    default:
        return stockPrice
    }
}

struct StockWatcherSettings: View {
    @Environment(\.dismiss) var dismiss
    @Binding var volitility: String
    @Binding var selectedStock: StockWatcherItem
    @Binding var amountToBuy: Double
    
    
    let types: [(id: String, type: String, label: String)] = [
        ("Low", "Low", "circle"),
        ("Medium", "Medium", "square"),
        ("High", "High", "triangle")
    ]
    
    let lowStocks: [StockWatcherItem] = [
        StockWatcherItem(icon: "🍏", price: 1.20),
        StockWatcherItem(icon: "🍋", price: 2.50),
        StockWatcherItem(icon: "🍇", price: 3.10),
        StockWatcherItem(icon: "🍒", price: 4.75),
        StockWatcherItem(icon: "🥝", price: 1.90)
    ]

    // Medium range ($5–$25)
    let mediumStocks: [StockWatcherItem] = [
        StockWatcherItem(icon: "🍉", price: 7.50),
        StockWatcherItem(icon: "🍊", price: 12.30),
        StockWatcherItem(icon: "🍌", price: 15.80),
        StockWatcherItem(icon: "🥭", price: 20.40),
        StockWatcherItem(icon: "🍍", price: 9.90)
    ]

    // High range ($25–$50+)
    let highStocks: [StockWatcherItem] = [
        StockWatcherItem(icon: "🥑", price: 28.50),
        StockWatcherItem(icon: "🍎", price: 33.20),
        StockWatcherItem(icon: "🍐", price: 42.75),
        StockWatcherItem(icon: "🍓", price: 50.10),
        StockWatcherItem(icon: "🍈", price: 27.80)
    ]
    
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading){
                    Text("Stock Watcher")
                        .font(.largeTitle)
                    Text("Total Cost: $\(amountToBuy*selectedStock.price, specifier: "%.2f")" )
                        .font(.caption)
                }
                Spacer()
                Button("Hide"){
                    dismiss()
                }
            }
            
            HStack {
                ForEach(types, id: \.id){ type in
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(type.id == volitility ? getColor(UserManager().accentColor) : getColor(UserManager().accentColor).opacity(0.3))
                        .frame(width: (screenWidth-40)/3, height: 40)
                        .overlay {
                            HStack {
                                Image(systemName: type.label)
                                Text("\(type.type)")
                            }
                            .foregroundStyle(UserManager().textColor)
                        }
                        .onTapGesture {
                            withAnimation(.bouncy){
                                volitility = type.id
                            }
                        }
                }
            }
            
            VStack (alignment: .leading, spacing: 5){
                Text("Cost: $\(selectedStock.price, specifier: "%.2f")")
                    .font(.caption)
                if volitility == "Low" {
                    HStack {
                        ForEach(lowStocks, id: \.icon){ stock in
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(stock.icon == selectedStock.icon ? getColor(UserManager().accentColor) : getColor(UserManager().accentColor).opacity(0.3))
                                .frame(width: (screenWidth-55)/5, height: 40)
                                .overlay {
                                    Text(stock.icon)
                                }
                                .onTapGesture {
                                    withAnimation(.bouncy){
                                        selectedStock = stock
                                    }
                                }
                        }
                    }
                }
                else if volitility == "Medium" {
                    HStack {
                        ForEach(mediumStocks, id: \.icon){ stock in
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(stock.icon == selectedStock.icon ? getColor(UserManager().accentColor) : getColor(UserManager().accentColor).opacity(0.3))
                                .frame(width: (screenWidth-55)/5, height: 40)
                                .overlay {
                                    Text(stock.icon)
                                }
                                .onTapGesture {
                                    withAnimation(.bouncy){
                                        selectedStock = stock
                                    }
                                }
                        }
                    }
                }
                else if volitility == "High" {
                    HStack {
                        ForEach(highStocks, id: \.icon){ stock in
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(stock.icon == selectedStock.icon ? getColor(UserManager().accentColor) : getColor(UserManager().accentColor).opacity(0.3))
                                .frame(width: (screenWidth-55)/5, height: 40)
                                .overlay {
                                    Text(stock.icon)
                                }
                                .onTapGesture {
                                    withAnimation(.bouncy){
                                        selectedStock = stock
                                    }
                                }
                        }
                    }
                }
            }
            
            VStack (alignment: .leading, spacing: 5){
                Text("Amount: \(amountToBuy, specifier: "%.f")")
                    .font(.caption)
                Slider(value: $amountToBuy, in: 1...100, step: 1)
            }
            customButton(text: "Invest", color: getColor(UserManager().accentColor), width: 100, height: 40) {
                dismiss()
            }
        }
        .padding(20)
    }
}

struct StockWatcherItem {
    var icon: String
    var price: Double
}

#Preview {
    StockWatcher()
        .environmentObject(UserManager())
}
