import SwiftUI
import SwiftData

struct Dashboard: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    @Environment(\.modelContext) var context
    @Query var users: [UserDataModel]
    @Query var businesses: [BusinessDataModel] // Query for businesses
    @Binding var dashboardSelection : Int

    
    @State var colorWhite = Color(red: 0.95, green: 0.95, blue: 0.95)
    
    @Binding var isSettingsShowing : Bool
    @State var isNotificationsShowing = false
    @State var showFlashCards = false
    @State var showCalendar = false
    @State var placeholderSheet = false
    @State var selectedTopButtons = ""
    @State var changeTopLeftValue = true
    
    @State var Title = "Dashboard"
    @State var buttonImages = ["house", "archivebox", "banknote", "newspaper"]
    @State var buttonText = ["Home", "Inventory", "Bank", "News"]
    @State var selectedScreen = "house"
    
    // Calculate Users NetWorth
    @State private var userTotalNetWorth: Double = 0.0 
    
    var body: some View {
        NavigationStack {
            ZStack {
                themeManager.mainColor
                    .ignoresSafeArea()
                
                VStack {
                    // Header
                    VStack {
                        // Top Header
                        HStack {
                            Text(Title)
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                            Spacer()
                            HStack (spacing: 15){
                                ZStack {
                                    Image(systemName: "bell.fill")
                                    Image(systemName: "2.circle.fill")
                                        .font(.system(size: 15))
                                        .offset(x: 10, y: -10)
                                        .onTapGesture {
                                            
                                        }
                                }
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(themeManager.isDarkMode ? Color.gray.opacity(0.5) : getColor("light"))
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
                        .frame(width: screenWidth-20, height: 60)
                        
                        HStack {
                            ForEach(0..<4){ i in
                                VStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 60, height: 60)
                                        .foregroundStyle(themeManager.isDarkMode ? Color.gray.opacity(0.5) : getColor("light"))
                                        .overlay {
                                            Image(systemName: buttonImages[i] == selectedScreen ? "\(buttonImages[i]).fill" : "\(buttonImages[i])")
                                                .font(.system(size: 30))
                                                .foregroundStyle(themeManager.textColor)
                                                
                                        }
                                        .onTapGesture {
                                            selectedScreen = buttonImages[i]
                                        }
                                    Text(buttonText[i])
                                        .font(.system(size: 10))
                                        .scaledToFit()
                                }
                                .frame(width: 60, height: 80)
                                
                                if i < 3 {
                                    Spacer()
                                }
                            }
                        }
                        .font(.system(size: 12))
                        .foregroundStyle(themeManager.textColor)
                        .frame(width: screenWidth-20, height: 100)
                    }
                    .frame(width: screenWidth-20, height: 160)

                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: screenWidth)
                        .foregroundStyle(themeManager.isDarkMode ? getColor(themeManager.mainDark) : getColor("light"))
                        .overlay {
                            if selectedScreen == buttonImages[0] {
                                ScrollView (showsIndicators: false){
                                    DashboardHomeView()
                                }
                                .padding(.bottom, 45)
                                .padding(.top, 10)
                            }
                            else if selectedScreen == buttonImages[1] {
                                ScrollView (showsIndicators: false){
                                    DashboardInventoryView()
                                }
                                .padding(.bottom, 45)
                                .padding(.top, 10)
                            }
                            else if selectedScreen == buttonImages[2] {
                                TransactionDisplay()
                                    .padding(.bottom, 45)
                                    .padding(.top, 10)
                            }
                        }
                        
                }
            }
            .foregroundStyle(themeManager.textColor)
        }
        .sheet(isPresented: $isNotificationsShowing) {
            Notifications()
                .presentationDetents([.fraction(0.883)])
        }
    }
}

#Preview {
    Dashboard(dashboardSelection: .constant(0), isSettingsShowing: .constant(false))
        .modelContainer(for: [UserDataModel.self])
        .environmentObject(UserManager())
        .environmentObject(ThemeManager())
}
