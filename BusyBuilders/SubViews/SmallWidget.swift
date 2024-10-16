//
//  SmallWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 27/09/2024.
//

import SwiftUI

struct SmallWidget: View {
    
    var colorName : Color
    var imageName : String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .frame(width: 60, height: 60)
            .foregroundStyle(colorName)
            .overlay {
                Image(imageName)
                    .resizable()
                    .frame(width: 60, height: 60)
//                    .font(.system(size: 40))
                    .foregroundStyle(.white)
            }
    }
}

#Preview {
    SmallWidget(colorName: Color(red: 244/255, green: 73/255, blue: 73/255), imageName: "userImage-1")
}
