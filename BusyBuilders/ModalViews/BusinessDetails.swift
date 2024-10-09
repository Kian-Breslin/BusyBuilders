//
//  BusinessDetails.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 08/10/2024.
//

import SwiftUI
import SwiftData

struct BusinessDetails: View {
    
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel] // Query for businesses
    @Query var sessionHistory: [SessionDataModel]
    
    var business : BusinessDataModel
    
    
    var body: some View {
        ZStack {
            
            colorForName(business.businessTheme)
                .ignoresSafeArea()
            
            VStack {
                Text(business.businessName)
                    .font(.system(size: 46))
                    .padding()
                
                Image(systemName: "\(business.businessIcon)")
                    .bold()
                    .font(.system(size: 60))
                    .padding(.bottom, 40)
                
                VStack {
                    HStack {
                        Text("Net Worth : ")
                        Spacer()
                        Text("$\(business.netWorth, specifier: "%.f")")
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                    }
                    HStack {
                        Text("$/Min : ")
                        Spacer()
                        Text("$\(business.cashPerMin)")
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                    }
                    HStack {
                        Text("Business Level:  ")
                        Spacer()
                        Text("\(business.businessLevel)")
                            .font(.system(size: 30))
                            .fontWeight(.heavy)
                    }
                }
                .font(.system(size: 30))
                .fontWeight(.light)
                .padding(30)
                
                // Navigation link to Session History
                NavigationLink(destination: SessionHistoryView(sessions: sessionHistory)) {
                    Text("View Session History")
                        .font(.system(size: 20))
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)

                Spacer()
            }
            .navigationTitle("Business Details") // Title for the detail view
            .navigationBarTitleDisplayMode(.inline) // Optional: display title inline
        }
    }
}

// Session History View
struct SessionHistoryView: View {
    var sessions: [SessionDataModel] // Array of session data

    var body: some View {
        List(sessions) { session in
            VStack(alignment: .leading) {
                Text("Session Start: \(session.sessionStart)")
                Text("Session End: \(session.sessionEnd)")
                Text("Total Study Time: \((timeFormatted(session.totalStudyTime))) seconds")
            }
        }
        .navigationTitle("Session History") // Title for the session history view
    }
}

#Preview {
    BusinessDetails( business: BusinessDataModel(businessName: "Kims Shop", businessTheme: "blue", businessType: "Economic", businessIcon: "triangle", cashPerMin: 3000, netWorth: 250000, sessionHistory: [SessionDataModel(sessionStart: formatFullDateTime(date: Date()), sessionEnd: formatFullDateTime(date: Date()), totalStudyTime: 3600, businessId: UUID())], businessLevel: 20))
        .modelContainer(for: UserDataModel.self, inMemory: true)
}
