import Foundation

/// The 6 preset occasion tags for wardrobe items.
/// Users can tag items with multiple occasions.
enum Occasion: String, Codable, CaseIterable, Identifiable {
    case party = "Party"
    case work = "Work"
    case casual = "Casual"
    case date = "Date"
    case wedding = "Wedding"
    case brunch = "Brunch"
    
    var id: String { rawValue }
    
    /// Icon for display
    var icon: String {
        switch self {
        case .party: return "party.popper.fill"
        case .work: return "briefcase.fill"
        case .casual: return "cup.and.saucer.fill"
        case .date: return "heart.fill"
        case .wedding: return "sparkles"
        case .brunch: return "fork.knife"
        }
    }
    
    /// Keywords the PromptParser uses to identify this occasion from free text
    var keywords: [String] {
        switch self {
        case .party:
            return ["party", "club", "nightout", "night out", "birthday", "celebration",
                    "festive", "festival", "dance", "rave", "gala", "cocktail party",
                    "new year", "diwali", "holi", "get together", "function"]
        case .work:
            return ["work", "office", "meeting", "interview", "presentation",
                    "conference", "professional", "corporate", "business", "formal",
                    "client", "boardroom", "seminar", "workshop"]
        case .casual:
            return ["casual", "everyday", "daily", "chill", "relax", "weekend",
                    "hangout", "hang out", "errand", "shopping", "mall",
                    "movie", "lounge", "comfort", "home", "lazy"]
        case .date:
            return ["date", "dinner", "romantic", "anniversary", "valentine",
                    "candlelight", "special evening", "date night", "evening out",
                    "fancy dinner", "restaurant"]
        case .wedding:
            return ["wedding", "shaadi", "sangeet", "mehendi", "reception",
                    "engagement", "ceremony", "haldi", "baraat", "nikah",
                    "ring ceremony", "cocktail night"]
        case .brunch:
            return ["brunch", "breakfast", "lunch", "cafe", "coffee",
                    "morning", "afternoon", "picnic", "garden", "patio",
                    "terrace", "day out", "daytime"]
        }
    }
}
