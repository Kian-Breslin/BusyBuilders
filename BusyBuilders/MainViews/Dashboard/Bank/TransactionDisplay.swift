//
//  TransactionDisplay.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 04/02/2025.
//

import SwiftUI
import SwiftData

struct TransactionDisplay: View {
    @EnvironmentObject var themeManager : ThemeManager
    @Query var users : [UserDataModel]
    @Environment(\.modelContext) var context
    
    @State var option = "Session Income"
    let options = ["Session Income", "Minigame", "Withdraws", "Other"]
    
    @State var incomeOrExpense : Bool?
    let incomeOrExpenseOptions = ["Income", "Expensese"]
    
    var body: some View {
        VStack {
            Picker("Income or Expense", selection: $incomeOrExpense) {
                Text("Income").tag(true as Bool?)
                Text("Expenses").tag(false as Bool?)
                Text("All").tag(nil as Bool?)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Picker("Category:", selection: $option){
                ForEach(options, id: \.self){ opt in
                    Text("\(opt)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            ScrollView {
                if let user = users.first {
                    VStack {
                        ForEach(user.transactions.filter { ($0.category == option) && (incomeOrExpense == nil || $0.income == incomeOrExpense) }) { transaction in
                            transactionCard(transaction: transaction)
                        }
                    }
                } else {
                    Text("No transactions found")
                        .bold()
                        .font(.system(size: 50))
                }
            }
        }
        .frame(width: screenWidth-20)
        .onAppear {
            print(users.first?.transactions.count ?? 10101010)
        }
    }
}

struct transactionCard: View {
    @EnvironmentObject var themeManager : ThemeManager
    let transaction : TransactionDataModel
    @State var showIncomeInfo = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth-20, height: 60)
            .foregroundStyle(themeManager.mainColor)
            .overlay {
                HStack {
//                    Image(systemName: transaction.image)
//                        .font(.system(size: 35))
                    
                    VStack (alignment: .leading){
                        Text("\(transaction.transactionDescription)")
                            .bold()
                        Text("\(getDateFull(from: transaction.createdAt))")
                            .font(.system(size: 15))
                    }
                    
                    Spacer()
                    
                    Text("\(transaction.income ? "+" : "-") $\(transaction.amount)")
                        .font(.system(size: 25))
                        .foregroundStyle(transaction.income ? .green : .red)
                    
                    Image(systemName: "info.circle")
                        .font(.system(size: 30))
                        .onTapGesture {
                            showIncomeInfo.toggle()
                        }
                }
                .padding(10)
            }
            .foregroundStyle(themeManager.textColor)
            .alert("\(transaction.income ? "You Earned $\(transaction.amount)" : "You spent $\(transaction.amount)")", isPresented: $showIncomeInfo) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(transaction.income ?
                    "This amount has already been taxed at 15% and added to your available balance." :
                    "This has been deducted from your available balance."
                )
            }
    }
}

//#Preview {
//    
//    VStack (spacing: 0){
//        RoundedRectangle(cornerRadius: 0)
//            .frame(width: screenWidth, height: 250)
//            .foregroundStyle(ThemeManager().mainColor)
//        TransactionDisplay()
//            .environmentObject(ThemeManager())
//            .padding(.top, 10)
//    }
//    .ignoresSafeArea()
//}

#Preview {
    transactionCard(transaction: TransactionDataModel(category: "Session Income", amount: 1000, transactionDescription: "Income", createdAt: Date.now, income: true))
        .environmentObject(ThemeManager())
}
