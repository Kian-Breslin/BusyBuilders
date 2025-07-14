//
//  SquareModularWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 21/11/2024.
//

import SwiftUI
import SwiftData

struct SquareModularWidget: View {
    
    @EnvironmentObject var themeManager: ThemeManager
    @Query var users : [UserDataModel]
    var sessions : [SessionDataModel]
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(themeManager.mainColor)
            .frame(width: (screenWidth-20)/2, height: (screenWidth-45)/2)
            .overlay {
                VStack (alignment: .leading){
                    littleTimerView()
                    
                    Spacer()
                    
                    randomCircleDisplay()
                    
                }
                .frame(width: (screenWidth-65)/2, height: (screenWidth-75)/2, alignment: .leading)
                .foregroundStyle(themeManager.textColor)
                
            }
            .clipped()
            .onAppear {
//                if let user = users.first {
//                    
//                }
            }
    }
    func getBusinessImagesForTop5Sessions(top5Array: [SessionDataModel], businessDataArray: [BusinessDataModel]) -> [String] {
        var businessIcon: [String] = []

        for session in top5Array {
            print("Processing session with businessId: \(session.businessId)")

            if let matchingBusiness = businessDataArray.first(where: { $0.id == session.businessId }) {
                print("Found matching business: \(matchingBusiness.businessName), icon: \(matchingBusiness.businessIcon)")
                businessIcon.append(matchingBusiness.businessIcon)
            } else {
                print("No matching business found for businessId: \(session.businessId)")
            }
        }

        print("Final business icons array: \(businessIcon)")
        print("Session businessIds: \(top5Array.map { $0.businessId })")
        print("BusinessDataModel ids: \(businessDataArray.map { $0.id })")
        return businessIcon
    }
    
    func getTopSessions(sessions: [SessionDataModel]) -> [SessionDataModel] {
        // Sort the sessions in descending order based on totalStudyTime
        let sortedSessions = sessions.sorted { (session1, session2) -> Bool in
            return session1.totalStudyTime > session2.totalStudyTime
        }
        
        // Return the top sessions, up to 5, or the available sessions if fewer than 5
        return Array(sortedSessions.prefix(5))
    }
}


struct littleTimerView: View {
    @Query var users : [UserDataModel]
    @State var timeStudied = 0
    var body: some View {
        Text("Total Study Time")
            .font(.system(size: 15))
        
        HStack (alignment: .bottom, spacing: 2){
            
            Text("\(convertSecondsToTime(timeStudied)[0])")
                .font(.title)
            Text("H")
                .padding(.bottom, 5)
                .padding(.trailing, 5)
            
            Text("\(convertSecondsToTime(timeStudied)[1])")
                .font(.title)
            Text("M")
                .padding(.bottom, 5)
                .padding(.trailing, 5)
            
            Text("\(convertSecondsToTime(timeStudied)[2])")
                .font(.title)
            Text("S")
                .padding(.bottom, 5)
        }
        .font(.system(size: 12))
        .onAppear {
            if let user = users.first {
                timeStudied += calculateTotalStudyTime(for: user.businesses)
            }
        }
    }
}

struct randomCircleDisplay: View {
    @Query var users : [UserDataModel]
    @State var top5Array : [SessionDataModel] = []
    @State var top5BusinessIcons : [BusinessDataModel] = []
    let circleData = [
        (width: 65, offsetX: 0, offsetY: 0),
        (width: 65, offsetX: 105, offsetY: -55),
        (width: 50, offsetX: 115, offsetY: 10),
        (width: 45, offsetX: 65, offsetY: 0),
        (width: 40, offsetX: 40, offsetY: -40),
    ]
    
    var body: some View {
        ZStack {
            ForEach(0..<top5BusinessIcons.count, id: \.self) { i in
                Circle()
                    .frame(width: CGFloat(circleData[i].width))
                    .foregroundStyle(ThemeManager().textColor)
                    .overlay {
                        Image(systemName: "\(top5BusinessIcons[i].businessIcon)")
                            .foregroundStyle(ThemeManager().mainColor)
                            .font(.title)
                    }
                    .onTapGesture {
                        print("\(top5BusinessIcons[i].businessName)")
                    }
                    .offset(x: CGFloat(circleData[i].offsetX), y: CGFloat(circleData[i].offsetY))
            }
        }
        .onAppear {
            if let user = users.first {
                top5BusinessIcons.append(contentsOf: filterAndSortBusinessesByWeeklyStudyTime(businesses: user.businesses))
            }
        }
    }
    
    func filterAndSortBusinessesByWeeklyStudyTime(businesses: [BusinessDataModel]) -> [BusinessDataModel] {
        // Get the date for 7 days ago
        let calendar = Calendar.current
        let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        
        // Map businesses with their weekly total study time
        var businessWeeklyTime: [(business: BusinessDataModel, totalTime: Int)] = []
        
        for business in businesses {
            var totalTime = 0
            
            for session in business.sessionHistory {
                // Check if the session date is within the last 7 days
                if session.sessionDate >= sevenDaysAgo {
                    totalTime += session.totalStudyTime
                }
            }
            
            // Only include businesses with non-zero total study time
            if totalTime > 0 {
                businessWeeklyTime.append((business: business, totalTime: totalTime))
            }
        }
        
        // Sort the businesses by total study time in descending order
        let sortedBusinesses = businessWeeklyTime
            .sorted(by: { $0.totalTime > $1.totalTime })
            .map { $0.business }
        
        return sortedBusinesses
    }
}

#Preview {
    SquareModularWidget(sessions: [])
        .environmentObject(ThemeManager())
}
