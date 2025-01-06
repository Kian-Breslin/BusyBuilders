import SwiftUI

struct TimeSelect: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    
    @Binding var moveFiveMins : Int
    
    var body: some View {
        VStack {
            ZStack {
                // Background black circle
                Circle()
                    .foregroundColor(themeManager.mainColor)
                    .frame(width: 150, height: 150)
                
                // Markings at 12, 3, 6, 9 positions
                ForEach([0, 90, 180, 270], id: \.self) { angle in
                    Rectangle()
                        .fill(themeManager.textColor)
                        .frame(width: 1, height: 8)
                        .offset(y: -70) // Adjust according to circle radius
                        .rotationEffect(.degrees(Double(angle)))
                }
                
                // Clock hands and shaded area
                ZStack {
                    // Hour hand
                    Rectangle()
                        .fill(themeManager.textColor)
                        .frame(width: 2, height: 75)
                        .offset(y: -35) // Adjust length and placement
                        .rotationEffect(.degrees(Double((moveFiveMins/60)*6))) // For 1 o'clock position
                    
                    // Shaded area between hour and minute hand
                    SectorShape(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: Double((moveFiveMins/60)*6)))
                        .fill(themeManager.textColor.opacity(0.2))
                        .frame(width: 150)
                        .rotationEffect(.degrees(-90)) // For 1 o'clock position
                }
            }
            .animation(.linear, value: moveFiveMins)
        }
        .frame(width: 150, height: 150)
    }
}

// Custom shape to create the shaded area between clock hands
struct SectorShape: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(startAngle.degrees, endAngle.degrees) }
        set {
            startAngle = Angle(degrees: newValue.first)
            endAngle = Angle(degrees: newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = rect.width / 2
        
        var path = Path()
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        
        return path
    }
}

#Preview {
    TimeSelect(moveFiveMins: .constant(1620))
        .environmentObject(ThemeManager())
}
