//
//  FlashcardGameSessionConfig.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 24/11/2024.
//

import SwiftUI
import SwiftData

struct FlashcardGameSessionConfig: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.dismiss) var dismiss
    @Query var users: [UserDataModel]
    @Query var deckModel: [DeckModel]
    
    // Session Config
    @Binding var isGameSessionActive : Bool
    @Binding var isPracticeSession : Bool
    @Binding var isMultiDeck : Bool
    @Binding var selectedDecks: [DeckModel]
    @Binding var selectedFlashcards : [Flashcard]
    
    var body: some View {
        ZStack {
            themeManager.mainColor
                .ignoresSafeArea()
            
            VStack {
                Text("Session Configuration")
                    .foregroundStyle(themeManager.textColor)
                
                if !deckModel.isEmpty {
                    VStack {
                        Text("My Decks")
                        ScrollView (.horizontal, showsIndicators: false){
                            HStack {
                                ForEach(deckModel, id: \.self) { d in
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundStyle(themeManager.textColor)
                                        .opacity(selectedDecks.contains(d) ? 0.5 : 1)
                                        .frame(width: 80, height: 80)
                                        .overlay{
                                            Text("\(d.subject)")
                                                .foregroundStyle(themeManager.mainColor)
                                        }
                                        .onLongPressGesture {
                                            print("This Deck: \(d.subject)")
                                            handleDeckSelection(d, isMultiDeck: isMultiDeck)
                                        }
                                }
                            }
                        }
                        .frame(width: screenWidth-30)
                    }
                }
                else {
                    Text("No Decks Found")
                }
                
                VStack {
                    Text("Selected Decks")
                    ScrollView (.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(selectedDecks, id: \.self) { d in
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(themeManager.textColor)
                                    .frame(width: 80, height: 80)
                                    .overlay{
                                        Text("\(d.subject)")
                                            .foregroundStyle(themeManager.mainColor)
                                    }
                                    .onLongPressGesture {
                                        print("Removed Deck: \(d.subject)")
                                        selectedDecks.removeAll { $0.id == d.id }
                                    }
                            }
                        }
                    }
                    .frame(width: screenWidth-30)
                }
                
                Toggle("Practice Session", isOn: $isPracticeSession)
                    .frame(width: screenWidth-30)
                
                Toggle("Multiple Decks", isOn: $isMultiDeck)
                    .frame(width: screenWidth-30)
                
                
                Button("Start Session"){
                    selectedFlashcards = combineFlashcards(from: selectedDecks)
                    for card in selectedFlashcards {
                        print(card.question)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        print("Session started: \(Date())")
                        dismiss()
                        
                        isGameSessionActive.toggle()
                    }
                }
                .frame(width: 150, height: 50)
                .background(themeManager.textColor)
                .foregroundStyle(themeManager.mainColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
    func combineFlashcards(from decks: [DeckModel]) -> [Flashcard] {
        var combinedFlashCards: [Flashcard] = []
        
        for deck in decks {
            combinedFlashCards.append(contentsOf: deck.flashCards)
        }
        
        return combinedFlashCards
    }
    func handleDeckSelection(_ deck: DeckModel, isMultiDeck: Bool) {
        if isMultiDeck {
            if !selectedDecks.contains(deck) {
                selectedDecks.append(deck)
            } else {
                print("This deck is already chosen")
            }
        } else {
            if selectedDecks.count > 0 {
                print("If you want to use multiple decks, please check it below")
            }
            else {
                if !selectedDecks.contains(deck) {
                    selectedDecks.append(deck)
                }
                else {
                    print("This deck is already chosen")
                }
            }
        }
    }
}


#Preview {
    FlashcardGameSessionConfig(isGameSessionActive: .constant(false), isPracticeSession: .constant(false), isMultiDeck: .constant(false), selectedDecks: .constant([]), selectedFlashcards: .constant([]))
        .environmentObject(ThemeManager())
}
