//
//  ShowBusiness.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 20/05/2024.
//

import SwiftUI

struct ShowBusiness: View {
    
    @State var businessName : String
    @State var businessCategory: String
    @State var businessDescription: String
    @State var businessIcon: String
    
    @State var businessInvestment: String
    @State var businessLevel: String
    @State var businessRevenueAmount: String
    @State var businessBadge: String
    
    @State var taskName: String
    @State var taskDescription: String
    @State var taskCategory: String
    @State var taskGoal: String
    @State var taskDeadline: Date
    @State var taskStartDate: Date
    
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            
            VStack {
                Text("\(businessName)")
                    .font(.largeTitle)
                Text("\(taskName)")
                
                VStack (alignment: .leading){
                    Text("Business Category: \(businessCategory)")
                    Text("Business Description: \(businessDescription)")
                    Text("Business Icon: \(businessIcon)")
                    
                    Text("Business Investment: \(businessInvestment)")
                    Text("Business Level: \(businessLevel)")
                    Text("Business Revenue Amount: \(businessRevenueAmount)")
                    Text("Business Badge: \(businessBadge)")
                    
                    Text("Task Description: \(taskDescription)")
                    Text("Task Category: \(taskCategory)")
                    Text("Task Goal: \(taskGoal)")
                    
                    Text("Task Deadline: \(taskDeadline, formatter: dateFormatter)")
                    Text("Task Start Date: \(taskStartDate, formatter: dateFormatter)")
                }
                .padding()
            }
        }
            .foregroundStyle(.white)
        }
    }
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

#Preview {
    ShowBusiness(businessName: "Example Business", businessCategory: "Example of business Category", businessDescription: "This is an example of the business description", businessIcon: "This will be the building", businessInvestment: "$100,000", businessLevel: "34", businessRevenueAmount: "$4,095,500", businessBadge: "Gold", taskName: "Example Task Name", taskDescription: "This is an example of the task description", taskCategory: "Example task description", taskGoal: "Example Tast Goal", taskDeadline: Date(), taskStartDate: Date())
}
