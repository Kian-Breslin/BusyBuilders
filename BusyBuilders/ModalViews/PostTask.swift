//
//  PostTask.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 06/10/2024.
//

import SwiftUI

struct PostTask: View {
    
    @AppStorage("userColorPreference") var userColorPreference: String = "red"
    
    @Binding var currentView : Int
    @State var totalCashEarned : Double
    var body: some View {
        ZStack {
            
            getColor(userColorPreference)
                .ignoresSafeArea()
            
            VStack {
                Text("Congrats! You've earned $\(totalCashEarned, specifier: "%.f")")
                Button("Close"){
                    currentView = 0
                }
                .frame(width: 300, height: 50)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(getColor(userColorPreference))
                .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    PostTask(currentView: .constant(0), totalCashEarned: 35000)
}
