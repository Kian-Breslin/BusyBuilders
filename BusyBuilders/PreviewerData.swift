//
//  PreviewerData.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 01/06/2024.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container : ModelContainer
    let user : UserDataModel
    let businesses : [BusinessDataModel]
    
    init() throws {
         let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: BusinessDataModel.self, UserDataModel.self, configurations: config)
        
        businesses = 
            [BusinessDataModel(businessName: "My Business", businessCategory: "Category", businessIcon: "circle", businessInvestment: "100,000", businessLevel: "25", businessRevenueAmount: "150,000", businessBadges: "7 Day Streak", taskName: "Task Name", taskDescription: "Task Description", taskCategory: "Task Cateegory", taskGoal: "Task Goal", taskDeadline: Date(), taskStartDate: Date()),
             BusinessDataModel(businessName: "My Business 2", businessCategory: "Category", businessIcon: "circle", businessInvestment: "100,000", businessLevel: "25", businessRevenueAmount: "250,000", businessBadges: "7 Day Streak", taskName: "Task Name", taskDescription: "Task Description", taskCategory: "Task Cateegory", taskGoal: "Task Goal", taskDeadline: Date(), taskStartDate: Date())]
        user = UserDataModel(username: "Kian Breslin", userProfile: "", currentNumberOfBusinesses: 0, totalRevenue: 0)
        
        container.mainContext.insert(businesses[0])
        container.mainContext.insert(businesses[1])
        container.mainContext.insert(user)
    }
    
    
}
