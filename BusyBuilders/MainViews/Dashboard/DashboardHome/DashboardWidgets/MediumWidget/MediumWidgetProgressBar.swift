//
//  MediumWidgetProgressBar.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 13/08/2025.
//
import SwiftUI
import SwiftData

struct MediumWidgetProgressBar: View {
    @EnvironmentObject var userManager: UserManager
    let widgetSize = small1x4WidgetSize
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: widgetSize.width, height: widgetSize.height)
            .foregroundStyle(userManager.mainColor)
            .overlay {
                HStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(userManager.textColor, lineWidth: 2)
                        .frame(width: 70, height: 70)
                        .overlay {
                            Image(systemName: "wrench")
                                .font(.largeTitle)
                                .foregroundStyle(getColor(userManager.accentColor))
                        }
                    VStack (alignment: .leading){
                        Text("Progress Name: XYZ")
                            .font(.title2)
                        Label("85% Complete", systemImage: "checkmark.circle")
                            .font(.headline)
                        Spacer()
                    }
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 5, height: 70)
                }
                .foregroundStyle(userManager.textColor)
                .padding(10)
            }
    }
}

#Preview {
    MediumWidgetProgressBar()
        .environmentObject(UserManager())
}
