//
//  Settings.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 28/05/2024.
//

import SwiftUI
import SwiftData

struct Settings: View {
    
    @Environment(\.dismiss) var dismiss
    @Query var businesses : [BusinessDataModel]
    var bus = businessMockFill
    @State var selectedBusiness = "Chosen Business"
    @State var chosenTime = ""
    @Binding var isActiveState : Bool
    @Binding var selectedTime : String
    let timeOptions = ["30 mins", "1 hour", "1 hour 30", "2 hours"]
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.2)
            
            VStack (spacing: 50){
                ScrollView (.horizontal) {
                    HStack {
                        ForEach(bus) { b in
                            ZStack {
                                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                    .frame(width: 150, height: 150)
                                    .foregroundStyle(b.businessTheme)
                                VStack {
                                    Text(b.businessName)
                                        .font(.system(size: 25))
                                    Image(systemName: b.businessIcon)
                                        .font(.system(size: 50))
                                }
                            }
                            .padding()
                            .containerRelativeFrame(.horizontal, count: 2, spacing: 85)
                            .onTapGesture {
                                print(b.businessName)
                                selectedBusiness = b.businessName
                            }
                        }
                    }
                }
                Text("\(selectedBusiness)")
                    .font(.system(size: 40))
                
                Picker("Select a duration", selection: $selectedTime) {
                    ForEach(timeOptions, id: \.self) { time in
                        Text(time)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Button("Start Task") {
                    dismiss()
                    isActiveState.toggle()
                    print(selectedTime)
                }
                .frame(width: 100, height: 40)
                .background(.red)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.white)
                
                Spacer()
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    Settings(isActiveState: .constant(false), selectedTime: .constant("30 mins"))
}

