import SwiftUI

/// Extended color palette for wardrobe item tagging.
/// Includes neutrals, core colors, Indian-inspired additions, and metallics.
enum ItemColor: String, Codable, CaseIterable, Identifiable {
    // Neutrals
    case black = "Black"
    case white = "White"
    case beige = "Beige"
    case grey = "Grey"
    case ivory = "Ivory"
    
    // Core
    case navy = "Navy"
    case red = "Red"
    case blue = "Blue"
    case green = "Green"
    case pink = "Pink"
    case yellow = "Yellow"
    case brown = "Brown"
    
    // Indian-inspired
    case maroon = "Maroon"
    case saffron = "Saffron"
    case peacockBlue = "Peacock Blue"
    case olive = "Olive"
    case rust = "Rust"
    case teal = "Teal"
    
    // Metallic
    case gold = "Gold"
    case silver = "Silver"
    
    // Mixed
    case multicolor = "Multicolor"
    
    var id: String { rawValue }
    
    /// The actual SwiftUI Color for display (swatch/dot)
    var swatchColor: Color {
        switch self {
        case .black: return .itemBlack
        case .white: return .itemWhite
        case .beige: return .itemBeige
        case .grey: return .itemGrey
        case .ivory: return .itemIvory
        case .navy: return .itemNavy
        case .red: return .itemRed
        case .blue: return .itemBlue
        case .green: return .itemGreen
        case .pink: return .itemPink
        case .yellow: return .itemYellow
        case .brown: return .itemBrown
        case .maroon: return .itemMaroon
        case .saffron: return .itemSaffron
        case .peacockBlue: return .itemPeacockBlue
        case .olive: return .itemOlive
        case .rust: return .itemRust
        case .teal: return .itemTeal
        case .gold: return .itemGold
        case .silver: return .itemSilver
        case .multicolor: return .champagneGold // gradient placeholder
        }
    }
    
    /// Whether this color is considered a "neutral" for color-pairing rules
    var isNeutral: Bool {
        switch self {
        case .black, .white, .beige, .grey, .ivory, .navy, .brown:
            return true
        default:
            return false
        }
    }
    
    /// Color family grouping for tonal/earth-tone matching
    var colorFamily: ColorFamily {
        switch self {
        case .black, .white, .grey, .ivory:
            return .achromatic
        case .beige, .brown, .olive, .rust:
            return .earthTone
        case .navy, .blue, .peacockBlue, .teal:
            return .coolTone
        case .red, .pink, .maroon:
            return .warmAccent
        case .yellow, .saffron, .gold:
            return .warmHighlight
        case .green:
            return .natural
        case .silver:
            return .achromatic
        case .multicolor:
            return .mixed
        }
    }
}

/// Color family grouping for the recommendation engine's color pairing rules
enum ColorFamily: String, Codable {
    case achromatic     // black, white, grey, ivory, silver
    case earthTone      // beige, brown, olive, rust
    case coolTone       // navy, blue, peacock blue, teal
    case warmAccent     // red, pink, maroon
    case warmHighlight  // yellow, saffron, gold
    case natural        // green
    case mixed          // multicolor
}
