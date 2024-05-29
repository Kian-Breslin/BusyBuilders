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
            .frame(width: 320, height: 60)
            .foregroundStyle(Color(red: 1, green: 74/255, blue: 74/255))
            .overlay {
                HStack (spacing: 40){
                    Image(systemName: "house")
                        .font(.system(size: 30))
                        .onTapGesture {
                            selectedView = 0
                            print(selectedView)
                        }
                        
                    ZStack {
                        Circle()
                            .offset(y:-25)
                            .frame(width: 60, height: 60)
                        Image(systemName: "plus")
                            .foregroundStyle(.red)
                            .offset(y:-25)
                            .font(.system(size: 40))
                    }
                    .onTapGesture {
                        makeNewBusiness = true
                        print(selectedView)
                    }
                    
                    Image(systemName: "rectangle.3.group")
                        .font(.system(size: 30))
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
