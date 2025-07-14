//
//  BusinessSessionsView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 10/12/2024.
//

import SwiftUI
import SwiftData

struct BusinessSessionsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Query var users: [UserDataModel]
    
    @State var currentBusiness: BusinessDataModel
    
    var body: some View {
        ZStack {
            themeManager.mainColor
                .ignoresSafeArea()
            
            VStack {
                if let _ = users.first {
                    ScrollView (.vertical, showsIndicators: false){
                        VStack {
                            ForEach(currentBusiness.sessionHistory){ s in
                                currentBusinessSessionView(session: s)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct currentBusinessSessionView: View {
    @State var session: SessionDataModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth-20, height: 100)
            .foregroundStyle(ThemeManager().textColor)
            .overlay {
                VStack (alignment: .leading){
                    Text("\(getDayMonthYear(from: session.sessionDate) ?? "No Date Found")")
                        .font(.title3)
                        .bold()
                    Text("Total Cash Earned: $\(session.totalCashEarned)")
                    Text("Total Cost Incurred: $\(session.totalCostIncurred)")
                    Text("Total XP Earned: \(session.totalXPEarned)     Total Study Time: \(timeFormatted(session.totalStudyTime))")
                    Spacer()
                }
                .frame(width: screenWidth-30, alignment: .leading)
                .padding(5)
                .font(.system(size: 15))
                .foregroundStyle(ThemeManager().mainColor)
            }
    }
}

#Preview {
    currentBusinessSessionView(session: SessionDataModel(id: UUID(), sessionDate: Date.now, businessId: UUID(), totalCashEarned: 0, totalCostIncurred: 0, totalXPEarned: 0, totalStudyTime: 0, productsSnapshot: []))
}


#Preview {
    BusinessSessionsView(currentBusiness:
                            BusinessDataModel(
                                businessName: "Kians Coffee",
                                businessTheme: "red",
                                businessType: "Eco-friendly",
                                businessIcon: "hexagon"
                            )
    )
        .environmentObject(ThemeManager())
}
