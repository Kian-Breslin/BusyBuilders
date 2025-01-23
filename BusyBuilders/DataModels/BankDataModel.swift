//
//  BankDataModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 07/01/2025.
//

import SwiftUI
import SwiftData
import Foundation

@Model
class BankDataModel: Identifiable {
    var id: UUID = UUID()
    var name: String
    var icon: String
    var loanInterestRate: Double
    var savingsInterestRate: Double
    var benefits: [String]
    
    init(name: String, icon: String, loanInterestRate: Double, savingsInterestRate: Double, benefits: [String]) {
        self.name = name
        self.icon = icon
        self.loanInterestRate = loanInterestRate
        self.savingsInterestRate = savingsInterestRate
        self.benefits = benefits
    }
}

@Model
class BankAccountModel: Identifiable {
    var id: UUID = UUID()
    var owner: UserDataModel
    var accountNumber: String
    var balance: Double
    var savingsBalance: Double
    var loans: [LoanModel]
    var transactions: [TransactionDataModel]
    
    init(owner: UserDataModel, accountNumber: String, balance: Double, savingsBalance: Double, loans: [LoanModel] = [], transactions: [TransactionDataModel] = []) {
        self.owner = owner
        self.accountNumber = accountNumber
        self.balance = balance
        self.savingsBalance = savingsBalance
        self.loans = loans
        self.transactions = transactions
    }
    
    func addLoan(loan: LoanModel) {
        loans.append(loan)
    }
    
    func addFunds(amount: Double) {
        balance += amount
    }
    
    func withdrawFunds(amount: Double) {
        if balance >= amount {
            balance -= amount
        }
    }
}

// Loan Model - Represents a loan taken by a user
@Model
class LoanModel: Identifiable {
    var id: UUID = UUID()
    var loanNumber: String
    var balance: Double
    var interestRate: Double
    var repaySchedule: RepaySchedule
    var duration: Int
    
    init(loanNumber: String, balance: Double, interestRate: Double, repaySchedule: RepaySchedule, duration: Int) {
        self.loanNumber = loanNumber
        self.balance = balance
        self.interestRate = interestRate
        self.repaySchedule = repaySchedule
        self.duration = duration
    }
    
    enum RepaySchedule: String, Codable {
        case daily = "Daily"
        case weekly = "Weekly"
        case biweekly = "Bi-Weekly"
        case monthly = "Monthly"
    }
}
