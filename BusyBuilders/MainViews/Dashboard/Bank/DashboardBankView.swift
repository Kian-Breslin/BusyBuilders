//
//  Bank.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 22/11/2024.
//

import SwiftUI
import SwiftData

struct DashboardBankView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Query var users : [UserDataModel]
    let banks : [BankDataModel] = [
        BankDataModel(name: "Ace Bank", icon: "suit.spade", loanInterestRate: 0.03, savingsInterestRate: 0.04, benefits: []),
        BankDataModel(name: "Hearts Bank", icon: "suit.heart", loanInterestRate: 0.05, savingsInterestRate: 0.02, benefits: []),
        BankDataModel(name: "Diamond Bank", icon: "suit.diamond", loanInterestRate: 0.02, savingsInterestRate: 0.05, benefits: []),
        BankDataModel(name: "Clubs Bank", icon: "suit.club", loanInterestRate: 0.03, savingsInterestRate: 0.03, benefits: [])
    ]
    @State var selectedBank : BankDataModel?
    
    var body: some View {
        if let user = users.first {
            if user.bank != nil {
                mainBankView(user: user)
            }
            else {
                VStack {
                    VStack (alignment: .leading){
                        Text("Welcome to Banking")
                            .font(.system(size: 30))
                        
                        Text("With a Bank you can, Get Loans, Earn Interest on savings or even be rewarded for the money you own!")
                            .font(.caption)
                        
                        Text("To get started please chose one of the banks below!")
                            .font(.callout)
                            .foregroundStyle(getColor("red"))
                    }
                    
                    VStack {
                        HStack {
                            bankDetails(bank: banks[0], selectedBank: $selectedBank)
                            bankDetails(bank: banks[1], selectedBank: $selectedBank)
                        }
                        HStack {
                            bankDetails(bank: banks[2], selectedBank: $selectedBank)
                            bankDetails(bank: banks[3], selectedBank: $selectedBank)
                        }
                    }
                    .padding(.bottom, 100)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 150, height: 50)
                        .overlay {
                            Text("Choose Bank")
                                .foregroundStyle(themeManager.mainColor)
                                .font(.system(size: 20))
                        }
                        .onTapGesture {
                            print("Current Users bank: \(user.bank?.name ?? "None")")
                            print("Chosen Bank: \(selectedBank?.name ?? "None")")
                            user.bank = selectedBank
                            print("Users bank: \(user.bank?.name ?? "NONE")")
                        }
                }
                .frame(width: screenWidth-20)
                .foregroundStyle(themeManager.textColor)
                
            }
        }
    }
}


struct mainBankView: View {
    @EnvironmentObject var themeManager : ThemeManager
    @State var user : UserDataModel
    @State var addCashToBank = false
    @State var withdrawCashFromBank = false
    @State var showBanks = false
    @State var showAccount = false
    
    var body: some View {
        VStack (spacing: 30){
            HStack {
                Circle()
                    .frame(width: 40)
                    .foregroundStyle(themeManager.mainColor)
                    .overlay {
                        Image(systemName: "\(user.bank!.icon)")
                    }
                NavigationLink(destination: bankSettingsView(user: user)){
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: screenWidth-170, height: 40)
                        .foregroundStyle(themeManager.mainColor)
                        .overlay {
                            Text("\(user.bank!.name)")
                                .font(.system(size: 20))
                        }
                }
                Circle()
                    .frame(width: 40)
                    .foregroundStyle(themeManager.mainColor)
                    .overlay {
                        Image(systemName: "chart.bar.fill")
                    }
                
                Circle()
                    .frame(width: 40)
                    .foregroundStyle(themeManager.mainColor)
                    .overlay {
                        Image("userImage-2")
                            .resizable()
                    }
                    .onTapGesture {
                        showAccount.toggle()
                    }
                
            }
            Spacer()
            VStack {
                Text("Account Balance")
                Text("$\(user.bankAccount?.balance ?? 17, specifier: "%.2f")")
                    .fontWeight(.heavy)
                    .font(.system(size: 40))
            }
            .padding(.bottom, 15)
            
            HStack {
                bankNavButton(color: themeManager.mainColor, text: "Add", image: "plus")
                    .onTapGesture {
                        addCashToBank = true
                    }
                Spacer()
                bankNavButton(color: themeManager.mainColor, text: "Withdraw", image: "minus")
                    .onTapGesture {
                        withdrawCashFromBank = true
                    }
                Spacer()
                bankNavButton(color: themeManager.mainColor, text: "Details", image: "info")
                Spacer()
                bankNavButton(color: themeManager.mainColor, text: "More", image: "ellipsis")
            }
            .frame(width: screenWidth-20)
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: screenWidth-20, height: 250)
                .foregroundStyle(themeManager.mainColor)
                .overlay {
                    ScrollView (.vertical){
                        VStack {
                            ForEach(user.bankAccount?.transactions ?? []){ i in
                                Transaction(transaction: i)
                            }
                        }
                    }
                    .padding(.vertical, 10)
                }
            
            
            
            Spacer()
        }
        .frame(width: screenWidth-20)
        .foregroundStyle(themeManager.textColor)
        .sheet(isPresented: $addCashToBank) {
            addCashToBankSheet()
                .presentationDetents([.fraction(0.25)])
        }
        .sheet(isPresented: $withdrawCashFromBank) {
            withdrawCashFromBankSheet()
                .presentationDetents([.fraction(0.25)])
        }
        .sheet(isPresented: $showAccount) {
            VStack {
                Circle()
                    .frame(width: 80)
                    .foregroundStyle(themeManager.textColor)
                    .overlay {
                        Image("userImage-2")
                            .resizable()
                    }
                Text("\(user.name)")
                    .fontWeight(.heavy)
                    .font(.system(size: 25))
                
                Text("Account #\(user.bankAccount?.accountNumber ?? "112233")")
            }
            .foregroundStyle(themeManager.textColor)
            .presentationDetents([.fraction(0.25)])
        }
    }
}



struct addCashToBankSheet: View {
    @Query var users : [UserDataModel]
    @State var amount = 0.0
    var body: some View {
        ZStack {
            ThemeManager().mainColor.ignoresSafeArea()
            
            VStack {
                Text("Add Cash")
                    .font(.system(size: 25))
                
                if let user = users.first {
                    VStack (alignment: .leading){
                        Text("Available Cash:")
                        Text("$\(user.availableBalance)")
                        
                        Text("Amount: $\(amount, specifier: "%.f")")
                        if user.availableBalance > 0 {
                            Slider(value: $amount, in: 0...Double(user.availableBalance), step: 100)
                        } else {
                            Text("Must have more than $100")
                        }
                        
                        Button("Add Cash") {
                            print("Total Cash added: $\(amount)")
                            user.availableBalance -= Int(amount)
                            user.bankAccount?.balance += amount
                        }
                        .disabled(amount < 100)
                        .frame(width: 100, height: 50)
                        .background(getColor(ThemeManager().mainDark))
                        
                    }
                }
            }
            .frame(width: screenWidth-20)
            .foregroundStyle(ThemeManager().textColor)
            .padding(.vertical, 10)
        }
    }
}

struct withdrawCashFromBankSheet: View {
    @Query var users : [UserDataModel]
    @State var amount = 0.0
    var body: some View {
        ZStack {
            ThemeManager().mainColor.ignoresSafeArea()
            
            VStack {
                Text("Withdraw Cash")
                    .font(.system(size: 25))
                
                if let user = users.first {
                    VStack (alignment: .leading){
                        Text("Available Balance:")
                        Text("$\(user.bankAccount?.balance ?? 0, specifier: "%.f")")
                        
                        Text("Amount: $\(amount, specifier: "%.f")")
                        if user.bankAccount!.balance > 1 {
                            Slider(value: $amount, in: 0...Double(user.bankAccount?.balance ?? 1), step: 100)
                        }
                        else {
                            Text("Must have more than $1.")
                        }
                        
                        Button("Add Cash") {
                            print("Total Cash added: $\(amount)")
                            user.bankAccount?.balance  -= amount
                            user.availableBalance += Int(amount)
                        }
                        .disabled(amount < 100)
                        .frame(width: 100, height: 50)
                        .background(getColor(ThemeManager().mainDark))
                        
                    }
                }
            }
            .frame(width: screenWidth-20)
            .foregroundStyle(ThemeManager().textColor)
            .padding(.vertical, 10)
        }
    }
}

struct Transaction : View {
    @State var transaction : TransactionDataModel
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .frame(width: screenWidth-40, height: 60)
            .foregroundStyle(getColor(ThemeManager().mainDark))
            .overlay {
                HStack {
                    Circle()
                        .frame(width: 40)
                        .overlay {
                            Image(systemName: "\(transaction.image)")
                                .foregroundStyle(ThemeManager().mainColor)
                        }
                    
                    VStack (alignment: .leading){
                        Text("\(transaction.name)")
                        Text("\(transactionTime(from: transaction.createdAt))")
                            .font(.caption)
                            .opacity(0.7)
                    }
                    Spacer()
                    
                    if transaction.income {
                        Text("+ $\(transaction.amount)")
                    } else {
                        Text("- $\(transaction.amount)")
                    }
                }
                .padding(5)
            }
    }
}

struct bankNavButton : View {
    var color : Color
    var text : String
    var image: String
    
    var body: some View {
        VStack {
            Circle()
                .frame(width: 45)
                .foregroundStyle(color)
                .overlay {
                    Image(systemName: "\(image)")
                }
            Text("\(text)")
                .font(.callout)
        }
        .frame(width: (screenWidth-50)/4)
    }
}

struct bankDetails: View {
    @EnvironmentObject var themeManager : ThemeManager
    @State var bank: BankDataModel
    @Binding var selectedBank : BankDataModel?
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: (screenWidth-25)/2, height: 150)
            .foregroundStyle(themeManager.mainColor)
            .opacity(selectedBank == bank ? 0.4 : 1)
            .overlay {
                VStack (spacing: 10){
                    HStack {
                        Text("\(bank.name)")
                            .font(.system(size: 20))
                            .bold()
                        Image(systemName: "\(bank.icon)")
                            .font(.system(size: 20))
                    }
                    VStack (alignment: .leading, spacing: 15){
                        Text("Interest Rates")
                            .underline()
                        Text("Loans: ").bold()
                            .font(.subheadline)
                        +
                        Text("\(bank.loanInterestRate*100, specifier: "%.f")%")
                        
                        Text("Savings: ").bold()
                            .font(.subheadline)
                        +
                        Text("\(bank.savingsInterestRate*100, specifier: "%.f")%")
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(width: ((screenWidth-25)/2)-10, height: 180)
            }
            .onTapGesture {
                selectedBank = bank
            }
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 50), trigger: selectedBank == bank)
    }
}

#Preview {
    ZStack {
        getColor(ThemeManager().mainDark).ignoresSafeArea()
        
        VStack {
            RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth, height: 160)
            .foregroundStyle(getColor(ThemeManager().mainDark))
            
            mainBankView(user: UserDataModel(username: "Keano517", name: "Kian", email: "kianbreslin@gmail.com", bank: BankDataModel(name: "Ace Bank", icon: "suit.spade", loanInterestRate: 0.05, savingsInterestRate: 0.05, benefits: [])))
                .environmentObject(ThemeManager())
            
            
        }
    }
}
