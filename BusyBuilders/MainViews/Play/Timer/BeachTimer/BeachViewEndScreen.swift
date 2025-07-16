//
//  BeackViewEndScreen.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 15/07/2025.
//

import SwiftUI

struct BeachViewEndScreen: View {
    @Environment(\.dismiss) var dismiss
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
                                Text("$\(sessionStats.getStats()[0])")
                                    .font(.system(size: 20))
                                    .foregroundStyle(background)
                                    .opacity(incomeSize > 10 ? 1 : 0)
                                    .frame(width: 200, height: 100)
                            })
                        
                        Text("Cash")
                            .font(.callout)
                            .bold()
                    }
                    Spacer()
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 90, height: CGFloat(productSize))
                            .foregroundStyle(Color(red: 0.349, green: 0.451, blue: 0.443))
                            .overlay(content: {
                                Text("$\(sessionStats.getStats()[1])")
                                    .font(.system(size: 20))
                                    .foregroundStyle(background)
                                    .opacity(productSize > 10 ? 1 : 0)
                                    .frame(width: 200, height: 100)
                            })
                        
                        Text("Products")
                            .font(.callout)
                            .bold()
                    }
                    Spacer()
                    VStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 90, height: CGFloat(costSize))
                            .foregroundStyle(getColor("red"))
                            .overlay(content: {
                                Text("$\(sessionStats.getStats()[2])")
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
                                Text("\(sessionStats.getStats()[3])")
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
                let stats = sessionStats.getStats()
                let maxCash = stats[0]

                withAnimation(.linear(duration: 1)) {
                    incomeSize = Int(heightForValue(stats[0], maxValue: maxCash))
                }
                withAnimation(.linear(duration: 1.3)) {
                    productSize = Int(heightForValue(stats[1], maxValue: maxCash))
                }
                withAnimation(.linear(duration: 1.5)) {
                    costSize = Int(heightForValue(stats[2], maxValue: maxCash))
                }
                withAnimation(.linear(duration: 1.7)) {
                    xpSize = Int(heightForValue(stats[0], maxValue: maxCash))
                }
            }
        }
    }
}

#Preview {
    BeachViewEndScreen(sessionStats: SessionDataModel(id: UUID(), sessionDate: Date.now, businessId: UUID(), totalCashEarned: 50000, totalCostIncurred: 12000, totalXPEarned: 60, totalStudyTime: 3600, productsSnapshot: []))
}
