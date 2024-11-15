//
//  CreateDeck.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 15/11/2024.
//

import SwiftUI
import SwiftData

struct CreateFlashcard: View {
    
    @Query var users: [UserDataModel]
    @State private var selectedDeck: String = "None"
    @Query var deck: [DeckModel]
    @Environment(\.modelContext) var context
    
    @State var subjectName = ""
    @State var flashcardQuestion = ""
    @State var flashcardAnswer = ""
    @State var newFlashcardDeck : [Flashcard] = []
    @State var chosenDeck : DeckModel?
    
    
    var body: some View {
        ZStack {
            getColor("white")
                .ignoresSafeArea()
            
            VStack (alignment: .leading){
                Text("Create Your Flashcards")
                    .font(.system(size: 30))
                    .padding(.bottom, 40)
                
                VStack (alignment: .leading, spacing: 2){
                    Text("Subject")
                        .font(.system(size: 15))
                        .opacity(0.8)
                    
                    VStack {
                        if let user = users.first, !user.flashcards.isEmpty {
                            Menu {
                                ForEach(user.flashcards, id: \.id) { deck in
                                    Button(action: {
                                        chosenDeck = deck
                                    }) {
                                        Text(deck.subject)
                                    }
                                }
                            } label: {
                                Text(chosenDeck?.subject ?? "No Deck")
                                    .foregroundStyle(.black)
                                Image(systemName: "chevron.down")
                                    .foregroundStyle(.gray)
                                
                            }
                        } else {
                            Text("No Decks Available")
                                .foregroundStyle(.red)
                        }
                        Spacer()
                    }
                    .frame(height: 70)
                }
                
                VStack (alignment: .leading, spacing: 2){
                    Text("Add Flashcards")
                        .font(.system(size: 20))
                        .opacity(0.8)
                    
                    HStack {
                        VStack (alignment: .leading, spacing: 2){
                            Text("Question")
                                .font(.system(size: 15))
                                .opacity(0.8)
                                .foregroundStyle(getColor("black"))
                            
                            ZStack (alignment: .topLeading){
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 180, height: 90)
                                    .opacity(0.5)
                                    .foregroundStyle(getColor("black"))
                                TextField("\(flashcardQuestion)", text: $flashcardQuestion, axis: .vertical)
                                    .foregroundStyle(getColor("white"))
                                    .padding(.horizontal, 5)
                                    .frame(width: 180, height: 90, alignment: .topLeading)
                            }
                        }
                        Spacer()
                        VStack (alignment: .leading, spacing: 2){
                            Text("Answer")
                                .font(.system(size: 15))
                                .opacity(0.8)
                                .foregroundStyle(getColor("black"))
                            
                            ZStack (alignment: .topLeading){
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 180, height: 90)
                                    .opacity(0.5)
                                    .foregroundStyle(getColor("black"))
                                TextField("\(flashcardAnswer)", text: $flashcardAnswer, axis: .vertical)
                                    .foregroundStyle(getColor("white"))
                                    .padding(.horizontal, 5)
                                    .frame(width: 180, height: 90, alignment: .topLeading)
                            }
                        }
                    }
                    
                }
                
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 30, height: 30)
                        .opacity(0.5)
                        .overlay {
                            Image(systemName: "plus")
                                .font(.system(size: 25))
                                .foregroundStyle(getColor("white"))
                        }
                        .onTapGesture {
                            let newFlashCard = Flashcard(id: UUID(), question: flashcardQuestion, answer: flashcardAnswer)
                            
                            if (flashcardQuestion.count != 0) && (flashcardAnswer.count != 0) && chosenDeck != nil {
                                chosenDeck?.flashCards.append(newFlashCard)
                                print("Added Flashcard to \(subjectName) - Question: \(flashcardQuestion), Answer: \(flashcardAnswer)")
                                flashcardQuestion = ""
                                flashcardAnswer = ""
                            } else {
                                print("There is no question or answer")
                                newFlashcardDeck.append(Flashcard(id: UUID(), question: "flashcardQuestion", answer: "flashcardAnswer"))
                            }
                        }
                }
                

                if let deck = chosenDeck, !deck.flashCards.isEmpty {
                    ZStack {
                        ForEach(deck.flashCards) { card in
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 80, height: 120)
                                .rotationEffect(Angle(degrees: Double.random(in: -30...30)))
                                .foregroundColor((newFlashcardDeck.firstIndex(of: card) ?? 0) % 2 == 0 ? .gray : getColor("black"))
                                .overlay {
                                    Text("Flashcard")
                                        .font(.system(size: 15))
                                        .foregroundStyle(getColor("white"))
                                        .rotationEffect(Angle(degrees: Double.random(in: -30...30)))
                                }
                        }
                    }
                    .frame(width: screenWidth - 30, height: 150)
                } else {
                    Text("No flashcards available.")
                        .foregroundColor(.gray)
                        .padding()
                }
                Spacer()
            }
            .foregroundStyle(getColor("black"))
            .frame(width: screenWidth-30, alignment: .leading)
        }
    }
}

#Preview {
    CreateFlashcard()
}
