import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: AppTab = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 1: Home / Today
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label(AppTab.home.title, systemImage: AppTab.home.icon)
            }
            .tag(AppTab.home)
            
            // Tab 2: Wardrobe (Closet)
            NavigationStack {
                WardrobeView()
            }
            .tabItem {
                Label(AppTab.wardrobe.title, systemImage: AppTab.wardrobe.icon)
            }
            .tag(AppTab.wardrobe)
            
            // Tab 3: Add Item (center, prominent)
            NavigationStack {
                AddItemView()
            }
            .tabItem {
                Label(AppTab.addItem.title, systemImage: AppTab.addItem.icon)
            }
            .tag(AppTab.addItem)
            
            // Tab 4: Shop / Fill the Gap
            NavigationStack {
                ShopView()
            }
            .tabItem {
                Label(AppTab.shop.title, systemImage: AppTab.shop.icon)
            }
            .tag(AppTab.shop)
            
            // Tab 5: Profile
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label(AppTab.profile.title, systemImage: AppTab.profile.icon)
            }
            .tag(AppTab.profile)
        }
        .tint(.champagneGold)
        .onAppear {
            configureTabBarAppearance()
        }
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.tabBarBackground)
        
        // Active state
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.tabActive)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(Color.tabActive)
        ]
        
        // Inactive state
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.tabInactive)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(Color.tabInactive)
        ]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

// MARK: - App Tab Enum

enum AppTab: Hashable {
    case home
    case wardrobe
    case addItem
    case shop
    case profile
    
    var title: String {
        switch self {
        case .home: return "Today"
        case .wardrobe: return "Closet"
        case .addItem: return "Add"
        case .shop: return "Shop"
        case .profile: return "Profile"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "sun.max.fill"
        case .wardrobe: return "square.grid.2x2.fill"
        case .addItem: return "plus.circle.fill"
        case .shop: return "bag.fill"
        case .profile: return "person.fill"
        }
    }
}

#Preview {
    MainTabView()
}
