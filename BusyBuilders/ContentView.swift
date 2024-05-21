//
//  ContentView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 20/05/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var isShowingBusinessAddSheet = false
    @State private var isShowingBusinessShowSheet = false
    @Query var businesses : [BusinessDataModel]
    
    var body: some View {
        TabView {
            Group {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                            .foregroundStyle(.white)
                        Text("Home")
                    }
                TestView1()
                    .tabItem {
                        Image(systemName: "rectangle.3.group")
                        Text("Home")
                    }
            }
            .accentColor(.black)
            .toolbarBackground(.red, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)

        }
    }
}
        
//        VStack {
//            Text("Big Title")
//                .font(.largeTitle)
//                .bold()
//            
//            NavigationStack {
//                List(businesses) { business in
//                    NavigationLink(destination: ShowBusiness(businessName: business.businessName, businessCategory: business.businessCategory, businessDescription: business.businessDescription, businessIcon: business.businessIcon, businessInvestment: business.businessInvestment, businessLevel: business.businessLevel, businessRevenueAmount: business.businessRevenueAmount, businessBadge: business.businessBadges, taskName: business.taskName, taskDescription: business.taskDescription, taskCategory: business.taskCategory, taskGoal: business.taskGoal, taskDeadline: business.taskDeadline, taskStartDate: business.taskStartDate)) {
//                        Text(business.businessName)
//                    }
//                }
//                Spacer()
//                ZStack {
//                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
//                        .frame(width: 100, height: 50)
//                    Button("Add") {
//                        isShowingBusinessAddSheet = true
//                    }
//                }
//            }
//            .sheet(isPresented: $isShowingBusinessAddSheet, content: {
//                CreateBusiness()
//            })
//        }



#Preview {
    ContentView()
        .modelContainer(for: BusinessDataModel.self, inMemory: true)
}
