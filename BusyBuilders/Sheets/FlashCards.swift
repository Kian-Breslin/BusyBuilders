//
//  FlashCards.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 10/10/2024.
//

import SwiftUI
import SwiftData

struct FlashCards: View {
    
    @AppStorage("userColorPreference") var userColorPreference: String = "red"
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel] // Query for businesses
    
    var questionPacks = ["Geography", "Math", "History", "Science"]
    
    var geographyQuestionPack: [FlashCardModel] = [
        FlashCardModel(question: "What is the tallest mountain in the world?", answer: "Mount Everest", correct: false),
        FlashCardModel(question: "Which continent is known as the 'Dark Continent'?", answer: "Africa", correct: false),
        FlashCardModel(question: "What is the longest river in the world?", answer: "Amazon River", correct: false),
        FlashCardModel(question: "What is the capital of France?", answer: "Paris", correct: false),
        FlashCardModel(question: "Which ocean is the largest?", answer: "Pacific Ocean", correct: false),
        FlashCardModel(question: "What is the smallest country in the world?", answer: "Vatican City", correct: false),
        FlashCardModel(question: "Which mountain range separates Europe and Asia?", answer: "Ural Mountains", correct: false),
        FlashCardModel(question: "What desert is the largest in the world?", answer: "Antarctic Desert", correct: false),
        FlashCardModel(question: "Which river flows through Egypt?", answer: "Nile River", correct: false),
        FlashCardModel(question: "What is the capital of Japan?", answer: "Tokyo", correct: false)
    ]
    
    var mathQuestions: [String] = ["What is 2 + 2?", "What is 5 - 3?", "What is 6 × 3?", "What is 10 ÷ 2?", "What is 8 + 7?", "What is 9 - 4?", "What is 3 × 5?", "What is 12 ÷ 4?", "What is 15 + 6?", "What is 20 - 9?"]
    var mathAnswers: [String] = ["4", "2", "18", "5", "15", "5", "15", "3", "21", "11"]
    
    @State var selectedCategory = ""
    
    
    var body: some View {
        ZStack {
            getColor(userColorPreference)
                .ignoresSafeArea()
            
            VStack {
                Menu {
                    Picker("Select Category", selection: $selectedCategory) {
                        ForEach(questionPacks.indices, id: \.self){ i in
                            Text(questionPacks[i]).tag(questionPacks[i])
                        }
                    }
                } label: {
                    HStack {
                        Text("Select Category : \(selectedCategory)")
                            .foregroundColor(getColor(userColorPreference)) // Change the text color as needed
                            .padding()
                            .background(Color.white) // Customize background color if desired
                            .cornerRadius(8) // Optional: Add corner radius
                    }
                }
                .padding(40)
                
                if selectedCategory == "Geography" {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(geographyQuestionPack.indices, id: \.self){ i in
                                FlashCard(question: "\(geographyQuestionPack[i].question)", answer: "\(geographyQuestionPack[i].answer)")
                            }
                            .padding()
                            
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                }
                else {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(mathQuestions.indices, id: \.self){ i in
                                FlashCard(question: "\(mathQuestions[i])", answer: "\(mathAnswers[i])")
                            }
                            .padding()
                            
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                }
                Spacer()
                
                Button("Dismiss"){
                    dismiss()
                }
                .frame(width: 300, height: 50)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(getColor(userColorPreference))
                .fontWeight(.bold)
            }
            
        }
    }
}

#Preview {
    FlashCards()
}
