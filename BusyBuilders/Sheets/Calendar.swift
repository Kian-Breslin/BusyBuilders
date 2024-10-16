//
//  Calendar.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 13/10/2024.
//

import SwiftUI
import SwiftData

struct Calendar: View {
    
    @AppStorage("userColorPreference") var userColorPreference: String = "red"
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel] // Query for businesses
    
    var body: some View {
        ZStack {
            Color.indigo
                .ignoresSafeArea()
            
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: (screenWidth-30)/2, height: 130)
                    .foregroundStyle(.cyan)
                    .overlay {
                        Image(systemName: "calendar")
                            .font(.system(size: 100))
                            .padding()
                            .foregroundStyle(.white)
                    }
                Spacer()
                Button("Dismiss"){
                    dismiss()
                }
                .frame(width: 300, height: 50)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(colorForName(userColorPreference))
                .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    Calendar()
}
