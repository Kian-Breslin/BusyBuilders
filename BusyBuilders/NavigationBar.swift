//
//  TestView1.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 21/05/2024.
//

import SwiftUI

struct NavigationBar: View {
    
    @Binding var selectedView : Int
    @Binding var makeNewBusiness : Bool
    
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
            .frame(width: 280, height: 55)
            .foregroundStyle(.red)
            .overlay {
                HStack (spacing: 30){
                    Image(systemName: "house")
                        .onTapGesture {
                            selectedView = 0
                            print(selectedView)
                        }
                        
                    ZStack {
                        Circle()
                            .offset(y:-30)
                            .frame(width: 60, height: 60)
                        Image(systemName: "plus")
                            .foregroundStyle(.red)
                            .offset(y:-30)
                            .font(.largeTitle)
                    }
                    .onTapGesture {
                        makeNewBusiness = true
                        print(selectedView)
                    }
                    
                    Image(systemName: "rectangle.3.group")
                        .onTapGesture {
                            selectedView = 2
                            print(selectedView)
                        }
                    
                }
                .foregroundStyle(.white)
                .font(.title2)
            }
    }
}

#Preview {
    NavigationBar(selectedView: .constant(0), makeNewBusiness: .constant(false))
}
