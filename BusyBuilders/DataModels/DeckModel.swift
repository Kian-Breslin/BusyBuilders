
import Foundation
import SwiftData

@Model
class DeckModel: Identifiable {
    var id: UUID
    var subject: String
    var attempts: Int
    var topScore: Int
    var correctPercentage: Double
    var lastPlayed: Date
    var flashCards: [Flashcard]
    
    init(id: UUID = UUID(), subject: String, attempts: Int = 0, topScore: Int = 0, correctPercentage: Double = 0.0, lastPlayed: Date = Date(), flashCards: [Flashcard] = []) {
        self.id = id
        self.subject = subject
        self.attempts = attempts
        self.topScore = topScore
        self.correctPercentage = correctPercentage
        self.lastPlayed = lastPlayed
        self.flashCards = flashCards
    }
}

@Model
class Flashcard: Identifiable {
    var id: UUID
    var question: String
    var answer: String
    var correctPercentage: Double
    
    init(id: UUID = UUID(), question: String, answer: String, correctPercentage: Double = 0.0) {
        self.id = id
        self.question = question
        self.answer = answer
        self.correctPercentage = correctPercentage
    }
}
