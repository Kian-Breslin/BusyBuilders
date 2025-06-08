//
//  InvestmentView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 31/05/2025.
//

import SwiftUI
import SwiftData

struct InvestmentView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var companies: [CompanyDataModel]
    
    var body: some View {
        VStack (spacing: 15){
            Text("List of Companies")
            ScrollView {
                VStack {
                    ForEach(companies){ comp in
                        NavigationLink(destination: CompanyView(company: comp).navigationBarBackButtonHidden(true)){
                            CompanyScrollItem(color: themeManager.textColor, company: comp)
                        }
                    }
                }
            }
            .padding(.bottom, 50)
        }
        .foregroundStyle(themeManager.textColor)
    }
}

struct CompanyScrollItem: View {
    let color : Color
    let company : CompanyDataModel
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth-20, height: 60)
            .foregroundStyle(color)
            .overlay {
                HStack {
                    Image(systemName: company.icon)
                    Text(company.name)
                    Spacer()
                    Text("$\(company.stockPrice)")
                    Text("50%")
                        .font(.system(size: 15))
                }
                .padding(.horizontal)
                .font(.system(size: 25))
                .foregroundStyle(ThemeManager().mainColor)
            }
    }
}

#Preview {
    ZStack {
        ThemeManager().mainColor.ignoresSafeArea()
        
        VStack {
            Rectangle().frame(width: .infinity, height: 160)
                .foregroundStyle(ThemeManager().mainColor)
            InvestmentView()
                .environmentObject(ThemeManager())
        }
    }
}
