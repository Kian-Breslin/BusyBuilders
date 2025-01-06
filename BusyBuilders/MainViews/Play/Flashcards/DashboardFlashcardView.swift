//
//  DashbaordFlashcardView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 18/11/2024.
//

import SwiftUI
import SwiftData

struct DashboardFlashcardView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var deckModel: [DeckModel]
    
    @State var isGameSessionActive = false
    @State var gameSessionConfiguration = false
    @State var createNewDeck = false
    @State var newDeckSubject = ""
    
    // Session Config
    @State var deck : DeckModel = DeckModel(subject: "Geography")
    @State var isPracticeSession = false
    @State var isMultiDeck = false
    @State var selectedDecks: [DeckModel] = []
    @State var selectedFlashcards: [Flashcard] = []
    
    var body: some View {
        VStack (spacing: 5){
            VStack (alignment: .leading){
                Text("My Decks")
                    .font(.title2)
                
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 150, height: 150)
                            .overlay {
                                Image(systemName: "plus")
                                    .font(.system(size: 80))
                                    .foregroundStyle(themeManager.textColor)
                            }
                            .onTapGesture {
                                createNewDeck.toggle()
                            }
                        ForEach(deckModel) { i in
                            NavigationLink(destination: DeckDetailView(deck: i)){
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 150, height: 150)
                                    .overlay {
                                        Text("\(i.subject)")
                                            .font(.title2)
                                            .foregroundStyle(themeManager.textColor)
                                    }
                            }
                        }
                    }
                }
            }
            .frame(width: screenWidth-20)
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 150, height: 50)
                .overlay {
                    Text("Start")
                        .foregroundStyle(themeManager.textColor)
                        .font(.title2)
                }
                .onTapGesture {
                    gameSessionConfiguration.toggle()
                }
        }
        .foregroundStyle(themeManager.mainColor)
        .frame(width: screenWidth)
        .sheet(isPresented: $gameSessionConfiguration) {
            FlashcardGameSessionConfig(isGameSessionActive: $isGameSessionActive, isPracticeSession: $isPracticeSession, isMultiDeck: $isMultiDeck, selectedDecks: $selectedDecks, selectedFlashcards: $selectedFlashcards)
                .presentationDetents([.fraction(0.4)])
        }
        .sheet(isPresented: $createNewDeck){
            CreateNewDeck(newDeckSubject: $newDeckSubject)
            .presentationDetents([.fraction(0.4)])
        }
        .fullScreenCover(isPresented: $isGameSessionActive) {
            FlashcardGameSession(gameFlashcards: $selectedFlashcards)
        }
    }
    func combineFlashcards(from decks: [DeckModel]) -> [Flashcard] {
        var combinedFlashCards: [Flashcard] = []
        
        for deck in decks {
            combinedFlashCards.append(contentsOf: deck.flashCards)
        }
        
        return combinedFlashCards
    }
}

#Preview {
    DashboardFlashcardView()
        .environmentObject(ThemeManager())
        .modelContainer(for: [UserDataModel.self], inMemory: true)
}
