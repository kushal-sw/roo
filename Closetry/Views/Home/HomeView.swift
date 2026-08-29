import SwiftUI

/// Stub — will be fully implemented in Milestone 5
struct HomeView: View {
    var body: some View {
        ZStack {
            Color.alabaster.ignoresSafeArea()
            
            VStack(spacing: 24) {
                Spacer()
                
                Image(systemName: "sun.max.fill")
                    .font(.system(size: 48))
                    .foregroundColor(.champagneGold)
                
                Text("Today")
                    .font(.displayMedium)
                    .foregroundColor(.obsidian)
                
                Text("What's the occasion?")
                    .font(.bodyLarge)
                    .foregroundColor(.textSecondary)
                
                Spacer()
            }
        }
        .navigationTitle("Today")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
