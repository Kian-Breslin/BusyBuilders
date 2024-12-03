//
//  MyLoansView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 22/11/2024.
//

import SwiftUI

struct MyLoansView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    var body: some View {
        Text("This loan is for $\(randomNumber(in: 0...10)*10000)")
    }
}

#Preview {
    MyLoansView()
        .environmentObject(ThemeManager())
}
