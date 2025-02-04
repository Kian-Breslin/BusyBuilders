//
//  UserModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 04/10/2024.
//
import Foundation
import SwiftData

@Model
public class UserDataModel: Identifiable, ObservableObject {
    public var id: UUID // Unique identifier for the user
    var username: String
    var name: String // User's chosen username
    var email: String // User's email address
    var password: String
    var businesses: [BusinessDataModel] // List of businesses owned by the user
    var availableBalance: Int
    var netWorth: Int
    var level: Int
    var created: Date
    var flashcards: [DeckModel]
    var transactions: [TransactionDataModel]
    var miniGameSessions: [MiniGameSessionModel]
    var flashcardSessions: [FlashcardSessionDataModel]
    
    var inventory: [String : Int] = [:]
    
    // Initialize the UserDataModel with default values
    init(id: UUID = UUID(),
         username: String,
         name: String,
         email: String,
         password: String = "",
         availableBalance: Int = 0,
         netWorth: Int = 0,
         level: Int = 0,
         created: Date = Date.now,
         flashcards: [DeckModel] = [],
         transactions: [TransactionDataModel] = [],
         miniGameSessions: [MiniGameSessionModel] = [],
         flashcardSessions: [FlashcardSessionDataModel] = []) {
        self.id = id
        self.username = username
        self.name = name
        self.email = email
        self.password = password
        self.businesses = []
        self.availableBalance = availableBalance
        self.netWorth = netWorth
        self.level = level
        self.created = created
        self.inventory = [
            "Cash Booster" : 0,
            "Experience Booster" : 0,
            "Cost Reduction" : 0,
            "Break Booster" : 0
        ]
        self.flashcards = flashcards
        self.transactions = transactions
        self.miniGameSessions = miniGameSessions
        self.flashcardSessions = flashcardSessions
    }
}
