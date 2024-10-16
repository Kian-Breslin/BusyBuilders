//
//  FlashCardModel.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 12/10/2024.
//

import Foundation
import SwiftData


@Model
class FlashCardModel {
    var question : String
    var answer : String
    var correct : Bool
    
    init(question: String, answer: String, correct: Bool) {
        self.question = question
        self.answer = answer
        self.correct = correct
    }
}
