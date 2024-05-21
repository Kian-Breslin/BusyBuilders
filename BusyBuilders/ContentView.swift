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
    @State var theSelectedView = 0
    @State var theMakeNewBusiness = false
    @Query var businesses : [BusinessDataModel]
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                if(theSelectedView == 0) {
                    HomeView()
                }
                if(theSelectedView == 2) {
                    CalendarView()
                }
            }
            .sheet(isPresented: $theMakeNewBusiness, content: {
                CreateBusiness()
            })
            
            VStack {
                Spacer()
                
                NavigationBar(selectedView: $theSelectedView, makeNewBusiness: $theMakeNewBusiness)
            }
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
