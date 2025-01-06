//
//  FlashcardDetailView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 25/11/2024.
//

import SwiftUI

struct DeckDetailView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var deck : DeckModel
    
    // New Flashcard
    @State var createNewFlashcard = false
    @State var settingsActive = false
    @State var isFlashing = false
    
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack (alignment: .leading, spacing: 25){
                HStack {
                    if settingsActive {
                        TextField("\(deck.subject)", text: $deck.subject)
                            .foregroundStyle(getColor("\(themeManager.secondaryColor)"))
                            .opacity(isFlashing ? 0.5 : 1)
                            .animation(.linear, value: isFlashing)
                    }
                    else {
                        Text("\(deck.subject)")
                    }
                    Spacer()
                    Text(settingsActive ? "Save" : "Edit")
                        .font(.system(size: 15))
                        .underline()
                        .onTapGesture {
                            settingsActive.toggle()
                            isFlashing.toggle()
                            _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                                isFlashing.toggle()
                            }
                        }
                }
                .font(.largeTitle)
                .foregroundStyle(themeManager.textColor)
                .padding(.bottom, 25)
                
                VStack (alignment: .leading){
                    Text("Top Score:")
                        .font(.subheadline)
                    Text("\(deck.topScore)")
                }
                VStack (alignment: .leading){
                    Text("Correct Percentage:")
                        .font(.subheadline)
                    Text("\(deck.correctPercentage, specifier: "%.1f")%")
                }
                VStack (alignment: .leading){
                    Text("Total Attempts:")
                        .font(.subheadline)
                    Text("\(deck.attempts)")
                }
                VStack (alignment: .leading){
                    Text("Last Played:")
                        .font(.subheadline)
                    Text("\(getDayMonthYear(from: deck.lastPlayed) ?? "")")
                }
                VStack (alignment: .leading){
                    Text("Flashcards in Deck:")
                        .font(.subheadline)
                    Text("\(deck.flashCards.count)")
                }
                VStack (alignment: .leading){
                    Text("Flashcards:")
                        .font(.subheadline)
                    ScrollView (.horizontal, showsIndicators: false){
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 100, height: 100)
                                .foregroundStyle(themeManager.textColor)
                                .overlay {
                                    Image(systemName: "plus")
                                        .foregroundStyle(themeManager.mainColor)
                                        .font(.largeTitle)
                                }
                                .onTapGesture {
                                    createNewFlashcard.toggle()
                                }
                            ForEach(deck.flashCards){ card in
                                NavigationLink (destination: FlashcardDetailView(flashcard: card)){
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 100, height: 100)
                                        .foregroundStyle(themeManager.textColor)
                                        .overlay {
                                            VStack {
                                                Text("\(card.question) ?")
                                                    .foregroundStyle(themeManager.mainColor)
                                                    .font(.caption)
                                                Text(card.answer)
                                                    .foregroundStyle(themeManager.mainColor)
                                                    .font(.caption)
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .frame(width: screenWidth-20, alignment: .leading)
            .foregroundStyle(themeManager.textColor)
            .font(.title3)
        }
        .sheet(isPresented: $createNewFlashcard) {
            CreateNewFlashcard(selectedDeck: $deck)
                .presentationDetents([.fraction(0.4)])
        }
    }
}

#Preview {
    DeckDetailView(deck: DeckModel(subject: "Geography", attempts: 32, topScore: 11, correctPercentage: 84.5, lastPlayed: Date(), flashCards: [
        Flashcard(question: "What day is it", answer: "Monday"),
        Flashcard(question: "What year is it", answer: "2024"),
        Flashcard(question: "What day is tomorrow", answer: "Tuesday")
    ]))
        .environmentObject(ThemeManager())
}
