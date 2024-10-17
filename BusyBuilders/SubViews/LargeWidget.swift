//
//  LargeWidget.swift
//  BusyBuilders
//
//  Created by Kian Breslin on 27/09/2024.
//

import SwiftUI

struct LargeWidget: View {
    
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
    @State var numberDate = 16
    
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
                        .foregroundStyle(.white)
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
                                            Text("\(numberDate) Oct 24")
                                                .font(.system(size: 30))
                                                .onTapGesture {
                                                    if numberDate <= 30 {
                                                        numberDate += 1
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
                                                            .background(.white)
                                                            .clipShape(RoundedRectangle(cornerRadius: 2))
                                                            
                                                    } else {
                                                        Text("\(day)").font(.system(size: 12))
                                                            .frame(minWidth: 0, minHeight: 0, alignment: .center) // Center text
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .foregroundStyle(.white)
                                    
                                    
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
                                                .frame(width: 5, height: 70)
                                                .foregroundStyle(.white)
                                            VStack (alignment: .leading){
                                                Text("Start 04/10 End 06/10")
                                                    .font(.system(size: 12))
                                                    .opacity(0.8)
                                                Spacer()
                                                Text("Clock In random words to see how")
                                                    .font(.system(size: 15))
                                                Spacer()
                                                Text("13 HR")
                                                    .font(.system(size: 10))
                                            }
                                            .frame(width: 150,height: 30, alignment: .topLeading)
                                        }
                                        
                                        
                                        HStack {
                                            RoundedRectangle(cornerRadius: 2)
                                                .frame(width: 5, height: 70)
                                                .foregroundStyle(.white)
                                            VStack (alignment: .leading){
                                                Text("Start 04/10 End 06/10")
                                                    .font(.system(size: 12))
                                                    .opacity(0.8)
                                                Spacer()
                                                Text("Clock In")
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 20))
                                                Spacer()
                                                Text("19 HR")
                                                    .font(.system(size: 10))
                                            }
                                        }
                                    }
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: screenWidth, alignment: .leading)
                                }
                        }
                    }
                    .foregroundStyle(.clear)
                }
            }
    }
}



#Preview {
    LargeWidget(selectedView: 2, colorName: Color(red: 244/255, green: 73/255, blue: 73/255))
}
