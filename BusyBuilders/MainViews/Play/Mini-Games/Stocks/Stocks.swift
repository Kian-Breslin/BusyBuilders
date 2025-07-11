//
//  Stocks.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 02/01/2025.
//

import SwiftUI
import SwiftData

struct Stocks: View {
    @EnvironmentObject var themeManager : ThemeManager
    @Environment(\.dismiss) private var dismiss
    @Binding var isTaskActive : Bool
    @State var isGameOver = false
    @State var showBusiness = true
    @State var selectedBusiness : mockBusinesses
    @State var stocksBought = 0
    @State var stockPrice = 0.0
    @State var dismissEverything = false
    
    var body: some View {
        ZStack {
            themeManager.mainColor
                .ignoresSafeArea()
            
            if showBusiness == false {
                if isGameOver == false {
                    StockSimulationView(isGameOver: $isGameOver, business: selectedBusiness, stocksBought: $stocksBought, stockPrice: $stockPrice)
                        .frame(width: screenWidth-20)
                        .onAppear {
                            isTaskActive = true
                        }
                        .navigationBarBackButtonHidden(true)
                }
                else {
                    gameOverScreen(business: $selectedBusiness, stockPrice: $stockPrice, stocksBought: $stocksBought)
                        .navigationBarBackButtonHidden(true)
                }
            }
            
        }
        .foregroundStyle(themeManager.textColor)
        .onChange(of: dismissEverything, initial: false, { oldValue, newValue in
            if newValue == true {
                dismiss()
            }
        })
        .sheet(isPresented: $showBusiness) {
            pickBusinessView(dismissEverything: $dismissEverything, selectedBusiness: $selectedBusiness, startSession: $showBusiness, stockPrice: $stockPrice, stocksBought: $stocksBought)
                .presentationDetents([.fraction(0.5)])
                .interactiveDismissDisabled()
        }

        
    }
}

struct gameOverScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Query var users : [UserDataModel]
    
    @Binding var business : mockBusinesses
    @Binding var stockPrice: Double
    @Binding var stocksBought : Int
    
    var body: some View {
        if let user = users.first {
            VStack {
                Text("Game Over")
                Text("You bought \(stocksBought) shares of \(business.name) for \(business.currentStockPrice, specifier: "%.f").")
                Text("You sold \(stocksBought) for $\(stockPrice, specifier: "%.2f")")
                Text("Your total is $ \(stockPrice * Double(stocksBought), specifier: "%.2f").")
                
                Button("Dismiss"){
                    dismiss()
                    user.availableBalance += Int(stockPrice * Double(stocksBought))
                    user.miniGameSessions.append(MiniGameSessionModel(sessionDate: Date(), sessionWin: stockPrice < business.currentStockPrice ? false : true, sessionScore: 0, sessionValue: Int(stockPrice * Double(stocksBought)), sessionGame: .Stocks))
                }
            }
        }
    }
}

struct pickBusinessView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var dismissEverything : Bool
    @EnvironmentObject var themeManager : ThemeManager
    @Binding var selectedBusiness : mockBusinesses
    @Binding var startSession : Bool
    
    @Binding var stockPrice : Double
    @Binding var stocksBought : Int
    
    
    var body: some View {
        ZStack {
            themeManager.mainColor.opacity(0.8)
                .ignoresSafeArea()
            VStack (alignment: .leading){
                HStack {
                    Spacer()
                    Text("X")
                }
                .frame(width: screenWidth-20, height: 50)
                .onTapGesture {
                    dismiss()
                    dismissEverything = true
                }
                
                Text("Please Select a Business :")
                
                businessListSection(selectedBusiness: $selectedBusiness, stockPrice: $stockPrice)
                .frame(width: screenWidth-20)
                
                Text("Business Info : \(selectedBusiness.name)")
                    .font(.title2)
                
                businessInfoSection(selectedBusiness: $selectedBusiness, startSession: $startSession, stocksBought: $stocksBought)
                
                
                Spacer()
            }
            .frame(width: screenWidth-20)
            .foregroundStyle(themeManager.textColor)
            .padding(.top, 30)
        }
    }
}
struct businessInfoSection: View {
    @EnvironmentObject var themeManager : ThemeManager
    @Query var users : [UserDataModel]
    @Environment(\.modelContext) var context
    
    @Binding var selectedBusiness : mockBusinesses
    @Binding var startSession : Bool
    
    @Binding var stocksBought : Int
    
    
    @State var noMoneyAlert = false
    @State var noBusinessSelectedAlert = false
    @State var noTokenAlert = false
    
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                VStack (alignment: .leading){
                    Text("Industry: \(selectedBusiness.industry)")
                    Text("Current Stock Price: $\(selectedBusiness.currentStockPrice, specifier: "%.f")")
                    Text("Volatility Rating: \(selectedBusiness.volatilityRating.rawValue)")
                    Spacer()
                }
                Spacer()
                VStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 120, height: 40)
                        .foregroundStyle(getColor(themeManager.mainDark))
                        .overlay {
                            Text("Stocks: \(stocksBought)")
                                .foregroundStyle(themeManager.textColor)
                        }
                    
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 55, height: 40)
                            .foregroundStyle(.red)
                            .overlay {
                                Image(systemName: "minus")
                                    .font(.system(size: 30))
                            }
                            .onTapGesture {
                                if stocksBought > 0{
                                    stocksBought -= 1
                                }
                            }
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 55, height: 40)
                            .foregroundStyle(.green)
                            .overlay {
                                Image(systemName: "plus")
                                    .font(.system(size: 30))
                            }
                            .onTapGesture {
                                if stocksBought <= 9{
                                    stocksBought += 1
                                }
                            }
                    }
                    Spacer()
                }
            }
            
            HStack {
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 200, height: 50)
                    .foregroundStyle(themeManager.textColor)
                    .overlay {
                        Text("Start Session")
                            .foregroundStyle(themeManager.mainColor)
                    }
                    .onTapGesture {
                        if let user = users.first {
                            let userAvailableBalance = user.availableBalance
                            if user.tokens > 0 {
                                if selectedBusiness.name != "" {
                                    if userAvailableBalance >= stocksBought * Int(selectedBusiness.currentStockPrice){
                                        print("Net Worth: $\(userAvailableBalance)")
                                        print("Price of Stocks: $\(Double(stocksBought) * selectedBusiness.currentStockPrice)")
                                        print("User Has Enough Cash to buy... Starting Session")
                                        user.availableBalance -= stocksBought * Int(selectedBusiness.currentStockPrice)
                                        user.tokens -= 1
                                        let newTransaction = TransactionDataModel(category: "Minigame", amount: stocksBought * Int(selectedBusiness.currentStockPrice), transactionDescription: "Stocks Investment", createdAt: Date(), income: false)
                                        user.transactions.append(newTransaction)
                                        do {
                                            try context.save()
                                        } catch {
                                            print("Error: Couldnt save new Stocks transaction for mini-game")
                                        }
                                        
                                        startSession.toggle()
                                    } else {
                                        print("User does not have enough cash to buy.... Cannot Start Session")
                                        noMoneyAlert.toggle()
                                    }
                                }
                                else {
                                    print("No Business Selected")
                                    noBusinessSelectedAlert.toggle()
                                }
                            }
                            else {
                                noTokenAlert.toggle()
                            }
                        }
                    }
                Spacer()
            }
            .padding(.top, 20)
        }
        .alert("Not Enough Tokens", isPresented: $noTokenAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("You dont have enough Tokens. Do a session to earn more or buy one from the store!")
        }
        .alert("Not Enough Money", isPresented: $noMoneyAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("You dont have enough Money. Do a session to earn more!")
        }
        .alert("No Business Selected", isPresented: $noBusinessSelectedAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("You have not selected a business. Select one to Play!")
        }
    }
}
struct businessListSection: View {
    @EnvironmentObject var themeManager : ThemeManager
    
    let businesses = [
        mockBusinesses(id: UUID(), name: "Playstation", businessLogo: "playstation.logo", industry: "Gaming", currentStockPrice: 100.0, volatilityRating: .low),
        mockBusinesses(id: UUID(), name: "Xbox", businessLogo: "xbox.logo", industry: "Gaming", currentStockPrice: 500.0, volatilityRating: .medium),
        mockBusinesses(id: UUID(), name: "Brand", businessLogo: "paintbrush", industry: "Cosmetics", currentStockPrice: 1000, volatilityRating: .high),
        mockBusinesses(id: UUID(), name: "Sports Brand", businessLogo: "soccerball", industry: "Sports", currentStockPrice: 1500, volatilityRating: .medium)
    ]
    @Binding var selectedBusiness : mockBusinesses
    @Binding var stockPrice : Double
    
    var body: some View {
        HStack {
            ForEach(businesses) { i in
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 80, height: 80)
                    .foregroundStyle(getColor(themeManager.mainDark))
                    .overlay {
                        Image(systemName: "\(i.businessLogo)")
                            .font(.system(size: 40))
                            .foregroundStyle(i == selectedBusiness ? Color.red : themeManager.textColor)
                    }
                    .onTapGesture {
                        selectedBusiness = i
                        stockPrice = selectedBusiness.currentStockPrice
                    }
                
                if i.name != "Sports Brand" {
                    Spacer()
                }
            }
        }
    }
}
struct StockSimulationView: View {
    @EnvironmentObject var themeManager : ThemeManager
    @Binding var isGameOver: Bool
    @State var business : mockBusinesses
    @Binding var stocksBought : Int
    @Binding var stockPrice : Double
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            VStack (alignment: .leading){
                VStack (alignment: .leading){
                    Text("\(business.name)")
                        .font(.system(size: 35))
                    Text("Starting Price: $\(business.currentStockPrice, specifier: "%.f")")
                    Text("Stocks Bought: \(stocksBought)")
                }
                .font(.system(size: 25))
                Spacer()
                
                StockSimulationGame(isGameOver: $isGameOver, price: $stockPrice, stockPrice: [stockPrice], stocksBought: stocksBought)
                
                Spacer()
            }
            .frame(width: screenWidth-20, alignment: .leading)
            .foregroundStyle(themeManager.textColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct mockBusinesses: Identifiable, Equatable {
    var id: UUID
    let name: String // Business name
    let businessLogo: String // Logo
    let industry: String // Industry sector
    var currentStockPrice: Double // Current stock price
    let volatilityRating: Volatility // Low, Medium, High risk

    enum Volatility: String {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
    }
}


#Preview {
    Stocks(isTaskActive: .constant(false), selectedBusiness: mockBusinesses(id: UUID(), name: "Playstation", businessLogo: "playstation.logo", industry: "Gaming", currentStockPrice: 1000.0, volatilityRating: .low))
        .environmentObject(ThemeManager())
}


