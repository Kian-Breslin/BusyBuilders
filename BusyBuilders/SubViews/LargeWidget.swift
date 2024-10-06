//
//  LargeWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 27/09/2024.
//

import SwiftUI

struct LargeWidget: View {
    
    // List of Widget :
    // 1. Revenue ( Daily, Weekly, Monthly )
    // 2. Streak Calendar
    // 3. Leaderboard
    // 4. Specific Business Stats ( Revenue, Total Hours, Level, Quick start )
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(Color.blue)
            .frame(width: screenWidth-15, height: 150)
            .padding(15)
            .overlay {
                HStack {
                    Image("Revenue - 30 days")
                        .resizable()
                        .frame(width: screenWidth-15, height: 150)
                }
            }
    }
}

#Preview {
    LargeWidget()
}
