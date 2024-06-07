//
//  StartTaskViewSettings.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 02/06/2024.
//

import SwiftUI
import SwiftData

struct StartTaskViewSettings: View {
    
    @Query var businesses : [BusinessDataModel]
    @Binding var chosenBusiness : BusinessDataModel
    
    var body: some View {
        VStack {
            ScrollView (.horizontal) {
                HStack {
                    ForEach(businesses) { b in
                        ZStack {
                            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                .frame(width: 150, height: 150)
                                .foregroundStyle(.red)
                            VStack {
                                Text("\(b.businessName)")
                                    .font(.system(size: 30))
                                Image(systemName: "circle")
                                    .font(.system(size: 40))
                            }
                        }
                        .padding()
                        .containerRelativeFrame(.horizontal, count: 2, spacing: 85)
                        .onTapGesture {
                            chosenBusiness = b
                            print(b)
                        }
                    }
                }
            }
            Text("Selected : \(chosenBusiness.businessName)")
        }

    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return StartTaskViewSettings(chosenBusiness: .constant(previewer.businesses[0]))
    } catch {
        return Text("Failed to create preview : \(error.localizedDescription)")
    }
}
