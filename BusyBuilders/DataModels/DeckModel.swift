
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
    
    init(id: UUID, subject: String, attempts: Int, topScore: Int, correctPercentage: Double, lastPlayed: Date, flashCards: [Flashcard] = []) {
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
    
    init(id: UUID, question: String, answer: String) {
        self.id = id
        self.question = question
        self.answer = answer
    }
}
