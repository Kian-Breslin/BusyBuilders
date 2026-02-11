import SwiftUI
import SwiftData

struct Social: View {
    @EnvironmentObject var userManager: UserManager
    @State var selectedIcon = "envelope"
    
    var body: some View {
        VStack {
            TopNavigation(
                title: "Social",
                iconNames: ["envelope", "hammer", "hammer", "calendar.circle"],
                iconLabels: ["Messages", "Placeholder", "Placeholder", "Planned Sessions"],
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
                
            } else if selectedIcon == "calendar.circle" {
                SocialPlannedSessions()
            }
        }
        .background(userManager.mainColor)
    }
}

#Preview {
    Social()
        .environmentObject(UserManager())
}
