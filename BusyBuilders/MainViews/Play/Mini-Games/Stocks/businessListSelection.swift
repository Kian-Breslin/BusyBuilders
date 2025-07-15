//
//  businessListSelection.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 15/07/2025.
//

import SwiftUI
import SwiftData

struct businessListSection: View {
    @EnvironmentObject var themeManager : ThemeManager
    
    @Binding var selectedBusiness : mockBusinesses
    @Binding var stockPrice : Double
    
    var body: some View {
        HStack {
            ForEach(mockBusinessList) { i in
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 80, height: 80)
                    .foregroundStyle(getColor(themeManager.mainDark))
                    .overlay {
                        Image(systemName: "\(i.businessLogo)")
                            .font(.system(size: 40))
                            .foregroundStyle(i == selectedBusiness ? Color.red : themeManager.textColor)
                    }
                    .onTapGesture {
                        selectedBusiness = i
                        stockPrice = selectedBusiness.currentStockPrice
                    }
                
                if i.name != "Sports Brand" {
                    Spacer()
                }
            }
        }
    }
}
