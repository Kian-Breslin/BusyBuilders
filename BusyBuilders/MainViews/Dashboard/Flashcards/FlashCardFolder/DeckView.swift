//
//  DeckView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 15/11/2024.
//

import SwiftUI
import SwiftData

struct DeckView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Query var users: [UserDataModel]
    @Environment(\.modelContext) var context
    @State var deck : DeckModel
    
    var body: some View {
        ZStack {
            getColor("black")
                .ignoresSafeArea()
            
            VStack (alignment: .leading){
                Text("\(deck.subject)")
                    .font(.system(size: 30))
                    .padding(.bottom, 20)
                
                Text("Attempts: \(deck.attempts)")
                Text("Top Score: \(deck.topScore)")
                Text("Correct Percentage: \(deck.correctPercentage, specifier: "%.1f")%")
                Text("Top Score: \(getDayMonthYear(from: deck.lastPlayed) ?? "Not Played Yet")")
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack {
                        ForEach(deck.flashCards){ card in
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 150, height: 200)
                                .foregroundStyle(getColor("white"))
                                .overlay {
                                    VStack (alignment: .leading){
                                        Text("Question:")
                                        Text("\(card.question)")
                                            .font(.system(size: 12))
                                        
                                        Text("Answer:")
                                        Text("\(card.answer)")
                                            .font(.system(size: 12))
                                    }
                                    .foregroundStyle(getColor("black"))
                                    .padding()
                                }
                        }
                    }
                }
                
            }
            .frame(width: screenWidth-30, alignment: .leading)
        }
    }
}

#Preview {
    DeckView(deck: DeckModel(id: UUID(), subject: "Geography", attempts: 14, topScore: 23, correctPercentage: 83.4, lastPlayed: Date.now, flashCards: [
          Flashcard(id: UUID(), question: "What is the capital of France?", answer: "Paris"),
          Flashcard(id: UUID(), question: "Which river is the longest in the world?", answer: "The Nile"),
          Flashcard(id: UUID(), question: "What is the largest desert on Earth?", answer: "The Antarctic Desert"),
          Flashcard(id: UUID(), question: "What is the smallest country in the world?", answer: "Vatican City"),
          Flashcard(id: UUID(), question: "Which mountain range separates Europe and Asia?", answer: "The Ural Mountains"),
          Flashcard(id: UUID(), question: "What is the largest ocean on Earth?", answer: "The Pacific Ocean"),
          Flashcard(id: UUID(), question: "Which country has the most natural lakes?", answer: "Canada"),
          Flashcard(id: UUID(), question: "What is the name of the line dividing the Earth into Northern and Southern Hemispheres?", answer: "The Equator"),
          Flashcard(id: UUID(), question: "What is the tallest mountain in the world?", answer: "Mount Everest"),
          Flashcard(id: UUID(), question: "Which country has the highest population?", answer: "China")]
       )
    )
    .environmentObject(ThemeManager())
}
