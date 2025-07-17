import SwiftUI
import SwiftData

struct Social: View {
    @EnvironmentObject var userManager: UserManager
    @State var selectedIcon = "envelope"
    
    var body: some View {
        VStack {
            TopNavigation(
                title: "Social",
                iconNames: ["envelope", "square", "square", "square"],
                iconLabels: ["Messages", "", "", ""],
                selectedIcon: $selectedIcon
            )
            Spacer()
        }
        .background(userManager.mainColor)
        
        VStack {
            if selectedIcon == "envelope" {
                SocialMessages()
            } else if selectedIcon == "square" {
                
            } else if selectedIcon == "Messages" {
                
            } else if selectedIcon == "Messages" {
                
            }
        }
        .background(userManager.mainColor)
    }
}

#Preview {
    Social()
        .environmentObject(UserManager())
}
