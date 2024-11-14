import SwiftUI
import SwiftData

struct Dashboard: View {
    
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel] // Query for businesses
    @Binding var dashboardSelection : Int
    
    @AppStorage("userColorPreference") var userColorPreference: String = "black"
    @AppStorage("userTextPreference") var userTextPreference: String = "white"
    
    @State var colorWhite = Color(red: 0.95, green: 0.95, blue: 0.95)
    
    @State var isSettingsShowing = false
    @State var isNotificationsShowing = false
    @State var showFlashCards = false
    @State var showCalendar = false
    @State var placeholderSheet = false
    @State var selectedTopButtons = ""
    @State var changeTopLeftValue = true
    
    // Calculate Users NetWorth
    @State private var userTotalNetWorth: Double = 0.0 // This is a variable to store the users total net worth
    
    var body: some View {
        
        ZStack {
            
            getColor(userColorPreference)
                .ignoresSafeArea()
            
            VStack {
                // Header
                VStack {
                    // Top Header
                    HStack {
                        VStack (alignment: .leading){
                            Text("Dashboard")
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                        }
                        .onTapGesture {
                            
                        }
                        Spacer()
                        HStack (spacing: 15){
                            ZStack {
                                Image(systemName: "bell.fill")
                                Image(systemName: "2.circle.fill")
                                    .font(.system(size: 15))
                                    .offset(x: 10, y: -10)
                                    .onTapGesture {
                                        isNotificationsShowing.toggle()
                                    }
                            }
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 40, height: 40)
                                .overlay(content: {
                                    Image("userImage-2")
                                        .resizable()
                                        .frame(width: 40,height: 40)
                                })
                                .onTapGesture {
                                    isSettingsShowing.toggle()
                                    
                                }
                        }
                        .font(.system(size: 25))
                    }
                    .frame(width: screenWidth-30, height: 80)
                    
                    HStack {
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 60, height: 60)
                                .overlay {
                                    Image(systemName: "dollarsign")
                                        .font(.system(size: 30))
                                        .foregroundStyle(getColor(userColorPreference))
                                }
                                .onTapGesture {
                                    selectedTopButtons = "Send"
                                    placeholderSheet.toggle()
                                }
                            Text("Send")
                        }
                        .frame(width: 60, height: 80)
                        Spacer()
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 60, height: 60)
                                .overlay {
                                    Image(systemName: "dollarsign.arrow.circlepath")
                                        .font(.system(size: 30))
                                        .foregroundStyle(getColor(userColorPreference))
                                }
                                .onTapGesture {
                                    selectedTopButtons = "Withdraw"
                                    placeholderSheet.toggle()
                                }
                            Text("Withdraw")
                        }
                        .frame(width: 60, height: 80)
                        Spacer()
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 60, height: 60)
                                .overlay {
                                    Image(systemName: "creditcard")
                                        .font(.system(size: 30))
                                        .foregroundStyle(getColor(userColorPreference))
                                }
                                .onTapGesture {
                                    selectedTopButtons = "Loan"
                                    placeholderSheet.toggle()
                                }
                            Text("Loans")
                        }
                        .frame(width: 60, height: 80)
                        Spacer()
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 60, height: 60)
                                .overlay {
                                    Image(systemName: "archivebox")
                                        .font(.system(size: 30))
                                        .foregroundStyle(getColor(userColorPreference))
                                }
                                .onTapGesture {
                                    selectedTopButtons = "Inventory"
                                    placeholderSheet.toggle()
                                }
                            Text("Inventory")
                        }
                        .frame(width: 60, height: 80)
                    }
                    .font(.system(size: 12))
                    .frame(width: screenWidth-30, height: 80)
                }
                .frame(width: screenWidth-30, height: 180)
                
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: screenWidth, height: screenHeight/1.5)
                    .overlay {
                        ScrollView (showsIndicators: false){
                            VStack (spacing: 10){
                                LargeWidget(selectedView: 2, colorName: getColor(userColorPreference))
                                    .padding(.top, 10)
                                HStack {
                                    MediumWidget(colorName: getColor(userColorPreference))
                                        .onTapGesture {
                                            showFlashCards.toggle()
                                        }
                                    Spacer()
                                    
                                    MediumWidget(colorName: getColor(userColorPreference))
                                        .onTapGesture {
                                            showFlashCards.toggle()
                                        }
                                }
                                .frame(width: screenWidth-15)
                                
                                LargeWidget(selectedView: 1, colorName: getColor(userColorPreference))
                                    .onTapGesture {
                                        showCalendar.toggle()
                                    }
                                
                                HStack {
                                    MediumWidget(colorName: getColor(userColorPreference))
                                    Spacer()
                                    MediumWidget(colorName: getColor(userColorPreference))
                                }
                                .frame(width: screenWidth-15)
                                
                                LargeWidget(selectedView: 2, colorName: getColor(userColorPreference))
                                    .frame(width: screenWidth-15)
                                
                                HStack {
                                    MediumWidget(colorName: getColor(userColorPreference))
                                    Spacer()
                                    MediumWidget(colorName: getColor(userColorPreference))
                                }
                                .frame(width: screenWidth-15)
                                
                                Spacer()
                            }
                        }
                        .padding(.bottom, 35)
                        .padding(.top, 5)
                    }
            }
        }
        .foregroundStyle(colorWhite)
        .fullScreenCover(isPresented: $isSettingsShowing){
            Settings(userColorPreference: $userColorPreference)
        }
        .sheet(isPresented: $placeholderSheet) {
            DashboardTopButtons(title: $selectedTopButtons, totalNetWorth: $userTotalNetWorth, userColor: getColor(userColorPreference))
                .presentationDetents([.fraction(0.763)])
        }
        .sheet(isPresented: $isNotificationsShowing) {
            Notifications()
                .presentationDetents([.fraction(0.883)])
        }
        .fullScreenCover(isPresented: $showFlashCards){
            FlashCards()
        }
        .fullScreenCover(isPresented: $showCalendar){
            Calendar()
        }
        .onAppear{
            userTotalNetWorth = calculateTotalBalance() + Double(users.first?.availableBalance ?? 0)
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
    Dashboard(dashboardSelection: .constant(0))
        .modelContainer(for: [UserDataModel.self])
}
