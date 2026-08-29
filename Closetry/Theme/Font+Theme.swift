import SwiftUI

// MARK: - Typography System
// SF Pro (system font) at predefined sizes for consistent hierarchy

extension Font {
    
    // MARK: - Display
    
    /// Extra large display text — splash screen, hero sections
    static let displayLarge = Font.system(size: 34, weight: .bold, design: .default)
    
    /// Display — section headers on main screens
    static let displayMedium = Font.system(size: 28, weight: .bold, design: .default)
    
    // MARK: - Titles
    
    /// Large title — screen titles
    static let titleLarge = Font.system(size: 24, weight: .semibold, design: .default)
    
    /// Medium title — card titles, section headers
    static let titleMedium = Font.system(size: 20, weight: .semibold, design: .default)
    
    /// Small title — subsection headers
    static let titleSmall = Font.system(size: 17, weight: .semibold, design: .default)
    
    // MARK: - Body
    
    /// Large body — primary content text
    static let bodyLarge = Font.system(size: 17, weight: .regular, design: .default)
    
    /// Medium body — standard content
    static let bodyMedium = Font.system(size: 15, weight: .regular, design: .default)
    
    /// Small body — secondary content
    static let bodySmall = Font.system(size: 13, weight: .regular, design: .default)
    
    // MARK: - Labels
    
    /// Large label — buttons, chips
    static let labelLarge = Font.system(size: 15, weight: .medium, design: .default)
    
    /// Medium label — tags, badges
    static let labelMedium = Font.system(size: 13, weight: .medium, design: .default)
    
    /// Small label — metadata, timestamps
    static let labelSmall = Font.system(size: 11, weight: .medium, design: .default)
    
    // MARK: - Caption
    
    /// Caption — fine print, hints
    static let captionText = Font.system(size: 11, weight: .regular, design: .default)
    
    // MARK: - Special
    
    /// Match score badge
    static let scoreBadge = Font.system(size: 14, weight: .bold, design: .rounded)
    
    /// Price text
    static let priceText = Font.system(size: 16, weight: .semibold, design: .rounded)
    
    /// Prompt input placeholder
    static let promptInput = Font.system(size: 18, weight: .regular, design: .default)
    
    /// Serif-style for splash/logo (using system serif design)
    static let logoSerif = Font.system(size: 42, weight: .bold, design: .serif)
    
    /// Tagline text
    static let tagline = Font.system(size: 16, weight: .light, design: .serif)
}

// MARK: - View Modifiers for Common Text Styles

extension View {
    /// Apply primary heading style
    func headingStyle() -> some View {
        self
            .font(.titleLarge)
            .foregroundColor(.obsidian)
    }
    
    /// Apply body text style
    func bodyStyle() -> some View {
        self
            .font(.bodyMedium)
            .foregroundColor(.obsidian)
    }
    
    /// Apply caption/secondary text style
    func captionStyle() -> some View {
        self
            .font(.captionText)
            .foregroundColor(.textSecondary)
    }
    
    /// Apply gold accent text style
    func accentStyle() -> some View {
        self
            .font(.labelMedium)
            .foregroundColor(.champagneGold)
    }
}
