//
//  TimerEndScreen.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import SwiftData

struct TimerEndScreen: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query var users : [UserDataModel]
    let background = Color(red: 0.847, green: 0.678, blue: 0.510)
    
    let sessionStats : SessionDataModel
    
    // Income Size
    @State var incomeSize = 10
    @State var productSize = 10
    
    @State var costSize = 10
    @State var xpSize = 10
    
    func heightForValue(_ value: Int, maxValue: Int, maxHeight: CGFloat = 250) -> CGFloat {
        guard maxValue > 0 else { return 0 }
        let ratio = Double(value) / Double(maxValue)
        return CGFloat(ratio) * maxHeight
    }
    
    var body: some View {
        ZStack {
            background.ignoresSafeArea()
            
            VStack (alignment: .leading){
                Text("Congratulations!")
                    .font(.title)
                
                HStack (alignment: .bottom){
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 90, height: CGFloat(incomeSize))
                            .foregroundStyle(Color(red: 0.141, green: 0.212, blue: 0.224))
                            .overlay(content: {
                                Text("$\((sessionStats.totalBusinessIncome))")
                                    .font(.system(size: 20))
                                    .foregroundStyle(background)
                                    .opacity(incomeSize > 10 ? 1 : 0)
                                    .frame(width: 200, height: 100)
                            })
                        
                        Text("Cash")
                            .font(.callout)
                            .bold()
                    }
                    
                    if sessionStats.totalBusinessProductIncome > 0 {
                        Spacer()
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 90, height: CGFloat(productSize))
                                .foregroundStyle(Color(red: 0.349, green: 0.451, blue: 0.443))
                                .overlay(content: {
                                    Text("$500")
                                        .font(.system(size: 20))
                                        .foregroundStyle(background)
                                        .opacity(productSize > 10 ? 1 : 0)
                                        .frame(width: 200, height: 100)
                                })
                            
                            Text("Products")
                                .font(.callout)
                                .bold()
                        }
                    }
                    Spacer()
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 90, height: CGFloat(costSize))
                            .foregroundStyle(getColor("red"))
                            .overlay(content: {
                                Text("$\(sessionStats.totalBusinessCosts)")
                                    .font(.system(size: 20))
                                    .foregroundStyle(background)
                                    .opacity(costSize > 10 ? 1 : 0)
                                    .frame(width: 200, height: 100)
                            })
                        
                        Text("Cost")
                            .font(.callout)
                            .bold()
                    }
                    Spacer()
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 90, height: CGFloat(xpSize))
                            .foregroundStyle(Color.indigo)
                            .overlay(content: {
                                Text("\(sessionStats.totalTime)")
                                    .font(.system(size: 20))
                                    .foregroundStyle(background)
                                    .opacity(xpSize > 10 ? 1 : 0)
                                    .frame(width: 200, height: 100)
                            })
                        
                        Text("XP")
                            .font(.callout)
                            .bold()
                    }
                    
                }
                .frame(width: screenWidth-20, height: 300, alignment: .bottom)

                Spacer()
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: screenWidth-20, height: 50)
                    .overlay {
                        Text("Close")
                            .frame(minWidth: screenWidth-20, minHeight: 50)
                    }
                    .onTapGesture {
                        dismiss()
                    }
            }
            .padding(.top, 20)
            .frame(width: screenWidth-20, alignment: .leading)
            .onAppear {
                let income = sessionStats.totalBusinessIncome
                let products = sessionStats.totalBusinessProductIncome 
                let costs = sessionStats.totalBusinessCosts
                let xp = sessionStats.totalTime

                let maxStat = max(income, products, costs, xp)

                withAnimation(.linear(duration: 1.0)) {
                    incomeSize = Int(heightForValue(income, maxValue: maxStat))
                }
                withAnimation(.linear(duration: 1.3)) {
                    productSize = Int(heightForValue(products, maxValue: maxStat))
                }
                withAnimation(.linear(duration: 1.5)) {
                    costSize = Int(heightForValue(costs, maxValue: maxStat))
                }
                withAnimation(.linear(duration: 1.7)) {
                    xpSize = Int(heightForValue(income, maxValue: maxStat))
                }
            }
        }
    }
}

#Preview {
    TimerEndScreen(sessionStats: SessionDataModel.sessionForPreview)
}
