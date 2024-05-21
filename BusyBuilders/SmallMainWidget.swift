//
//  SmallMainWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 21/05/2024.
//

import SwiftUI

struct SmallMainWidget: View {
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
            .frame(width: 170, height: 90)
            .foregroundStyle(Color(red:0.3, green: 0.3, blue: 0.3))
            .overlay {
                VStack (alignment: .leading, spacing: 3){
                    Text("Best Performing")
                        .foregroundStyle(.white.opacity(0.6))
                        .font(.system(size: 14))
                    Text("$143k")
                        .font(.system(size: 32))
                    ZStack (alignment: .leading){
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .frame(width: 150, height: 4)
                        RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            .frame(width: 120, height: 4)
                            .foregroundStyle(.red)
                        
                    }
                }
                .foregroundStyle(.white)
            }
    }
}

#Preview {
    SmallMainWidget()
}
