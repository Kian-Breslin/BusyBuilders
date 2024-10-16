import SwiftUI
import SwiftData

struct Dashboard: View {
    
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel] // Query for businesses
    
    @AppStorage("userColorPreference") var userColorPreference: String = "red"
    @State var isSettingsShowing = false
    @State var showFlashCards = false
    @State var showCalendar = false
    @State var placeholderSheet = false
    @State var selectedTopButtons = ""
    @State private var totalBalance: Double = 0.0 // State variable for total balance
    
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
                                .onTapGesture {
                                    isSettingsShowing.toggle()
                                }
                            Text("Total Net Worth")
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
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: screenWidth, height: screenHeight/1.5)
                    .overlay {
                        VStack (spacing: 15){
                            LargeWidget(selectedView: 0, colorName: colorForName(userColorPreference))
                                .padding(.top, 15)
                            HStack {
                                MediumWidget(colorName: colorForName(userColorPreference))
                                    .onTapGesture {
                                        showFlashCards.toggle()
                                    }
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
                            .frame(width: screenWidth-15)
                            
                            LargeWidget(selectedView: 1, colorName: colorForName(userColorPreference))
                                .onTapGesture {
                                    showCalendar.toggle()
                                }
                            
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
        .fullScreenCover(isPresented: $showFlashCards){
            FlashCards()
        }
        .fullScreenCover(isPresented: $showCalendar){
            Calendar()
        }
        .onAppear {
            totalBalance = calculateTotalBalance()
        }
    }
    
    private func calculateTotalBalance() -> Double {
        // Sum the net worth from all businesses
        var totalBalance: Double {
            // Sum the net worth from all businesses using reduce
            businesses.reduce(0) { $0 + $1.netWorth }
        }
        
        return totalBalance
    }
}

#Preview {
    Dashboard()
        .modelContainer(for: [UserDataModel.self])
}
