import SwiftUI

struct SplashScreenView: View {
    @State private var isAnimating = false
    @State private var textOpacity = 0.0
    @State private var taglineOpacity = 0.0
    @State private var mandalaScale = 0.6
    @State private var mandalaRotation = 0.0
    @State private var ringPulse = 0.8
    @State private var glowOpacity = 0.0
    
    var body: some View {
        ZStack {
            // Background - Warm Alabaster
            Color.alabaster
                .ignoresSafeArea()
            
            // Subtle ambient background glow
            RadialGradient(
                colors: [
                    Color.champagneGold.opacity(0.12),
                    Color.peacockBlue.opacity(0.05),
                    Color.clear
                ],
                center: .center,
                startRadius: 20,
                endRadius: 280
            )
            .ignoresSafeArea()
            
            VStack(spacing: 36) {
                Spacer()
                
                // MARK: - Geometric Jaali Mandala Animation
                ZStack {
                    // Outer Pulsing Aura Ring
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [Color.champagneGold.opacity(0.4), Color.peacockBlue.opacity(0.2)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1.5
                        )
                        .frame(width: 170, height: 170)
                        .scaleEffect(ringPulse)
                        .opacity(glowOpacity)
                    
                    // Outer 8-petaled Jaali Ring
                    ForEach(0..<8) { i in
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        Color.champagneGold.opacity(0.85),
                                        Color.peacockBlue.opacity(0.65)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                ),
                                lineWidth: 1.2
                            )
                            .frame(width: 105, height: 105)
                            .rotationEffect(.degrees(Double(i) * 22.5 + mandalaRotation))
                    }
                    
                    // Inner Concentric Lattice Diamonds
                    ForEach(0..<4) { i in
                        Rectangle()
                            .stroke(Color.champagneGold, lineWidth: 1.5)
                            .frame(width: 58, height: 58)
                            .rotationEffect(.degrees(Double(i) * 45 - (mandalaRotation * 1.5)))
                    }
                    
                    // Center Peacock Blue & Gold Core
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.champagneGold, Color.peacockBlue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 26, height: 26)
                        .shadow(color: Color.champagneGold.opacity(0.6), radius: 10, x: 0, y: 0)
                    
                    // Central Sparkle Diamond
                    Rectangle()
                        .fill(Color.alabaster)
                        .frame(width: 8, height: 8)
                        .rotationEffect(.degrees(45 + mandalaRotation * 2))
                }
                .scaleEffect(mandalaScale)
                
                // MARK: - Brand Typography
                VStack(spacing: 10) {
                    Text("C L O S E T R Y")
                        .font(.system(size: 30, weight: .semibold, design: .serif))
                        .tracking(6)
                        .foregroundColor(.obsidian)
                        .opacity(textOpacity)
                        .overlay(
                            // Subtle gold shimmer sweep over text
                            LinearGradient(
                                colors: [.clear, .champagneGold.opacity(0.6), .clear],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .mask(
                                Text("C L O S E T R Y")
                                    .font(.system(size: 30, weight: .semibold, design: .serif))
                                    .tracking(6)
                            )
                            .opacity(glowOpacity)
                        )
                    
                    // Elegant divider line with gold dot
                    HStack(spacing: 8) {
                        Rectangle()
                            .fill(LinearGradient(colors: [.clear, .champagneGold.opacity(0.5)], startPoint: .leading, endPoint: .trailing))
                            .frame(width: 40, height: 1)
                        
                        Circle()
                            .fill(Color.champagneGold)
                            .frame(width: 4, height: 4)
                        
                        Rectangle()
                            .fill(LinearGradient(colors: [.champagneGold.opacity(0.5), .clear], startPoint: .leading, endPoint: .trailing))
                            .frame(width: 40, height: 1)
                    }
                    .opacity(taglineOpacity)
                    
                    Text("YOUR WARDROBE, ELEVATED")
                        .font(.system(size: 11, weight: .medium, design: .default))
                        .tracking(3.5)
                        .foregroundColor(.textSecondary)
                        .opacity(taglineOpacity)
                }
                
                Spacer()
                
                // Subtle bottom copyright/version
                Text("DIGITAL ATELIER")
                    .font(.system(size: 9, weight: .semibold, design: .default))
                    .tracking(2.5)
                    .foregroundColor(.textTertiary.opacity(0.8))
                    .padding(.bottom, 24)
                    .opacity(taglineOpacity)
            }
        }
        .onAppear {
            startAnimationSequence()
        }
    }
    
    private func startAnimationSequence() {
        // Step 1: Mandala expands & glows
        withAnimation(.easeOut(duration: 1.2)) {
            mandalaScale = 1.0
            glowOpacity = 1.0
        }
        
        // Step 2: Smooth continuous rotation & pulse over the 3 seconds
        withAnimation(.easeInOut(duration: 2.8)) {
            mandalaRotation = 135
            ringPulse = 1.15
        }
        
        // Step 3: Text reveal
        withAnimation(.easeIn(duration: 0.9).delay(0.4)) {
            textOpacity = 1.0
        }
        
        // Step 4: Tagline & divider reveal
        withAnimation(.easeIn(duration: 0.8).delay(0.9)) {
            taglineOpacity = 1.0
        }
    }
}

#Preview {
    SplashScreenView()
}
