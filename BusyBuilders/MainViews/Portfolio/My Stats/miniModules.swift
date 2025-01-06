//
//  miniModules.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/12/2024.
//

import SwiftUI

struct miniModules: View {
    
    @State var isTime: Bool = false
    @State var title: String = ""
    @State var textDetail: String = ""
    
    var body: some View {
        VStack (alignment: .leading){
            Text("\(title)")
                .opacity(0.5)
                .font(.system(size: 15))
            Text("\(textDetail)")
                .font(.system(size: 35))
        }
    }
}

#Preview {
    miniModules()
}
