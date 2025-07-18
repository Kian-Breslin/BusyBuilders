//
//  DashboardHome.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 17/07/2025.
//

import SwiftUI
import SwiftData

struct DashboardHome: View {
    @EnvironmentObject var userManager: UserManager
    let smallWidgetSize = CGSize(width: (screenWidth - 20) / 2, height: 90)
    let largeWidgetSize = CGSize(width: (screenWidth - 20) / 2, height: 190)
    let miniWidgetSize = CGSize(width: ((screenWidth - 20) / 2 - 5) / 2, height: (190 - 5) / 2)
    let xLargeWidgetSize = CGSize(width: (screenWidth - 15), height: 190)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                HStack(spacing: 5) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: smallWidgetSize.width, height: smallWidgetSize.height)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: smallWidgetSize.width, height: smallWidgetSize.height)
                }
                HStack(spacing: 5) {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: largeWidgetSize.width, height: largeWidgetSize.height)
                    
                    VStack(spacing: 5) {
                        HStack(spacing: 5) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: miniWidgetSize.width, height: miniWidgetSize.height)
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: miniWidgetSize.width, height: miniWidgetSize.height)
                        }
                        HStack(spacing: 5) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: miniWidgetSize.width, height: miniWidgetSize.height)
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: miniWidgetSize.width, height: miniWidgetSize.height)
                        }
                    }
                    .frame(width: largeWidgetSize.width, height: largeWidgetSize.height)
                }
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: xLargeWidgetSize.width, height: xLargeWidgetSize.height)
                HStack(spacing: 5) {
                    VStack(spacing: 5) {
                        HStack(spacing: 5) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: miniWidgetSize.width, height: miniWidgetSize.height)
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: miniWidgetSize.width, height: miniWidgetSize.height)
                        }
                        HStack(spacing: 5) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: miniWidgetSize.width, height: miniWidgetSize.height)
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: miniWidgetSize.width, height: miniWidgetSize.height)
                        }
                    }
                    .frame(width: largeWidgetSize.width, height: largeWidgetSize.height)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: largeWidgetSize.width, height: largeWidgetSize.height)
                }
                Spacer()
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

#Preview {
    Dashboard()
        .environmentObject(UserManager())
}
