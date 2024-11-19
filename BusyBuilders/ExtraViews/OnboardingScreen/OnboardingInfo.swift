//
//  OnboardingCreateUser.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 18/11/2024.
//

import SwiftUI

struct OnboardingInfo: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Binding var currentScreen : Int
    @State var isFlipped = false
    @State var load = false
    
    let keyFeatureText = ["Dashboard", "Communites", "Play", "Store", "Portfolio"]
    
    var body: some View {
        ZStack {
            themeManager.mainColor
                .ignoresSafeArea()
            
            VStack (spacing: 15) {
                
                HStack (alignment: .bottom){
                    Text("Welcome to")
                        .font(.system(size: 25))
                    
                    Text("BusyBuilders")
                        .font(.system(size: 30))
                        .foregroundStyle(getColor(themeManager.secondaryColor))
                }
                
                Text("Get Ready to take control of your Studying!")
                Spacer()
                ScrollView(.horizontal){
                    HStack {
                        ForEach(0..<5){ i in
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .frame(width: 220, height: 470)
                                    .overlay {
                                        VStack {
                                            Text("This is the info about \(keyFeatureText[i])")
                                        }
                                        .foregroundStyle(themeManager.mainColor)
                                    }
                                    .opacity(isFlipped ? 1 : 0)
                                
                                Image("SimSSDashboard")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 200)
                                    .padding()
                                    .containerRelativeFrame(.horizontal, count: 1, spacing: 16)
                                    .opacity(isFlipped ? 0 : 1)
                            }
                            .animation(.smooth, value: isFlipped)
                            .onTapGesture {
                                isFlipped.toggle()
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                Spacer()
                HStack {
                    Spacer()
                    Circle()
                        .frame(width: 70, height: 70)
                        .padding()
                        .overlay {
                            Circle()
                                .trim(from: 0, to: load ? 0.33 : 0)
                                .stroke(lineWidth: 5)
                                .rotationEffect(Angle(degrees: -90))
                                .frame(width: 75, height: 75)
                                .foregroundStyle(getColor(themeManager.secondaryColor))
                            Image(systemName: "arrow.right")
                                .font(.system(size: 30))
                                .foregroundStyle(themeManager.mainColor)
                                .bold()
                        }
                }
                .animation(.linear(duration: 1), value: load)
                .onAppear {
                    load.toggle()
                }
                .onTapGesture {
                    currentScreen += 1
                }
            }
            .font(.system(size: 15))
            .padding()
            .foregroundStyle(themeManager.textColor)
        }
    }
}

#Preview {
    OnboardingInfo(currentScreen: .constant(0))
        .environmentObject(ThemeManager())
}
