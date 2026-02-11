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
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                HStack(spacing: 5) {
                    SmallWidgetAvailableBalance()
                    
                    SmallWidgetIncomeDate()
                        
                }
                HStack(spacing: 5) {
                    LargeWidgetRecentSession()
                    
                    VStack(spacing: 5) {
                        HStack(spacing: 5) {
                            MiniWidgetStartSession(quickStartSession: $userManager.quickStartSession)
                            MiniWidgetStreakCounter()
                        }
                        HStack(spacing: 5) {
                            MiniWidgetActiveBusinesses()
                            MiniWidgetPortfolioLook()
                        }
                    }
                    .frame(width: largeWidgetSize.width, height: largeWidgetSize.height)
                }
                MediumRandomBusiness()
                MediumRandomBusiness()
                XLargeWidgetWeeklyGraph()
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
        .padding(.bottom, 65)
        .frame(width: screenWidth, height: screenHeight-240)
        .background(userManager.secondaryColor)
        .foregroundStyle(userManager.mainColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .fullScreenCover(isPresented: $userManager.quickStartSession) {
            if userManager.quickSessionScreen == "Beach" {
                BeachViewTimer()
            } else if userManager.quickSessionScreen == "Sunset" {
                TimerSunset()
            } else if userManager.quickSessionScreen == "Red Mountains" {
                RedMountainTimer()
            } else if userManager.quickSessionScreen == "Lighthouse" {
                TimerLighthouse()
            }
        }
    }
}

#Preview {
    Dashboard()
        .environmentObject(UserManager())
}
