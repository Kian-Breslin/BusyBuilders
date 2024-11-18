//
//  FlashcardView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 15/11/2024.
//

import SwiftUI
import SwiftData

struct DeckList: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Query var users: [UserDataModel]
    @Query var deck: [DeckModel]
    @Environment(\.modelContext) var context
    
    @State var newDeck = ""
    
    var body: some View {
        if !deck.isEmpty {
            NavigationStack {
                ZStack {
                    getColor("white")
                        .ignoresSafeArea()
                    VStack (alignment: .leading){
                        Text("Decks")
                            .font(.system(size: 30))
                            .foregroundStyle(getColor("black"))
                        Spacer()
                        ForEach(deck, id: \.id) { deck in
                            NavigationLink (destination: DeckView(deck: deck)){
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(getColor("black"))
                                    .frame(width: screenWidth-30, height: 100)
                                    .opacity(0.5)
                                    .overlay{
                                        Text("Deck: \(deck.subject)")
                                        .foregroundStyle(getColor("white"))
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }

        } else {
            ZStack {
                getColor("black")
                    .ignoresSafeArea()
                VStack (spacing: 35){
                    Text("No Decks Found, Create One!")
                        .foregroundStyle(getColor("white"))
                    
                    VStack (alignment:.leading){
                        Text("Subject")
                            .font(.system(size: 15))
                            .opacity(0.5)
                        
                        ZStack (alignment: .leading){
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 250, height: 40)
                                .opacity(0.5)
                            TextField("\(newDeck)", text: $newDeck)
                                .foregroundStyle(getColor("white"))
                                .padding(.horizontal, 5)
                                .frame(width: 250)
                        }
                            
                    }
                    .foregroundStyle(getColor("white"))
                    
                    HStack {
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 200, height: 40)
                            .opacity(0.5)
                            .overlay {
                                Text("Create Deck")
                                    .font(.system(size: 25))
                                    .foregroundStyle(getColor("white"))
                            }
                            .onTapGesture {
                                print("Before user is confirmed")
                                if let user = users.first {
                                    let newDeck = DeckModel(id: UUID(), subject: newDeck, attempts: 0, topScore: 0, correctPercentage: 0, lastPlayed: Date())
                                    
                                    user.flashcards.append(newDeck)
                                    
                                    do {
                                        try context.save()
                                        print("It worked and saved")
                                    } catch {
                                        print("Nope")
                                    }
                                } else {
                                    print("No User")
                                }
                            }
                        
                        Spacer()
                    }
                    .padding(.bottom, 35)
                }
            }
        }
    }
}

#Preview {
    DeckList()
        .modelContainer(for: [UserDataModel.self])
        .environmentObject(ThemeManager())
}
