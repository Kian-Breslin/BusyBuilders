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
    var businessDescription : String
    var businessIcon : String
    
    var businessInvestment : String
    var businessLevel : String
    var businessRevenueAmount : String
    var businessBadges : String
    
    var taskName : String
    var taskDescription : String
    var taskCategory : String
    var taskGoal : String
    var taskDeadline : Date
    var taskStartDate : Date
    
    init(businessName: String, businessCategory: String, businessDescription: String, businessIcon: String, businessInvestment: String, businessLevel: String, businessRevenueAmount: String, businessBadges: String, taskName: String, taskDescription: String, taskCategory: String, taskGoal: String, taskDeadline: Date, taskStartDate: Date) {
        self.businessName = businessName
        self.businessCategory = businessCategory
        self.businessDescription = businessDescription
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

var mockBusiness = [
    BusinessDataModel(businessName: "Business Name 1", businessCategory: "Business Category 1", businessDescription: "This is the description of the Business", businessIcon: "circle", businessInvestment: "100,000", businessLevel: "30", businessRevenueAmount: "$250,000", businessBadges: "7 Day Streak", taskName: "Task Name 1", taskDescription: "This is the description of the task", taskCategory: "Studying", taskGoal: "Learn how to do X", taskDeadline: Date(), taskStartDate: Date()),
    BusinessDataModel(businessName: "Business Name 2", businessCategory: "Business Category 1", businessDescription: "This is the description of the Business", businessIcon: "square", businessInvestment: "100,000", businessLevel: "30", businessRevenueAmount: "$250,000", businessBadges: "7 Day Streak", taskName: "Task Name 2", taskDescription: "This is the description of the task", taskCategory: "Studying", taskGoal: "Learn how to do Y", taskDeadline: Date(), taskStartDate: Date())
]

var nameBus = mockBusiness[0].businessName

