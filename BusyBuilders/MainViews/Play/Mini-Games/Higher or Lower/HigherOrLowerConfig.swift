//
//  HigherOrLowerConfig.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 26/11/2024.
//

import SwiftUI
import SwiftData

struct HigherOrLowerConfig: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss
    @Query var users : [UserDataModel]
    @Environment(\.modelContext) var context
    @Binding var dismissEverything : Bool
    
    @Binding var isTaskActive : Bool
    @Binding var sliderValue : Double
    let step = 100.0
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            if let user = users.first {
                VStack {
                    HStack {
                        Spacer()
                        Text("X")
                    }
                    .frame(width: screenWidth-20, height: 50)
                    .onTapGesture {
                        dismiss()
                        dismissEverything = true
                    }
                    HStack {
                        Text("Selected Amount: $\(sliderValue, specifier: "%.f")")
                    }
                    
                    Slider(
                        value: $sliderValue,
                        in: 0...Double(user.availableBalance == 0 ? 1000 : user.availableBalance),
                        step: step
                    )
                    .padding(.horizontal)
                    
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 100, height: 50)
                        .overlay {
                            Text("Submit")
                                .font(.title2)
                                .foregroundStyle(themeManager.mainColor)
                        }
                        .onTapGesture {
                            isTaskActive = true
                            dismiss()
                            
                            if let user = users.first {
                                
                                user.availableBalance -= Int(sliderValue)
                                
                                let newTransaction = TransactionDataModel(category: "Minigame", amount: Int(sliderValue), transactionDescription: "Higher or Lower", createdAt: Date(), income: false)
                                user.transactions.append(newTransaction)
                                do {
                                    try context.save()
                                } catch {
                                    print("Error when saving Higher or Lower transaction")
                                }
                            }
                        }
                }
            }
            else {
                Text("No User Found")
                    .onTapGesture {
                        let mockUser = UserDataModel(username: "Kian_17", name: "Kian", email: "kianbreslin517@gmail.com", availableBalance: 10000)
                        context.insert(mockUser)
                    }
            }
        }
        .foregroundStyle(themeManager.textColor)
    }
}

#Preview {
    HigherOrLowerConfig(dismissEverything: .constant(false), isTaskActive: .constant(true), sliderValue: .constant(1))
        .environmentObject(ThemeManager())
        .modelContainer(for: [UserDataModel.self], inMemory: true)
}
