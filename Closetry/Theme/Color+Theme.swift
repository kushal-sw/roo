import SwiftUI

// MARK: - Design System Colors
// Editorial high-fashion base with Indian-inspired accent layer

extension Color {
    
    // MARK: - Base Palette (Editorial High-Fashion)
    
    /// Warm alabaster/ivory — primary surface background
    static let alabaster = Color(hex: "FBF9F5")
    
    /// Deep obsidian — primary text color
    static let obsidian = Color(hex: "121110")
    
    /// Gold/champagne — primary accent for CTAs, highlights, premium touches
    static let champagneGold = Color(hex: "D4AF37")
    
    /// Pure white card surface
    static let cardSurface = Color.white
    
    /// Subtle card shadow color
    static let cardShadow = Color.black.opacity(0.06)
    
    /// Secondary text — muted
    static let textSecondary = Color(hex: "6B6966")
    
    /// Tertiary text — even more muted
    static let textTertiary = Color(hex: "9C9895")
    
    /// Divider/border color
    static let divider = Color(hex: "E8E4DF")
    
    /// Input field background
    static let inputBackground = Color(hex: "F5F2ED")
    
    // MARK: - Indian-Inspired Accent Layer
    
    /// Deep peacock blue — secondary accent for interactive elements
    static let peacockBlue = Color(hex: "006D77")
    
    /// Maroon / Gulal Red — tertiary accent, badges, alerts
    static let gulalRed = Color(hex: "8B1A2B")
    
    /// Muted saffron — warm highlights, occasion tags
    static let mutedSaffron = Color(hex: "E09F3E")
    
    /// Deep teal for subtle accents
    static let deepTeal = Color(hex: "2A9D8F")
    
    // MARK: - Item Color Palette (for wardrobe tagging)
    
    /// All available item colors for the extended palette
    static let itemBlack = Color(hex: "1A1A1A")
    static let itemWhite = Color(hex: "FAFAFA")
    static let itemBeige = Color(hex: "D4C5A9")
    static let itemGrey = Color(hex: "8E8E93")
    static let itemIvory = Color(hex: "FFFFF0")
    static let itemNavy = Color(hex: "1B2A4A")
    static let itemRed = Color(hex: "C41E3A")
    static let itemBlue = Color(hex: "2563EB")
    static let itemGreen = Color(hex: "2D8B46")
    static let itemPink = Color(hex: "E8518D")
    static let itemYellow = Color(hex: "F5C518")
    static let itemBrown = Color(hex: "6B4226")
    static let itemMaroon = Color(hex: "800020")
    static let itemSaffron = Color(hex: "F4A236")
    static let itemPeacockBlue = Color(hex: "006D77")
    static let itemOlive = Color(hex: "708238")
    static let itemRust = Color(hex: "B7410E")
    static let itemTeal = Color(hex: "008080")
    static let itemGold = Color(hex: "D4AF37")
    static let itemSilver = Color(hex: "C0C0C0")
    
    // MARK: - Semantic Colors
    
    /// Success state
    static let success = Color(hex: "2D8B46")
    
    /// Warning state
    static let warning = Color(hex: "E09F3E")
    
    /// Error state
    static let error = Color(hex: "C41E3A")
    
    /// Match score high (green-gold)
    static let matchHigh = Color(hex: "4CAF50")
    
    /// Match score medium
    static let matchMedium = Color(hex: "E09F3E")
    
    /// Match score low
    static let matchLow = Color(hex: "8E8E93")
    
    // MARK: - Tab Bar
    
    /// Tab bar background
    static let tabBarBackground = Color.white
    
    /// Active tab icon
    static let tabActive = Color.champagneGold
    
    /// Inactive tab icon
    static let tabInactive = Color.textTertiary
}

// MARK: - Hex Color Initializer

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
