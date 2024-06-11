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
    
    @State var selectedBusiness : BusinessDataModel?
    @Binding var isSheetShowing : Bool
    @Binding var businessName : BusinessDataModel?
    @Binding var isTimerActive : Bool
    
    var body: some View {
        
        ZStack {
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
                                            businessName = business
                                            print(business.businessName)
                                            print(business)
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
        
        return StartTaskConfig(isSheetShowing: .constant(true), businessName: .constant(previewer.businesses[0]), isTimerActive: .constant(true))
    } catch {
        return Text("Failed to create preview : \(error.localizedDescription)")
    }
}
