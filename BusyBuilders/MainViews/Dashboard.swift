import SwiftUI
import SwiftData

struct Dashboard: View {
    
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    
    @AppStorage("userColorPreference") var userColorPreference: String = "red"
    @State var isSettingsShowing = false
    @State var placeholderSheet = false
    @State var selectedTopButtons = ""
    
    var totalBalance: Double {
        // Sum the cash from all businesses
        Double(users.first?.businesses.reduce(0) { $0 + $1.netWorth } ?? 0)
    }
    
    var body: some View {
        
        ZStack {
            colorForName(userColorPreference)
                .ignoresSafeArea()
            
            VStack {
                // Header
                VStack {
                    // Top Header
                    HStack {
                        VStack (alignment: .leading){
                            Text("$\(totalBalance, specifier: "%.f")")
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .shadow(radius: 5)
                                .onTapGesture {
                                    isSettingsShowing.toggle()
                                }
                            Text("Total Balance")
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
                                .onTapGesture {
                                    isSettingsShowing.toggle()
                                    
                                }
                        }
                        .font(.system(size: 25))
                    }
                    .padding(15)
                    
                    HStack {
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 60, height: 60)
                                .overlay {
                                    Image(systemName: "dollarsign")
                                        .font(.system(size: 30))
                                        .foregroundStyle(colorForName(userColorPreference))
                                }
                                .onTapGesture {
                                    selectedTopButtons = "Send Money"
                                    placeholderSheet.toggle()
                                }
                            Text("Send Money")
                        }
                        Spacer()
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 60, height: 60)
                                .overlay {
                                    Image(systemName: "dollarsign.arrow.circlepath")
                                        .font(.system(size: 30))
                                        .foregroundStyle(colorForName(userColorPreference))
                                }
                                .onTapGesture {
                                    selectedTopButtons = "Request Money"
                                    placeholderSheet.toggle()
                                }
                            Text("Request Money")
                        }
                        Spacer()
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 60, height: 60)
                                .overlay {
                                    Image(systemName: "creditcard")
                                        .font(.system(size: 30))
                                        .foregroundStyle(colorForName(userColorPreference))
                                }
                                .onTapGesture {
                                    selectedTopButtons = "Loan"
                                    placeholderSheet.toggle()
                                }
                            Text("Loans")
                        }
                        Spacer()
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 60, height: 60)
                                .overlay {
                                    Image(systemName: "building")
                                        .font(.system(size: 30))
                                        .foregroundStyle(colorForName(userColorPreference))
                                }
                                .onTapGesture {
                                    selectedTopButtons = "Bank"
                                    placeholderSheet.toggle()
                                }
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
                            LargeWidget(selectedView: 0, colorName: colorForName(userColorPreference))
                            HStack {
                                MediumWidget(colorName: colorForName(userColorPreference))
                                Spacer()
                                VStack {
                                    HStack {
                                        SmallWidget(colorName: colorForName(userColorPreference))
                                        SmallWidget(colorName: colorForName(userColorPreference))
                                        SmallWidget(colorName: colorForName(userColorPreference))
                                    }
                                    HStack {
                                        SmallWidget(colorName: colorForName(userColorPreference))
                                        SmallWidget(colorName: colorForName(userColorPreference))
                                        SmallWidget(colorName: colorForName(userColorPreference))
                                    }
                                }
                            }
                            .frame(width: screenWidth-30)
                            
                            LargeWidget(selectedView: 1, colorName: colorForName(userColorPreference))
                            
                            Spacer()
                        }
                    }
            }
        }
        .foregroundStyle(.white)
        .sheet(isPresented: $isSettingsShowing) {
            Settings(userColorPreference: $userColorPreference)
                    .presentationDetents([.fraction(0.5)])
        }
        .sheet(isPresented: $placeholderSheet) {
            DashboardTopButtons(title: selectedTopButtons, userColor: .black)
            .presentationDetents([.fraction(0.76)])
        }
    }
}

#Preview {
    Dashboard()
        .modelContainer(for: [UserDataModel.self])
}
