import SwiftUI

/// Stub — will be fully implemented in Milestone 4
struct ShopView: View {
    var body: some View {
        ZStack {
            Color.alabaster.ignoresSafeArea()
            
            VStack(spacing: 24) {
                Spacer()
                
                Image(systemName: "bag.fill")
                    .font(.system(size: 48))
                    .foregroundColor(.champagneGold)
                
                Text("Shop")
                    .font(.displayMedium)
                    .foregroundColor(.obsidian)
                
                Text("Fill the gaps in your wardrobe")
                    .font(.bodyLarge)
                    .foregroundColor(.textSecondary)
                
                Spacer()
            }
        }
        .navigationTitle("Shop")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ShopView()
    }
}
