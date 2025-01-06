//
//  Bingo.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 11/12/2024.
//

import SwiftUI

struct Bingo: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @State var optionalItems = [
        "calendar",
        "book",
        "laptopcomputer",
        "desktopcomputer",
        "pencil",
        "paperclip",
        "folder",
        "tray",
        "chart.bar",
        "chart.pie",
        "doc.text",
        "archivebox",
        "clock",
        "checkmark.circle",
        "xmark.circle",
        "magnifyingglass",
        "briefcase",
        "building.2",
        "building.columns",
        "dollarsign.circle",
        "creditcard",
        "banknote",
        "scissors",
        "paintbrush",
        "lightbulb",
        "gear",
        "hammer",
        "wrench",
        "mail",
        "envelope.open",
        "bell",
        "megaphone",
        "network",
        "brain",
        "graduationcap",
        "trophy",
        "star",
        "target",
        "cube",
        "gamecontroller"
    ]
    
    @State var bingoItems : [String] = []
    
    var body: some View {
        ZStack {
            themeManager.mainColor
                .ignoresSafeArea()
            
            VStack {
                
                
                
                Spacer()
                if bingoItems.count == 0{
                    BingoRows(optionalItems: $optionalItems)
                }
            }
            .padding(.bottom, 20)
        }
        .onAppear {
            print("Load Images")
        }
    }
}

struct BingoRows: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var optionalItems: [String]
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth-20, height: screenWidth-20)
            .foregroundStyle(themeManager.textColor)
            .overlay {
                VStack {
                    ForEach(0..<4){ row in
                        HStack {
                            ForEach(0..<4){ item in
                                BingoItems(itemName: optionalItems[item])
                            }
                        }
                    }
                }
                .foregroundStyle(.red)
            }
    }
}

struct BingoItems: View {
    @EnvironmentObject var themeManager: ThemeManager
    let bingoItemSize = (screenWidth-70)/4
    @State var itemName: String = "star"
    @State var isTapped: Bool = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: bingoItemSize, height: bingoItemSize)
            .overlay {
                Image(systemName: itemName)
                    .foregroundStyle(themeManager.textColor)
                    .font(.largeTitle)
            }
    }
}

#Preview {
    Bingo()
        .environmentObject(ThemeManager())
}
