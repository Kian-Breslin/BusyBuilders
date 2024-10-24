//
//  LargeWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 27/09/2024.
//

import SwiftUI

struct LargeWidget: View {
    
    @AppStorage("userTextPreference") var userTextPreference: String = "white"
    @State var selectedView : Int
    var colorName : Color
    // List of Widget :
    // 1. Revenue ( Daily, Weekly, Monthly )
    // 2. Streak Calendar
    // 3. Leaderboard
    // 4. Specific Business Stats ( Revenue, Total Hours, Level, Quick start )
    let daysInWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    let daysInMonth: [Int] = Array(1...31) // Adjust based on the month
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 7)
    @State var numberDate = getDayOfMonth(from: Date())
    
    // Small Schedule
    let scheduleTexts = ["Meeting with CEO", "Grab Coffee with Kim", "Call Jerry!", "Prepare presentation for client", "Attend team meeting", "Finish report on Q3 sales", "Lunch with project manager", "Review design documents", "Submit expense reports", "Update website content", "Schedule performance reviews", "Check emails", "Work on budget proposal", "Brainstorm ideas for new campaign", "Draft the project timeline", "Participate in code review", "Plan marketing strategy", "Catch up on industry news", "Organize team-building activity", "Conduct user research", "Follow up with vendors", "Create social media posts", "Design promotional materials", "Set up new software tools", "Host a webinar"]
    @State var timeOfDay = currentHour()
    
    var body: some View {
        if selectedView == 0 {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(colorName)
                .frame(width: screenWidth-15, height: 130)
                .padding(.top, 15)
                .overlay {
                    HStack {
                        Image("Revenue - 30 days")
                            .resizable()
                            .frame(width: screenWidth-15, height: 150)
                    }
                }
        }
        else if selectedView == 1 {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(colorName)
                .frame(width: screenWidth-15, height: 150)
                .overlay {
                    Image(systemName: "calendar")
                        .font(.system(size: 100))
                        .padding()
                        .foregroundStyle(textColor(userTextPreference))
                }
        }
        else if selectedView == 2 {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(colorName)
                .frame(width: screenWidth-15, height: 200)
                .overlay {
                    HStack {
                        // LEFT SIDE
                        // TOP
                        VStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: (screenWidth-40)/2, height: 100)
                                .overlay {
                                    VStack (alignment: .leading) {
                                        HStack {
                                            Text("\(numberDate ?? 1) Oct 24")
                                                .font(.system(size: 30))
                                                .onTapGesture {
                                                    if numberDate ?? 0 <= 30 {
                                                        numberDate! += 1
                                                    } else {
                                                        numberDate = 1
                                                    }
                                                }
                                            Spacer()
                                            Image(systemName: "calendar")
                                                .font(.system(size: 30))
                                        }
                                        
                                        VStack {
                                            // Header for the days of the week
                                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                                                Group {
                                                    Text("Sun")
                                                    Text("Mon")
                                                    Text("Tue")
                                                    Text("Wed")
                                                    Text("Thu")
                                                    Text("Fri")
                                                    Text("Sat")
                                                }
                                                .font(.system(size: 8))
                                            }

                                            // Static grid for the days in the month (1 to 31)
                                            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                                                ForEach(1...31, id: \.self) { day in
                                                    if day == numberDate {
                                                        Text("\(day)")
                                                            .frame(width: 20, height: 15)
                                                            .font(.system(size: 12))
                                                            .frame(minWidth: 0, minHeight: 0, alignment: .center) // Center text
                                                            .foregroundStyle(colorName)
                                                            .background(textColor(userTextPreference))
                                                            .clipShape(RoundedRectangle(cornerRadius: 2))
                                                            
                                                    } else {
                                                        Text("\(day)").font(.system(size: 12))
                                                            .frame(minWidth: 0, minHeight: 0, alignment: .center) // Center text
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .foregroundStyle(textColor(userTextPreference))
                                    
                                    
                                }
                                // BOTTOM
                                
                            }
                        VStack {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: (screenWidth-40)/2, height: 40)
                                .overlay {
                                    VStack (alignment: .leading){
                                        Text("Reminders")
                                            .font(.system(size: 20))
                                            .fontWeight(.heavy)
                                        
                                        HStack (alignment: .top){
                                            RoundedRectangle(cornerRadius: 2)
                                                .frame(width: 3, height: 70)
                                                .foregroundStyle(textColor(userTextPreference))
                                            VStack (alignment: .leading){
                                                Text("Start 04/10 End 06/10")
                                                    .font(.system(size: 12))
                                                    .opacity(0.8)
                                                Spacer()
                                                Text("Submit Finals Paper")
                                                    .font(.system(size: 15))
                                                Spacer()
                                                Text("10 hr")
                                                    .font(.system(size: 10))
                                            }
                                            .frame(width: 150,height: 30, alignment: .topLeading)
                                        }
                                        
                                        
                                        HStack (alignment: .top){
                                            RoundedRectangle(cornerRadius: 2)
                                                .frame(width: 3, height: 70)
                                                .foregroundStyle(textColor(userTextPreference))
                                            VStack (alignment: .leading){
                                                Text("Start 04/10 End 06/15")
                                                    .font(.system(size: 12))
                                                    .opacity(0.8)
                                                Spacer()
                                                Text("Attend Important Meeting")
                                                    .font(.system(size: 15))
                                                Spacer()
                                                Text("02d 09 hr")
                                                    .font(.system(size: 10))
                                            }
                                            .frame(width: 150,height: 30, alignment: .topLeading)
                                        }
                                    }
                                    .foregroundStyle(textColor(userTextPreference))
                                    .frame(maxWidth: screenWidth, alignment: .leading)
                                }
                        }
                    }
                    .foregroundStyle(.clear)
                }
            }
        else if selectedView == 3 {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(colorName)
                .frame(width: screenWidth-15, height: 130)
                .overlay {
                    HStack (alignment: .center){
                        VStack {
                            Text("SAT")
                                .font(.system(size: 20))
                                .kerning(5)
                            Text("19")
                                .font(.system(size: 40))
                                .kerning(5)
                                .fontWeight(.heavy)
                            Text("OCT")
                                .font(.system(size: 20))
                                .kerning(5)
                        }
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 3, height: 100)
                            .opacity(0.6)
                        
                        ScrollView (.horizontal, showsIndicators: false){
                            HStack (alignment: .center, spacing: 5) {
                                
                                ForEach(timeOfDay..<24, id: \.self){ hour in
                                    VStack (spacing: 5) {
                                        Text("\(hour, specifier: "%02d"):00")
                                            .font(.system(size: 20))
                                            .kerning(5)
                                            .frame(width: 135)
                                        ScrollView (showsIndicators: false){
                                            VStack {
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(width: 120, height: 40)
                                                    .foregroundStyle(.black)
                                                    .opacity(0.5)
                                                    .overlay {
                                                        Text("\(scheduleTexts[hour])")
                                                            .foregroundStyle(textColor(userTextPreference))
                                                            .font(.system(size: 8))
                                                            .frame(width: 110, alignment: .topLeading)
                                                            .padding(10)
                                                    }
                                                
                                                RoundedRectangle(cornerRadius: 5)
                                                    .frame(width: 120, height: 40)
                                                    .foregroundStyle(.black)
                                                    .opacity(0.5)
                                                    .overlay {
                                                        Text("\(scheduleTexts[hour])")
                                                            .foregroundStyle(textColor(userTextPreference))
                                                            .font(.system(size: 8))
                                                            .frame(width: 110, alignment: .topLeading)
                                                            .padding(10)
                                                    }
                                            }
                                        }
                                        .frame(width: 135, height: 80, alignment: .bottom)
                                    }
                                    
                                    RoundedRectangle(cornerRadius: 5)
                                        .frame(width: 3, height: 100)
                                        .opacity(0.6)
                                }
                            }
                        }
                        .frame(width: 280)
                    }
                }
        }
    }
}



#Preview {
    LargeWidget(selectedView: 3, colorName: Color(red: 244/255, green: 73/255, blue: 73/255))
}
