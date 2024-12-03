//
//  ErrorView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 07/11/2024.
//

import SwiftUI

struct ErrorView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    
    var title: String = "Error"
    var message: String = "This is the Error Message, this will tell the user whats wrong"
    var onBack: () -> Void = {}
    var onConfirm: () -> Void = {}
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 250, height: 150)
            .foregroundStyle(themeManager.mainColor)
            .overlay {
                VStack {
                    Text("\(title)")
                        .font(.system(size: 20))
                        .bold()
                        
                    
                    Text("\(message)")
                        .padding(.horizontal, 10)
                    
                    Spacer()
                    
                    Divider()
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            onBack()
                        }) {
                            Text("Back")
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        
                        Divider() // Divider between buttons
                        
                        Button(action: {
                            onConfirm()
                        }) {
                            Text("Confirm")
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                    }
                    .frame(height: 30)
                }
                .padding(.vertical, 10)
                .foregroundStyle(themeManager.textColor)
            }
    }
}

#Preview {
    ErrorView()
        .environmentObject(ThemeManager())
}
