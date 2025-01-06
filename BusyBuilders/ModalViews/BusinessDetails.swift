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
    
    @State var showPrestigeDetails = false
    @State var detailsView = true
    
    // Stats Dropdown
    @State var selectedStats = "Today"
    @State var heightDropdown = 0
    @State var opacityDropdown = 0.0
    
    var body: some View {
        if !detailsView {
            ZStack {
                
                getColor(business.businessTheme)
                    .ignoresSafeArea()
                
                VStack {
                    
                    HStack (spacing: 0){
                        VStack {
                            Text("Details")
                            
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 100,height: 2)
                                .opacity(detailsView ? 1 : 0)
                        }
                        .onTapGesture {
                            detailsView.toggle()
                        }
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 2,height: 20)
                            .padding(.horizontal, 20)
                        
                        VStack {
                            Text("Stats")
                            
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 100,height: 2)
                                .opacity(detailsView ? 0 : 1)
                        }
                        .onTapGesture {
                            detailsView.toggle()
                        }
                        
                    }
                    .font(.system(size: 20))
                    .padding()
                    
                    Image("store")
                        .resizable()
                        .frame(width: 200, height: 200)
                    
                    VStack (alignment: .leading){
                        Group {
                            Text("Business Name:")
                                .font(.system(size: 12))
                                .opacity(0.5)
                            Text("\(business.businessName)")
                                .font(.system(size: 25))
                        }
                        Group {
                            Text("Business Type:")
                                .font(.system(size: 12))
                                .opacity(0.5)
                            Text("\(business.businessType)")
                                .font(.system(size: 25))
                        }
                        Group {
                            Text("Business Level:")
                                .font(.system(size: 12))
                                .opacity(0.5)
                            Text("\(getLevelFromSec(business.businessLevel))")
                                .font(.system(size: 25))
                        }
                        Group {
                            Text("Business Theme:")
                                .font(.system(size: 12))
                                .opacity(0.5)
                            Text("\(business.businessTheme)")
                                .font(.system(size: 25))
                        }
                        Group {
                            Text("Business Prestige:")
                                .font(.system(size: 12))
                                .opacity(0.5)
                            Text("\(business.businessPrestige)")
                                .font(.system(size: 25))
                        }
                        
                    }
                    .frame(width: screenWidth-20, alignment: .leading)
                    Spacer()
                    NavigationLink(destination: EditBusinessView(business: business)) {
                        Text("Edit Business Details")
                            .font(.system(size: 20))
                            .padding()
                            .background(getColor(business.businessTheme).suitableTextColor())
                            .foregroundColor(getColor(business.businessTheme))
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .foregroundStyle(getColor(business.businessTheme).suitableTextColor())
                .navigationTitle("\(business.businessName)") // Title for the detail view
                .navigationBarTitleDisplayMode(.inline) // Optional: display title inline
            }
        }
        else {
            ZStack {
                
                getColor(business.businessTheme)
                    .ignoresSafeArea()
                
                VStack {
                    VStack {
                        
                        HStack (spacing: 0){
                            VStack {
                                Text("Details")
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 100,height: 2)
                                    .opacity(detailsView ? 1 : 0)
                            }
                            .onTapGesture {
                                detailsView.toggle()
                            }
                            
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 2,height: 20)
                                .padding(.horizontal, 20)
                            
                            VStack {
                                Text("Stats")
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 100,height: 2)
                                    .opacity(detailsView ? 0 : 1)
                            }
                            .onTapGesture {
                                detailsView.toggle()
                            }
                            
                        }
                        .font(.system(size: 20))
                        .padding()
                        
                        VStack (alignment: .leading){
                            HStack {
                                Text("\(selectedStats)")
                                Image(systemName: "chevron.down")
                            }
                            .onTapGesture {
                                if heightDropdown < 50 {
                                    heightDropdown = 50
                                    opacityDropdown = 1
                                } else {
                                    heightDropdown = 0
                                    opacityDropdown = 0
                                }
                            }
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 300, height: CGFloat(heightDropdown))
                                .overlay {
                                    HStack {
                                        Text("Today")
                                            .fontWeight(selectedStats == "Today" ? .bold : .light)
                                            .onTapGesture {
                                                selectedStats = "Today"
                                            }
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: 2, height: 15)
                                        Text("Week")
                                            .fontWeight(selectedStats == "Week" ? .bold : .light)
                                            .onTapGesture {
                                                selectedStats = "Week"
                                            }
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: 2, height: 15)
                                        Text("Month")
                                            .fontWeight(selectedStats == "Month" ? .bold : .light)
                                            .onTapGesture {
                                                selectedStats = "Month"
                                            }
                                    }
                                    .foregroundStyle(getColor(business.businessTheme))
                                }
                                .opacity(opacityDropdown)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: screenWidth-20, height: 100)
                                .opacity(0.2)
                                .overlay {
                                    VStack (alignment: .leading){
                                        Text("Cash Earned: $46,700")
                                        Text("Time Studied: 1 hr 30 m 25s")
                                        Text("Levels Earned: 90")
                                        HStack (spacing: 2){
                                            Text("Leaderboard Position: 654")
                                            Image(systemName: "chevron.up")
                                                .font(.system(size: 15))
                                                .foregroundStyle(Color.mint)
                                        }
                                    }
                                    .frame(width: screenWidth-50, alignment: .leading)
                                }
                        }
                        .frame(width: screenWidth-20,height: screenHeight-400, alignment: .leading)
                        .animation(.linear, value: heightDropdown)
                        Spacer()
                        // Navigation link to Session History
                        NavigationLink(destination: SessionHistoryView(sessions: business.sessionHistory)) {
                            Text("View Session History")
                                .font(.system(size: 20))
                                .padding()
                                .background(getColor(business.businessTheme).suitableTextColor())
                                .foregroundColor(getColor(business.businessTheme))
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                    }
                    .foregroundStyle(getColor(business.businessTheme).suitableTextColor())
                    .navigationTitle("\(business.businessName)") // Title for the detail view
                    .navigationBarTitleDisplayMode(.inline) // Optional: display title inline
                }
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
    
    struct EditBusinessView: View {
        @Environment(\.modelContext) var context
        @Query var users: [UserDataModel]
        @Query var businesses: [BusinessDataModel] // Query for businesses
        @Query var sessionHistory: [SessionDataModel]
        
        @Bindable var business : BusinessDataModel
        
        @State var newName = ""
        
        var body: some View {
            VStack {
                Text("\(business.businessName)")
                
                TextField("\(business.businessName)", text: $newName)
                
                Button("Save") {
                    // Save data
                    editBusiness(business, newName)
                }
            }
        }
        
        func editBusiness(_ business : BusinessDataModel, _ name : String) {
            business.businessName = name
            
            try? context.save()
        }
    }
}

#Preview {
    BusinessDetails( business: BusinessDataModel(businessName: "Kims Shop", businessTheme: "Blue", businessType: "Economic", businessIcon: "triangle", cashPerMin: 3000, netWorth: 250000, sessionHistory: [SessionDataModel(id: UUID(), sessionDate: Date.now, sessionStart: formatFullDateTime(date: Date()), sessionEnd: formatFullDateTime(date: Date()), businessId: UUID(), totalStudyTime: 3600)], businessLevel: 302400, businessPrestige: "Growing Business"))
        .modelContainer(for: UserDataModel.self, inMemory: true)
        .environmentObject(ThemeManager())
}
