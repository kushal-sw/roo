import Foundation

/// Seasons for optional wardrobe item tagging.
/// Not used by the Stylist engine in Phase 1 — captured now for future use.
enum Season: String, Codable, CaseIterable, Identifiable {
    case spring = "Spring"
    case summer = "Summer"
    case fall = "Fall"
    case winter = "Winter"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .spring: return "leaf.fill"
        case .summer: return "sun.max.fill"
        case .fall: return "wind"
        case .winter: return "snowflake"
        }
    }
}
