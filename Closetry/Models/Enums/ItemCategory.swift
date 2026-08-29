import Foundation

/// The 6 top-level wardrobe item categories.
/// These map directly to outfit-slot logic in the Stylist engine.
enum ItemCategory: String, Codable, CaseIterable, Identifiable {
    case tops = "Tops"
    case bottoms = "Bottoms"
    case dresses = "Dresses"
    case footwear = "Footwear"
    case outerwear = "Outerwear"
    case accessories = "Accessories"
    
    var id: String { rawValue }
    
    /// Icon for display in UI
    var icon: String {
        switch self {
        case .tops: return "tshirt.fill"
        case .bottoms: return "figure.walk"
        case .dresses: return "figure.dress.line.vertical.figure"
        case .footwear: return "shoe.fill"
        case .outerwear: return "cloud.snow.fill"
        case .accessories: return "bag.fill"
        }
    }
    
    /// Subcategories for Level 2 tagging
    var subcategories: [String] {
        switch self {
        case .tops:
            return ["Blouse", "T-shirt", "Shirt", "Sweater/Knit", "Blazer", "Camisole"]
        case .bottoms:
            return ["Jeans", "Trousers", "Skirt", "Shorts", "Leggings"]
        case .dresses:
            return ["Casual Dress", "Cocktail Dress", "Maxi Dress", "Wrap Dress"]
        case .footwear:
            return ["Heels", "Flats", "Sneakers", "Boots", "Sandals"]
        case .outerwear:
            return ["Coat", "Jacket", "Blazer", "Cardigan"]
        case .accessories:
            return ["Bag", "Jewelry", "Scarf", "Sunglasses", "Belt"]
        }
    }
}
