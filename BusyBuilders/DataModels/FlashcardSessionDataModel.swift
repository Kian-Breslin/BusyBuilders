//
//  FlashcardSessionDataModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/12/2024.
//

import SwiftUI
import SwiftData

@Model
class FlashcardSessionDataModel: Identifiable {
    var id: UUID
    var sessionDate: Date
    var sessionWin: Bool
    var sessionScore: Int
    var sessionValue: Int
    var sessionType: flashcardSessionType
    
    enum flashcardSessionType : String, Codable {
        case singleDeck = "Single Deck"
        case multiDeck = "Multi Deck"
    }
    
    init(id: UUID = UUID(), sessionDate: Date, sessionWin: Bool, sessionScore: Int, sessionValue: Int, sessionType: flashcardSessionType) {
        self.id = id
        self.sessionDate = sessionDate
        self.sessionWin = sessionWin
        self.sessionScore = sessionScore
        self.sessionValue = sessionValue
        self.sessionType = sessionType
    }
}
