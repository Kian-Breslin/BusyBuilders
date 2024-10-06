//
//  MediumWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 27/09/2024.
//

import SwiftUI

struct MediumWidget: View {
    
    var colorName : Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: (screenWidth-30)/2, height: 130)
            .foregroundStyle(colorName)
    }
}

#Preview {
    MediumWidget(colorName: Color(red: 244/255, green: 73/255, blue: 73/255))
}
