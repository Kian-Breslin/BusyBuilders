//
//  CreateNewFlashcard.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 25/11/2024.
//

import SwiftUI
import SwiftData

struct CreateNewFlashcard: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Query var deckModel : [DeckModel]
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedDeck : DeckModel
    @State var question = ""
    @State var answer = ""
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack (spacing: 10){
              Text("Create New Card")
                    .font(.title)
                    .foregroundStyle(themeManager.textColor)
                
                VStack (alignment: .leading, spacing: 2){
                    Text("Question:")
                        .font(.headline)
                        .opacity(0.5)
                    TextField("|", text: $question)
                }
                VStack (alignment: .leading, spacing: 2){
                    Text("Answer:")
                        .font(.headline)
                        .opacity(0.5)
                    TextField("|", text: $answer)
                }
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 100, height: 40)
                    .overlay {
                        Image(systemName: "plus")
                            .foregroundStyle(themeManager.mainColor)
                    }
                    .onTapGesture {
                        let newCard = Flashcard(question: question, answer: answer)
                        
                        selectedDeck.flashCards.append(newCard)
                        
                        do {
                            try context.save()
                            dismiss()
                        } catch {
                            print("Couldnt add new card")
                        }
                    }
            }
            .frame(width: screenWidth-20)
            .foregroundStyle(themeManager.textColor)
        }
    }
}

#Preview {
    CreateNewFlashcard(selectedDeck: .constant(DeckModel(subject: "Geography")))
        .environmentObject(ThemeManager())
}
