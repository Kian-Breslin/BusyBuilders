//
//  SessionStats.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 01/06/2024.
//

import SwiftUI

struct SessionStats: View {
    
    @State var amount : Int
    
    var body: some View {
        Text("\(amount)")
            .font(.system(size: 40))
    }
}

#Preview {
    SessionStats(amount: 0)
}
