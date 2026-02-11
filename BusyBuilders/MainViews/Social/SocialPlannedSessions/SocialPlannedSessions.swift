//
//  SocialPlannedSessions.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 05/01/2026.
//

import SwiftUI
import SwiftData

struct SocialPlannedSessions: View {
    @Query var users: [UserDataModel]
    @Environment(\.modelContext) var context
    @EnvironmentObject var userManager: UserManager
    
    @State var timeStart: Date = Date()
    @State var timeEnd: Date = Date().addingTimeInterval(3600)
    var body: some View {
        ScrollView {
            VStack (spacing: 10){
                Text("Planned Sessions")
                ScrollView (.horizontal, showsIndicators: false){
                    HStack {
                        if let user = users.first {
                            ForEach(user.plannedSessions ?? [], id: \.self){ session in
                                plannedSessionItem(session: session)
                                    .padding(.horizontal, 5)
                                    .onTapGesture {
                                        session.completed?.toggle()
                                    }
                                    .onLongPressGesture {
                                        user.plannedSessions?.removeAll(where: {$0.id == session.id})
                                    }
                            }
                        }
                    }
                }
                
                VStack {
                    DatePicker("Chose Start Time:", selection: $timeStart)
                        .tint(.white)
                    DatePicker("Chose Date:", selection: $timeEnd)
                }
                .foregroundStyle(userManager.textColor)
                
                customButton(text: "Create New", color: .red, width: 150, height: 50) {
                    if let user = users.first {
                        let newPlannedSession = PlannedSession(id: UUID(), startTime: timeStart, endTime: timeEnd, type: "", completed: false, completedAt: Date.now)
                        newPlannedSession.user = user
                        user.plannedSessions?.append(newPlannedSession)
                        do {
                            try context.save()
                        } catch {
                            print("Couldnt Save")
                        }
                    }
                }
                .padding()
            }
        }
        .scrollIndicators(.hidden)
        .padding(.top, 15)
        .frame(width: screenWidth, height: screenHeight-240)
        .background(userManager.secondaryColor)
        .foregroundStyle(userManager.mainColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
struct plannedSessionItem: View {
    let session: PlannedSession
    @EnvironmentObject var userManager: UserManager
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 2)
            .foregroundStyle(userManager.textColor)
            .frame(width: screenWidth-15, height: 80)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(userManager.textColor).opacity(0.3)
                    .frame(width: screenWidth-15, height: 80)
                    .overlay {
                        HStack (alignment: .top){
                            VStack (alignment: .leading){
                                Text("Planned Session")
                                    .bold()
                                    .font(.title3)
                                Text("Start Time: \(formatTime(session.startTime ?? Date.now))")
                                    .font(.caption)
                                Text("End Time: \(formatTime(session.endTime ?? Date.now.addingTimeInterval(3600)))")
                                    .font(.caption)
                            }
                            Spacer()
                            HStack {
                                Text("\(formatTime(session.completedAt ?? Date.now))")
                                Circle()
                                    .foregroundStyle(session.completed ?? false ? Color.green : Color.red)
                                    .frame(width: 20, height: 20)
                            }
                        }
                        .padding(5)
                        .foregroundStyle(userManager.mainColor)
                    }
                
            }
            .padding(.horizontal, 5)
    }
}

//#Preview {
//    plannedSessionItem(session: PlannedSession(id: UUID()))
//        .environmentObject(UserManager())
//}

#Preview {
    Social(selectedIcon: "calendar.circle")
        .environmentObject(UserManager())
}
