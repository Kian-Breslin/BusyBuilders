//
//  MessageRow.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 28/09/2024.
//

import SwiftUI

struct MessageRow: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    
    let notificationImages = ["tray.and.arrow.up", "tray.and.arrow.down"]
    @State var isMessage : Bool
    @State var MessageImage : Int
    @State var MessageUser : String
    @State var MessageText : String
    @State var MessageTime : String
    @State var MessageRead : Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: screenWidth-30, height: 75)
            .foregroundStyle(themeManager.mainColor)
            .overlay {
                HStack {
                    if isMessage == true {
                        Image("userImage-\(MessageImage)")
                            .resizable()
                            .frame(width: 40, height: 40)
                    } else {
                        Image(systemName: "\(notificationImages[0])")
                    }
                    
                    Divider()
                        .padding(.vertical)
                    Spacer()
                    
                    VStack (alignment: .leading, spacing: 0) {
                        Text("\(MessageUser)")
                            .frame(height: 25)
                            .padding(.top, 15)
                        Text("\(MessageText)")
                            .font(.system(size: 12))
                            .frame(height: 40, alignment: .top)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                    }
                    .frame(height: 75)
                    
                    Spacer()
                    
                    VStack (alignment: .trailing){
                        Text("\(MessageTime)")
                            .font(.system(size: 12))
                        Circle()
                            .frame(width: 15)
                            .foregroundStyle(MessageRead ? .gray : .green)
                    }
                }
                .padding(.horizontal)
            }
            .foregroundStyle(.white)

    }
}

#Preview {
    MessageRow(isMessage: true, MessageImage: 1, MessageUser: "Kimberly Leon", MessageText: "Hey! Are you still available for coffee later? I was thinking around 4pm. Let me know! I cant wait to see you", MessageTime: "13:32", MessageRead: false)
        .environmentObject(ThemeManager())
}
