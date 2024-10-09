//
//  DashboardTopButtons.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 08/10/2024.
//

import SwiftUI

struct DashboardTopButtons: View {
    
    @State var title : String
    @State var userColor : Color
    
    var body: some View {
        ZStack {
            userColor
                .ignoresSafeArea()
            
            VStack {
                Text("\(title)")
                    .font(.system(size: 40))
                
                Spacer()
                
                Text("This is a placeholder for the sheet view when you click : " + "\(title)")
                
                Spacer()
            }
                
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    DashboardTopButtons(title: "Send Money", userColor: Color(red: 244/255, green: 73/255, blue: 73/255))
}
