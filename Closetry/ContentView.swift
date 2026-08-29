
import SwiftUI

struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var isShowingSplash = true
    
    var body: some View {
        ZStack {
            if isShowingSplash {
                SplashScreenView()
                    .transition(.opacity)
            } else {
                Group {
                    if hasCompletedOnboarding {
                        MainTabView()
                    } else {
                        OnboardingContainerView()
                    }
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.6), value: isShowingSplash)
        .animation(.easeInOut(duration: 0.3), value: hasCompletedOnboarding)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                withAnimation(.easeInOut(duration: 0.6)) {
                    isShowingSplash = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
