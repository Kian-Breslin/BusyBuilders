//
//  MeetingsView.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 30/05/2025.
//

import SwiftUI

struct MeetingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    enum BarType {
        case accounting, morale, productivity
    }
    
    struct DecisionOption: Identifiable {
        let id = UUID()
        let text: String
        let effects: [BarType : Int]
        let isDelay: Bool
    }
    
    struct Scenario {
        let description: String
        let options: [DecisionOption]
    }
    
    @State var delaysRemaining = 3
    @State var currentScenario = 0
    @State var currentBudget = 0
    
    let scenarios: [Scenario] = [
        Scenario(description: "Team requests Friday off", options: [
            DecisionOption(text: "Approve (+15 morale, -10 productivity)", effects: [.morale: 15, .productivity: -10], isDelay: false),
            DecisionOption(text: "Decline (-10 morale, +5 productivity)", effects: [.morale: -10, .productivity: 5], isDelay: false),
            DecisionOption(text: "Delay decision (no effect)", effects: [:], isDelay: true)
        ]),
        Scenario(description: "Client wants weekend support", options: [
            DecisionOption(text: "Say yes (+10 productivity, -15 morale)", effects: [.productivity: 10, .morale: -15], isDelay: false),
            DecisionOption(text: "Outsource (-10 accounting)", effects: [.accounting: -10], isDelay: false),
            DecisionOption(text: "Delay decision (no effect)", effects: [:], isDelay: true)
        ]),
        Scenario(description: "Accountant warns overspending", options: [
            DecisionOption(text: "Cut costs (+15 accounting, -10 morale)", effects: [.accounting: 15, .morale: -10], isDelay: false),
            DecisionOption(text: "Ignore (+10 morale, -10 accounting)", effects: [.morale: 10, .accounting: -10], isDelay: false),
            DecisionOption(text: "Delay decision (no effect)", effects: [:], isDelay: true)
        ])
    ]
    
    let atendees : [Atendee] = [
        Atendee(name: "Employee", face: "face.smiling", level: 100),
        Atendee(name: "Accounting", face: "face.smiling", level: 100),
        Atendee(name: "Productiviy", face: "", level: 100)
    ]
    var body: some View {
        ZStack {
            themeManager.mainColor.ignoresSafeArea()
            
            VStack {
                HStack {
                    MeetingAtendee(atendee: atendees[0])
                    
                    MeetingAtendee(atendee: atendees[1])
                    
                    MeetingAtendee(atendee: atendees[2])
                }
            }
            .foregroundStyle(themeManager.textColor)
        }
    }
}

struct Atendee {
    let name: String
    var face: String
    var level: Int
}

struct MeetingAtendee: View {
    var atendee: Atendee
    let colors : [Color] = [.red, .orange, .yellow, .green]
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 120, height: 150)
            .overlay {
                VStack {
                    Text(atendee.name)
                    Image(systemName: atendee.face)
                        .font(.system(size: 40))
                    Text("\(atendee.level)")
                }
                .font(.system(size: 25))
            }
    }
}

#Preview {
    MeetingsView()
        .environmentObject(ThemeManager())
}
