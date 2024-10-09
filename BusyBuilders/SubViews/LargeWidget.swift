//
//  LargeWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 27/09/2024.
//

import SwiftUI

struct LargeWidget: View {
    
    @State var selectedView : Int
    var colorName : Color
    // List of Widget :
    // 1. Revenue ( Daily, Weekly, Monthly )
    // 2. Streak Calendar
    // 3. Leaderboard
    // 4. Specific Business Stats ( Revenue, Total Hours, Level, Quick start )
    
    var body: some View {
        if selectedView == 0 {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(colorName)
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
        else if selectedView == 1 {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(colorName)
                .frame(width: screenWidth-15, height: 150)
                .padding(15)
                .overlay {
                        
                    }
                }
        }
    }


#Preview {
    LargeWidget(selectedView: 1, colorName: Color(red: 244/255, green: 73/255, blue: 73/255))
}
