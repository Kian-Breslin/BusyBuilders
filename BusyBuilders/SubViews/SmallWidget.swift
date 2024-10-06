//
//  SmallWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 27/09/2024.
//

import SwiftUI

struct SmallWidget: View {
    
    var colorName : Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 60, height: 60)
            .foregroundStyle(colorName)
    }
}

#Preview {
    SmallWidget(colorName: Color(red: 244/255, green: 73/255, blue: 73/255))
}
