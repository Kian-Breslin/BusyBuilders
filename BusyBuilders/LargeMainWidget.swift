//
//  LargeMainWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 21/05/2024.
//

import SwiftUI

struct LargeMainWidget: View {
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
            .frame(width: 370, height: 140)
            .foregroundStyle(Color(red:0.3, green: 0.3, blue: 0.3))
            .overlay {
                VStack (alignment: .leading, spacing: 5){
                    
                }
                .foregroundStyle(.white)
            }
    }
}

#Preview {
    LargeMainWidget()
}
