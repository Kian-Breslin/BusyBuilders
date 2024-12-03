//
//  TransactionDataModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 28/11/2024.
//

import Foundation
import SwiftData

@Model
class TransactionDataModel: Identifiable {
    var id: UUID
    var amount: Int
    var transactionDescription: String
    var createdAt: Date
    var income: Bool
    
    init(id: UUID = UUID(), amount: Int, transactionDescription: String, createdAt: Date, income: Bool) {
        self.id = id
        self.amount = amount
        self.transactionDescription = transactionDescription
        self.createdAt = createdAt
        self.income = income
    }
}
