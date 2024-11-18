import SwiftUI

struct TimeSelect: View {
    @EnvironmentObject var themeManager: ThemeManager
    
    
    @Binding var moveFiveMins : Int
    
    var body: some View {
        VStack {
            ZStack {
                // Background black circle
                Circle()
                    .foregroundColor(getColor("Black"))
                    .frame(width: 200, height: 200)
                
                // Markings at 12, 3, 6, 9 positions
                ForEach([0, 90, 180, 270], id: \.self) { angle in
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 2, height: 10)
                        .offset(y: -95) // Adjust according to circle radius
                        .rotationEffect(.degrees(Double(angle)))
                }
                
                // Clock hands and shaded area
                ZStack {
                    // Hour hand
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 2, height: 100)
                        .offset(y: -50) // Adjust length and placement
                        .rotationEffect(.degrees(Double((moveFiveMins/60)*6))) // For 1 o'clock position
                    
                    // Minute hand
    //                Rectangle()
    //                    .fill(Color.white)
    //                    .frame(width: 3, height: 80)
    //                    .offset(y: -40) // Adjust length and placement
    //                    .rotationEffect(.degrees(120)) // For 20 minutes
                    
                    // Shaded area between hour and minute hand
                    SectorShape(startAngle: Angle(degrees: 0), endAngle: Angle(degrees: Double((moveFiveMins/60)*6)))
                        .fill(Color.white.opacity(0.2))
                        .frame(width: 200)
                        .rotationEffect(.degrees(-90)) // For 1 o'clock position
                }
            }
            .animation(.linear, value: moveFiveMins)
            
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 60, height: 40)
                    .overlay {
                        Image(systemName: "minus")
                            .foregroundStyle(.white)
                    }
                    .onTapGesture {
                        if moveFiveMins > 0 {
                            moveFiveMins -= 300
                        }
                    }
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 150, height: 40)
                    .overlay {
                        Text("\(timeFormattedMins(moveFiveMins))")
                            .foregroundStyle(.white)
                            .font(.system(size: 30))
                            .kerning(2)
                    }
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 60, height: 40)
                    .overlay {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                    }
                    .onTapGesture {
                        if moveFiveMins < 3600 {
                            moveFiveMins += 300
                        } else {
                            moveFiveMins += 0
                        }
                    }
            }
            .foregroundStyle(getColor("Black"))
        }
        .frame(width: screenWidth - 30, height: 280)
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
