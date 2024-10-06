//
//  MessageRow.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 28/09/2024.
//

import SwiftUI

struct MessageRow: View {
    
    @State var MessageUser : String
    @State var MessageText : String
    @State var MessageTime : String
    @State var MessageRead : Bool
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: "person")
                }
            
            VStack (alignment: .leading){
                Text("\(MessageUser)")
                Text("\(MessageText)")
                    .lineLimit(1) // Limit to one line
                    .truncationMode(.tail)
            }
            Spacer()
            VStack (alignment: .center){
                Text("\(MessageTime)")
                    .font(.system(size: 15))
                Circle()
                    .frame(width: 20)
                    .overlay {
                        if MessageRead == false {
                            Text("1")
                                .foregroundStyle(.red)
                        } else {
                            Text("")
                                .foregroundStyle(.red)
                        }
                    }
            }
        }

    }
}

#Preview {
    MessageRow(MessageUser: "Jason McGoldberg", MessageText: "Hey, are you still available for coffee later today?", MessageTime: "13:48", MessageRead: false)
}
