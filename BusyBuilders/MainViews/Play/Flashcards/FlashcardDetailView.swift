//
//  FlashcardDetailView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 29/11/2024.
//

import SwiftUI

struct FlashcardDetailView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var flashcard : Flashcard
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    FlashcardDetailView(flashcard: Flashcard(question: "What day is today", answer: "Friday"))
        .environmentObject(ThemeManager())
}
