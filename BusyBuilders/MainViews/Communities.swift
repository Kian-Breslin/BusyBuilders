//
//  Communities.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 23/09/2024.
//

import SwiftUI

struct Communities: View {
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack {
                // Header
                VStack {
                    // Top Header
                    HStack {
                        VStack (alignment: .leading){
                            Text("$36,485")
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                            Text("Available Balance")
                        }
                        Spacer()
                        HStack (spacing: 15){
                            ZStack {
                                Image(systemName: "bell.fill")
                                Image(systemName: "2.circle.fill")
                                    .font(.system(size: 15))
                                    .offset(x: 10, y: -10)
                            }
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 40, height: 40)
                        }
                        .font(.system(size: 25))
                    }
                    .padding(15)
                    
                    HStack {
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 60, height: 60)
                            Text("Send Money")
                        }
                        Spacer()
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 60, height: 60)
                            Text("Request Money")
                        }
                        Spacer()
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 60, height: 60)
                            Text("Loans")
                        }
                        Spacer()
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 60, height: 60)
                            Text("Bank")
                        }
                    }
                    .padding(.horizontal, 15)
                    .font(.system(size: 12))
                }
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: screenWidth, height: screenHeight/1.5)
                    .overlay {
                        VStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(Color.blue)
                                .frame(width: screenWidth-13, height: 150)
                                .padding(15)
                                .overlay {
                                    HStack {
                                        Text("Important")
                                            .font(.system(size: 20))
                                            .fontWeight(.medium)
                                        
                                    }
                                }
                            
                            Spacer()
                        }
                    }
            }
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    Communities()
        .modelContainer(for: UserDataModel.self)
}
