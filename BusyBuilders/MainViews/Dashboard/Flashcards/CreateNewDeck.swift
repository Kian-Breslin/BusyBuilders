//
//  CreateNewDeck.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 02/12/2024.
//

import SwiftUI
import SwiftData

struct CreateNewDeck: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query var users: [UserDataModel]
    @Query var deckModel: [DeckModel]
    
    @Binding var newDeckSubject : String
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack (spacing: 10){
                Text("Create New Deck")
                    .font(.title)
                    .foregroundStyle(themeManager.textColor)
                
                VStack (alignment: .leading, spacing: 2){
                    Text("Subject:")
                        .font(.headline)
                        .opacity(0.5)
                    TextField("|", text: $newDeckSubject)
                }
            
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 100, height: 40)
                .overlay {
                    Image(systemName: "plus")
                        .foregroundStyle(themeManager.mainColor)
                }
                .onTapGesture {
                    let newDeck = DeckModel(subject: newDeckSubject)
                    
                    context.insert(newDeck)
                    
                    do {
                        try context.save()
                        newDeckSubject = ""
                        dismiss()
                        
                    } catch {
                        print("Couldnt add new card")
                    }
                }
            }
            .frame(width: screenWidth-30)
            .foregroundStyle(themeManager.textColor)
        }
    }
}

#Preview {
    CreateNewDeck(newDeckSubject: .constant(""))
        .environmentObject(ThemeManager())
}
