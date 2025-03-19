//
//  RedeemCodesTest.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 07/03/2025.
//

import SwiftUI

struct RedeemCodesTest: View {
    @State var myCode = ""
    @State var myEmail = ""
    
    var body: some View {
        VStack {
            TextField("Enter your code", text: $myCode)
                .padding(10)
                .font(.system(size: 30))
            TextField("Enter your email", text: $myEmail)
                .padding(10)
                .font(.system(size: 30))
            
            Button("Redeem My Code"){
                fetchCodes()
            }
            
            Button("Post a code"){
                redeemCode(code: myCode, email: myEmail)
            }
        }
        .padding()
    }
}

#Preview {
    RedeemCodesTest()
}
