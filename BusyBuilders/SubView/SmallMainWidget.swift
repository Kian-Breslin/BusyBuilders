//
//  SmallMainWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 21/05/2024.
//

import SwiftUI

struct SmallMainWidget: View {
    
    @State var title : String
    @State var amount : Double
    @State var dailyGoal : Double
    
    var calculatedWidth : CGFloat {
        let numberLength = (150/dailyGoal) * amount
        
        if(numberLength > 150) {
            return CGFloat(150)
        } else {
            return CGFloat(numberLength)
        }
    }
    
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
            .frame(width: 180, height: 100)
            .foregroundStyle(Color(red:0.3, green: 0.3, blue: 0.3))
            .overlay {
                VStack (alignment: .leading, spacing: 3){
                    Text("\(title)")
                        .foregroundStyle(.white.opacity(0.6))
                        .font(.system(size: 14))
                    Text("$\(amount, specifier: "%2.f")k")
                        .font(.system(size: 32))
                    ZStack (alignment: .leading){
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .frame(width: 150, height: 4)
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .frame(width: calculatedWidth, height: 4)
                            .foregroundStyle(.red)
                        
                    }
                }
                .foregroundStyle(.white)
            }
            .onTapGesture {
                print(calculatedWidth)
            }
    }
}

#Preview {
    SmallMainWidget(title: "Best Performing", amount: 60, dailyGoal: 100)
}
