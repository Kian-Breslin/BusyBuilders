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
    
    @Binding var isTaskActive : Bool
    @Binding var sliderValue : Double
    let step = 100.0
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            if let user = users.first {
                VStack {
                    HStack {
                        Text("Selected Amount: $\(sliderValue, specifier: "%.f")")
                    }
                    
                    Slider(
                        value: $sliderValue,
                        in: 0...Double(user.netWorth == 0 ? 1000 : user.netWorth),
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
                        }
                }
            }
            else {
                Text("No User Found")
                    .onTapGesture {
                        let mockUser = UserDataModel(username: "Kian_17", name: "Kian", email: "kianbreslin517@gmail.com", netWorth: 10000)
                        context.insert(mockUser)
                    }
            }
        }
        .foregroundStyle(themeManager.textColor)
    }
}

#Preview {
    HigherOrLowerConfig(isTaskActive: .constant(true), sliderValue: .constant(1))
        .environmentObject(ThemeManager())
        .modelContainer(for: [UserDataModel.self], inMemory: true)
}
