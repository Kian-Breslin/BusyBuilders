//
//  ConfirmDeletePopUp.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 30/06/2025.
//

import SwiftUI

struct ConfirmDeletePopUp: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Button("Confirm"){
                    
                }
                .frame(width: 250, height: 60)
                .foregroundStyle(.white)
                .background(.red)
                .clipShape(Capsule())
                .bold()
            }
        }
    }
}

#Preview {
    ConfirmDeletePopUp()
}
