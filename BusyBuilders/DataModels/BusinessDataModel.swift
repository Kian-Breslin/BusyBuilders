//
//  BusinessDataModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 20/05/2024.
//

import Foundation
import SwiftData

@Model
public class BusinessDataModel : Identifiable{
    
    var businessName : String
    var businessCategory : String
    var businessIcon : String
    
    var businessInvestment : String
    var businessLevel : String
    var businessRevenueAmount : Int
    var businessBadges : String
    
    var taskName : String
    var taskDescription : String
    var taskCategory : String
    var taskGoal : String
    var taskDeadline : Date
    var taskStartDate : Date
    
    init(businessName: String, businessCategory: String, businessIcon: String, businessInvestment: String, businessLevel: String, businessRevenueAmount: Int, businessBadges: String, taskName: String, taskDescription: String, taskCategory: String, taskGoal: String, taskDeadline: Date, taskStartDate: Date) {
        self.businessName = businessName
        self.businessCategory = businessCategory
        self.businessIcon = businessIcon
        self.businessInvestment = businessInvestment
        self.businessLevel = businessLevel
        self.businessRevenueAmount = businessRevenueAmount
        self.businessBadges = businessBadges
        self.taskName = taskName
        self.taskDescription = taskDescription
        self.taskCategory = taskCategory
        self.taskGoal = taskGoal
        self.taskDeadline = taskDeadline
        self.taskStartDate = taskStartDate
    }
}


