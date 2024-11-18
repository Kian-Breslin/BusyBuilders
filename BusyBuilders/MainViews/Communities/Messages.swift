
import SwiftUI

struct Messages: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    let prestigeNames = ["Start-Up", "Small Business", "Medium Enterprise", "Large Corporation", "Industry Leader", "Global Enterprise", "Mega Corporation", "Multi-National Corporation"]
    
    let prestigeSymbols = ["door.garage.double.bay.open","house", "house.lodge", "building", "building.2", "building.columns", "briefcase", "globe"]
    
    var body: some View {
        ZStack {
            ScrollView {
                ForEach(0..<prestigeNames.count, id: \.self) { rank in
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 150, height: 100)
                        .overlay {
                            VStack {
                                Image(systemName: "\(prestigeSymbols[rank])")
                                    .foregroundStyle(.red)
                                    .font(.system(size: 50))
                                
                                Text("\(prestigeNames[rank])")
                                    .foregroundStyle(.red)
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    Messages()
        .environmentObject(ThemeManager())
}
