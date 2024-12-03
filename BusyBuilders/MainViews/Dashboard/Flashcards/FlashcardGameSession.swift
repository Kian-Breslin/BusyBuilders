//
//  FlashcardGameSession.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 25/11/2024.
//

import SwiftUI
import SwiftData

struct FlashcardGameSession: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss
    @Query var users: [UserDataModel]
    @Query var deckModel: [DeckModel]
    
    @Binding var gameFlashcards : [Flashcard]
    @State var isPracticeSession : Bool = false
    
    @State var correctAnswers : [Flashcard] = []
    @State var incorrectAnswers : [Flashcard] = []
    
    @State var answerCard = getColor("white")
    
    // Game Logic
    @State var selectedQuestion = 0
    @State var answer = ""
    @State var score = 0
    @State var buttonClickable = false
    @State var isGameOver = false
    
    let practiceDeck = [
        DeckModel(subject: "Geography", flashCards: [
         Flashcard(question: "What continent is Ireland in?", answer: "Europe"),
         Flashcard(question: "What is the largest desert in the world?", answer: "Sahara Desert"),
         Flashcard(question: "Which river is the longest in the world?", answer: "Nile River"),
         Flashcard(question: "What is the capital city of Australia?", answer: "Canberra"),
         Flashcard(question: "Which country has the most islands?", answer: "Sweden"),
         Flashcard(question: "What is the highest mountain in the world?", answer: "Mount Everest"),
         Flashcard(question: "Which U.S. state is known as the 'Sunshine State'?", answer: "Florida"),
         Flashcard(question: "What is the smallest country in the world?", answer: "Vatican City"),
         Flashcard(question: "What is the name of the longest mountain range?", answer: "Andes"),
         Flashcard(question: "Which sea is the saltiest in the world?", answer: "Dead Sea")
        ]),
        DeckModel(subject: "History", flashCards: [
            Flashcard(question: "Who was the first President of the United States?", answer: "George Washington"),
            Flashcard(question: "What year did World War II end?", answer: "1945"),
            Flashcard(question: "Who discovered America in 1492?", answer: "Christopher Columbus"),
            Flashcard(question: "What ancient civilization built the pyramids?", answer: "The Egyptians"),
            Flashcard(question: "Who was known as the 'Father of Modern Physics'?", answer: "Albert Einstein")
        ])
    ]
    
    var body: some View {
        
        if isGameOver == false {
            ZStack {
                themeManager.mainColor.ignoresSafeArea()
                
                VStack (spacing: 50){
                    Text("Flashcard Game Session")
                        .font(.title)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: screenWidth-30, height: 200)
                        .foregroundStyle(answerCard)
                        .overlay {
                            VStack (alignment: .leading){
                                Text("Question: \(selectedQuestion+1) / \(gameFlashcards.count)")
                                    .font(.title)
                                Spacer()
                                Text("\(gameFlashcards[selectedQuestion].question)")
                                    .font(.title2)
                                Spacer()
                            }
                            .foregroundStyle(themeManager.mainColor)
                            .frame(width: screenWidth-45, height: 185 ,alignment: .leading)
                        }
                    
                    VStack (alignment: .leading, spacing: 2){
                        Text("Answer: ")
                            .font(.system(size: 15))
                        
                        TextField("...", text: $answer)
                            .font(.system(size: 25))
                    }
                    .frame(width: screenWidth-30)
                    
                    Text("Score: \(score)")
                        .font(.largeTitle)
                    
                    Button("Submit"){
                        if answer == gameFlashcards[selectedQuestion].answer {
                            answerCard = Color.green
                            score += 1
                            buttonClickable = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                answerCard = themeManager.textColor
                                if selectedQuestion < gameFlashcards.count-1 {
                                    selectedQuestion += 1
                                    buttonClickable = false
                                } else {
                                    print("Game Complete! You got \(score) points")
                                    isGameOver.toggle()
                                }
                                answer = ""
                            }
                        }
                        else {
                            answerCard = Color.red
                            answer = gameFlashcards[selectedQuestion].answer
                            buttonClickable = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                print(selectedQuestion)
                                answerCard = themeManager.textColor
                                if selectedQuestion < gameFlashcards.count-1 {
                                    selectedQuestion += 1
                                    buttonClickable = false
                                } else {
                                    print("Game Complete! You got \(score) points")
                                    isGameOver.toggle()
                                }
                                answer = ""
                            }
                        }
                    }
                    .disabled(buttonClickable)
                    .frame(width: 100, height: 40)
                    .foregroundStyle(themeManager.mainColor)
                    .background(themeManager.textColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Spacer()
                }
            }
            .onAppear {
                if !gameFlashcards.isEmpty {
                    selectedQuestion = 0
                    answerCard = themeManager.textColor
                    gameFlashcards.shuffle()
                    print("Loaded \(gameFlashcards.count) flashcards.")
                } else {
                    print("No flashcards available.")
                    isGameOver = true // End the game if no flashcards are provided.
                }
            }
        }
        else {
            ZStack {
                themeManager.mainColor.ignoresSafeArea()
                
                VStack {
                    Text("You got \(score) points!")
                    Text("Your top score is 9")
                    Text("\(score > (gameFlashcards.count/2) ? "Good Job!" : "You can do better!")")
                    
                    Button("Done"){
                        dismiss()
                    }
                }
            }
        }
        
    }
}

#Preview {
    FlashcardGameSession(gameFlashcards: .constant([
        Flashcard(question: "What continent is Ireland in?", answer: "Europe")
       ]))
        .environmentObject(ThemeManager())
        .modelContainer(for: [UserDataModel.self], inMemory: true)
}
