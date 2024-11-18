//
//  Notifications.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/10/2024.
//

import SwiftUI

struct Notifications: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack {
                
                Text("Notifications")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 30)
                    .padding(.horizontal)
                    .font(.system(size: 30))
                    .foregroundStyle(.black)
                
                Divider()
                    .padding(.horizontal)
                
                Text("Messages")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .font(.system(size: 20))
                    .foregroundStyle(.black)
                
                ScrollView {
                    MessageRow(isMessage: true, MessageImage: 1, MessageUser: "Kimberly Leon", MessageText: "Hey! Are you still available for Coffee Later? I was thinking around 4pm. I can't wait to see you!!", MessageTime: "13:32", MessageRead: false)
                    
                    MessageRow(isMessage: true, MessageImage: 2, MessageUser: "Kian Breslin", MessageText: "Hi! I hope you’re doing well. Just wanted to check in and see if you’ve had time to focus on your studies today. By the way, how’s your progress on the app? I’m interested to hear how your earnings are stacking up against mine!", MessageTime: "11:49", MessageRead: false)
                    
                    MessageRow(isMessage: true, MessageImage: 4, MessageUser: "Sarah Smith", MessageText: "Yo! I just wanted to reach out and see how your studying is going today. Have you been able to focus on your materials? Also, I’m interested in knowing how much you’ve earned on the app today. It’ll be fun to see who’s ahead!", MessageTime: "10:23", MessageRead: true)
                
                    MessageRow(isMessage: true, MessageImage: 6, MessageUser: "Sam Jones", MessageText: "You need to see this upgrade I just got for reaching level 43! Its AMAZING!!!", MessageTime: "09:03", MessageRead: true)
                }
                
                Divider()
                    .padding(.horizontal)
                
                Text("Updates")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .font(.system(size: 20))
                    .foregroundStyle(.black)
                
                ScrollView {
                    MessageRow(isMessage: false, MessageImage: 1, MessageUser: "Income", MessageText: "Your investments are paying off! Keep it up, you just earned $53,500", MessageTime: "12:42", MessageRead: false)
                    
                    MessageRow(isMessage: false, MessageImage: 2, MessageUser: "Bills", MessageText: "You owe $34,500 for your electricty bills this week! Pay as soon as possible to avoid a fine!", MessageTime: "10:25", MessageRead: false)
                    
                    MessageRow(isMessage: false, MessageImage: 4, MessageUser: "Bills", MessageText: "You owe $12,300 for you water bills this week! Pay as soon as possible to avoid a fine!", MessageTime: "10:23", MessageRead: true)
                }
            }
        }
    }
}

#Preview {
    Notifications()
        .environmentObject(ThemeManager())
}
