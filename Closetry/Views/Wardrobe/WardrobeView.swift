import SwiftUI
import SwiftData

struct WardrobeView: View {
    @Query(sort: \WardrobeItem.dateAdded, order: .reverse) private var items: [WardrobeItem]
    @State private var selectedCategory: ItemCategory? = nil
    @State private var selectedColor: ItemColor? = nil
    @State private var selectedOccasion: Occasion? = nil
    @State private var showFilters = false
    @State private var searchText = ""
    
    private var filteredItems: [WardrobeItem] {
        var result = items
        
        if let category = selectedCategory {
            result = result.filter { $0.category == category }
        }
        if let color = selectedColor {
            result = result.filter { $0.color == color }
        }
        if let occasion = selectedOccasion {
            result = result.filter { $0.occasions.contains(occasion) }
        }
        if !searchText.isEmpty {
            result = result.filter { item in
                item.subcategory.localizedCaseInsensitiveContains(searchText) ||
                item.category.rawValue.localizedCaseInsensitiveContains(searchText) ||
                item.color.rawValue.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return result
    }
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        ZStack {
            Color.alabaster.ignoresSafeArea()
            
            if items.isEmpty {
                emptyStateView
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        // Header stats
                        headerStats
                        
                        // Filter chips
                        filterSection
                        
                        // Active filters indicator
                        if hasActiveFilters {
                            activeFiltersBar
                        }
                        
                        // Items grid
                        if filteredItems.isEmpty {
                            noResultsView
                        } else {
                            LazyVGrid(columns: columns, spacing: 14) {
                                ForEach(filteredItems, id: \.id) { item in
                                    NavigationLink(destination: ItemDetailView(item: item)) {
                                        WardrobeItemCard(item: item)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationTitle("My Closet")
        .navigationBarTitleDisplayMode(.large)
        .searchable(text: $searchText, prompt: "Search your wardrobe")
    }
    
    // MARK: - Header Stats
    
    private var headerStats: some View {
        HStack(spacing: 0) {
            statBadge(count: items.count, label: "Items")
            Spacer()
            statBadge(count: Set(items.map(\.categoryRaw)).count, label: "Categories")
            Spacer()
            statBadge(count: Set(items.map(\.colorRaw)).count, label: "Colors")
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
    }
    
    private func statBadge(count: Int, label: String) -> some View {
        VStack(spacing: 4) {
            Text("\(count)")
                .font(.titleMedium)
                .foregroundColor(.obsidian)
            Text(label)
                .font(.captionText)
                .foregroundColor(.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.cardSurface)
        .cornerRadius(12)
        .shadow(color: .cardShadow, radius: 4, y: 2)
        .padding(.horizontal, 4)
    }
    
    // MARK: - Filter Section
    
    private var filterSection: some View {
        VStack(spacing: 10) {
            // Category filter
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    filterChip(label: "All", isSelected: selectedCategory == nil) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selectedCategory = nil
                        }
                    }
                    ForEach(ItemCategory.allCases) { category in
                        filterChip(
                            label: category.rawValue,
                            icon: category.icon,
                            isSelected: selectedCategory == category
                        ) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedCategory = selectedCategory == category ? nil : category
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            
            // Occasion filter
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(Occasion.allCases) { occasion in
                        filterChip(
                            label: occasion.rawValue,
                            icon: occasion.icon,
                            isSelected: selectedOccasion == occasion
                        ) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedOccasion = selectedOccasion == occasion ? nil : occasion
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            
            // Color filter
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    ForEach(usedColors, id: \.self) { color in
                        colorDot(color: color, isSelected: selectedColor == color) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                selectedColor = selectedColor == color ? nil : color
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    /// Only show color dots for colors actually present in the wardrobe
    private var usedColors: [ItemColor] {
        let colorRaws = Set(items.map(\.colorRaw))
        return ItemColor.allCases.filter { colorRaws.contains($0.rawValue) }
    }
    
    // MARK: - Active Filters Bar
    
    private var hasActiveFilters: Bool {
        selectedCategory != nil || selectedColor != nil || selectedOccasion != nil
    }
    
    private var activeFiltersBar: some View {
        HStack {
            Text("\(filteredItems.count) of \(items.count) items")
                .font(.labelSmall)
                .foregroundColor(.textSecondary)
            
            Spacer()
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    selectedCategory = nil
                    selectedColor = nil
                    selectedOccasion = nil
                }
            } label: {
                Text("Clear Filters")
                    .font(.labelSmall)
                    .foregroundColor(.champagneGold)
            }
        }
        .padding(.horizontal, 20)
    }
    
    // MARK: - Empty State
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Spacer()
            
            // Warli-style illustration placeholder
            ZStack {
                Circle()
                    .fill(Color.inputBackground)
                    .frame(width: 120, height: 120)
                
                Image(systemName: "hanger")
                    .font(.system(size: 48, weight: .thin))
                    .foregroundColor(.textTertiary)
            }
            
            Text("Your closet is empty")
                .font(.titleMedium)
                .foregroundColor(.obsidian)
            
            Text("Add your first item to start\nbuilding your digital wardrobe")
                .font(.bodyMedium)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
            
            Spacer()
        }
    }
    
    private var noResultsView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 36, weight: .thin))
                .foregroundColor(.textTertiary)
                .padding(.top, 60)
            
            Text("No items match your filters")
                .font(.bodyMedium)
                .foregroundColor(.textSecondary)
        }
    }
    
    // MARK: - Reusable Components
    
    private func filterChip(label: String, icon: String? = nil, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 4) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 11))
                }
                Text(label)
                    .font(.labelSmall)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(isSelected ? Color.champagneGold : Color.cardSurface)
            .foregroundColor(isSelected ? .white : .obsidian)
            .cornerRadius(20)
            .shadow(color: .cardShadow, radius: 2, y: 1)
        }
    }
    
    private func colorDot(color: ItemColor, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Circle()
                .fill(color.swatchColor)
                .frame(width: 28, height: 28)
                .overlay(
                    Circle()
                        .stroke(isSelected ? Color.champagneGold : Color.divider, lineWidth: isSelected ? 2.5 : 1)
                )
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: color == .white ? 1 : 0)
                )
                .scaleEffect(isSelected ? 1.15 : 1.0)
        }
    }
}

#Preview {
    NavigationStack {
        WardrobeView()
    }
    .modelContainer(for: WardrobeItem.self, inMemory: true)
}
