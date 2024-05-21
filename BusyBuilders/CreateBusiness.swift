//
//  CreateBusiness.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 20/05/2024.
//

import SwiftUI
import SwiftData

struct CreateBusiness: View {
    
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var businessName : String = ""
    @State private var businessCategory: String = ""
    @State private var businessDescription: String = ""
    @State private var businessIcon: String = ""
    
    @State private var businessInvestment: String = ""
    @State private var businessLevel: String = ""
    @State private var businessRevenueAmount: String = ""
    @State private var businessBadge: String = ""
    
    @State private var taskName: String = ""
    @State private var taskDescription: String = ""
    @State private var taskCategory: String = ""
    @State private var taskGoal: String = ""
    @State private var taskDeadline: Date = Date()
    @State private var taskStartDate: Date = Date()
    
    var body: some View {
        Form {
            Section(header: Text("Business Details")) {
                TextField("Business Name", text: $businessName)
                TextField("Business Category", text: $businessCategory)
                TextField("Business Description", text: $businessDescription)
                TextField("Business Icon", text: $businessIcon)
                TextField("Investment", text: $businessInvestment)
                    .keyboardType(.decimalPad)
            }
            
            Section(header: Text("Task Details")) {
                TextField("Task Name", text: $taskName)
                TextField("Task Description", text: $taskDescription)
                TextField("Task Category", text: $taskCategory)
                TextField("Task Goal", text: $taskGoal)
                DatePicker("Task Deadline", selection: $taskDeadline, displayedComponents: .date)
            }
        }
        
        Button("Create"){
            let newBusiness = BusinessDataModel(businessName: businessName, businessCategory: businessCategory, businessDescription: businessDescription, businessIcon: businessIcon, businessInvestment: businessInvestment,businessLevel: businessLevel,businessRevenueAmount: businessRevenueAmount,businessBadges: businessBadge, taskName: taskName, taskDescription: taskDescription, taskCategory: taskCategory, taskGoal: taskGoal, taskDeadline: taskDeadline, taskStartDate: taskStartDate)
            context.insert(newBusiness)
            dismiss()
        }
        
    }
}

#Preview {
    CreateBusiness()
}
