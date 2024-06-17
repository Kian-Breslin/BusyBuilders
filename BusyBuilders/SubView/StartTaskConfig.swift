//
//  StartTaskConfig.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 09/06/2024.
//

import SwiftUI
import SwiftData

struct StartTaskConfig: View {
    
    @Query var businesses : [BusinessDataModel]
    
    @Binding var selectedBusiness : BusinessDataModel?
    @Binding var isSheetShowing : Bool
//    @Binding var businessName : BusinessDataModel?
    @Binding var isTimerActive : Bool
    @Binding var timeSelect : Int
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [.red, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack {
                ScrollView (.horizontal){
                    HStack {
                        ForEach(businesses, id: \.businessName) { business in
                                RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.red)
                                    .overlay {
                                        VStack{
                                            // Image
                                            Image(systemName : "\(business.businessIcon)")
                                                .font(.system(size: 60))
                                            // Name
                                            Text("\(business.businessName)")
                                                .font(.system(size: 30))
                                        }
                                        .onTapGesture {
                                            selectedBusiness = business
//                                            print(business.businessName)
//                                            print(business)
                                        }
                            }
                            .frame(width: 200, height: 150)
                        }
                    }
                }
                .padding()
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 350, height: 50)
                    .foregroundStyle(Color(red: 36/255, green: 36/255, blue: 36/255))
                    .overlay {
                        Text("\(selectedBusiness?.businessName ?? "Chosen Business")")
                            .font(.system(size: 30))
                            .foregroundStyle(.white)
                    }
                
                HStack {
                    Image(systemName: "minus.circle")
                        .font(.system(size: 30))
                        .onTapGesture {
                            if(timeSelect > 900){
                                timeSelect -= 900
                            }else {
                                timeSelect = 0
                            }
                        }
                    RoundedRectangle(cornerRadius: 10.0)
                        .foregroundStyle(Color(red: 36/255, green: 36/255, blue: 36/255))
                        .frame(width: 200, height: 40)
                        .overlay {
                            Text("\(timeFormattedMins(timeSelect))")
                                .foregroundStyle(.white)
                                .font(.title)
                        }
                    Image(systemName: "plus.circle")
                        .font(.system(size: 30))
                        .onTapGesture {
                            if(timeSelect <= 3599){
                                timeSelect += 900
                            }else {
                                timeSelect = 3600
                            }
                        }
                }
                
                Button("Start Timer"){
                    isSheetShowing = false
                    isTimerActive = true
                }
            }
        }
    }
}

#Preview {
//    StartTaskConfig(isSheetShowing: .constant(true), businessName: )
    
    do {
        let previewer = try Previewer()
        
        return StartTaskConfig(selectedBusiness: .constant(previewer.businesses[0]), isSheetShowing: .constant(true), isTimerActive: .constant(true), timeSelect: .constant(3600))
    } catch {
        return Text("Failed to create preview : \(error.localizedDescription)")
    }
}
