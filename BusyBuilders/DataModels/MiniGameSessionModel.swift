//
//  MiniGameSessionModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/12/2024.
//

import SwiftUI
import SwiftData

@Model
class MiniGameSessionModel : Identifiable {
    var id: UUID
    var sessionDate: Date
    var sessionWin: Bool
    var sessionScore: Int
    var sessionValue: Int
    var sessionGame: sessionGameDetails
    
    enum sessionGameDetails : String, Codable {
        case HigherOrLower = "Higher Or Lower"
        case Slots = "Slots"
        case Stocks = "Stocks"
    }
    
    init(id: UUID = UUID(), sessionDate: Date, sessionWin: Bool, sessionScore: Int, sessionValue: Int, sessionGame: sessionGameDetails) {
        self.id = id
        self.sessionDate = sessionDate
        self.sessionWin = sessionWin
        self.sessionScore = sessionScore
        self.sessionValue = sessionValue
        self.sessionGame = sessionGame
    }
}
