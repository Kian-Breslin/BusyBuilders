//
//  PostTask.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 06/10/2024.
//

import SwiftUI

struct PostTask: View {
    
    @Binding var currentView : Int
    @State var totalCashEarned : Double
    var body: some View {
        ZStack {
            Text("Congrats! You've earned $\(totalCashEarned, specifier: "%.f")")
        }
    }
}

#Preview {
    PostTask(currentView: .constant(0), totalCashEarned: 35000)
}
