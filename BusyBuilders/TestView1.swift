//
//  TestView1.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 21/05/2024.
//

import SwiftUI

struct TestView1: View {
    var body: some View {
        Circle()
            .foregroundStyle(.red)
            .overlay {
                Text("1")
                    .font(.system(size: 300))
            }
    }
}

#Preview {
    TestView1()
}
