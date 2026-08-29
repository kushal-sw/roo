import Foundation

/// The 5 classic body shape archetypes.
/// Used for profile display and styling tips (not wired into Stylist engine in Phase 1).
enum BodyShape: String, Codable, CaseIterable, Identifiable {
    case hourglass = "Hourglass"
    case pear = "Pear"
    case apple = "Apple"
    case rectangle = "Rectangle"
    case invertedTriangle = "Inverted Triangle"
    
    var id: String { rawValue }
    
    /// Icon for chip selector
    var icon: String {
        switch self {
        case .hourglass: return "hourglass"
        case .pear: return "triangle.fill"
        case .apple: return "circle.fill"
        case .rectangle: return "rectangle.fill"
        case .invertedTriangle: return "triangle.inset.filled"
        }
    }
    
    /// Brief description shown on the profile page
    var description: String {
        switch self {
        case .hourglass:
            return "Balanced bust and hips with a defined waist"
        case .pear:
            return "Hips wider than shoulders with a defined waist"
        case .apple:
            return "Fuller midsection with broader shoulders"
        case .rectangle:
            return "Balanced proportions with a less defined waist"
        case .invertedTriangle:
            return "Shoulders wider than hips"
        }
    }
    
    /// Styling tips displayed on the Profile screen
    var stylingTips: [String] {
        switch self {
        case .hourglass:
            return [
                "Emphasize your waist with fitted silhouettes and wrap styles",
                "Belted dresses and tops highlight your natural shape",
                "V-necks and scoop necks are your best friends",
                "Avoid overly boxy or shapeless cuts"
            ]
        case .pear:
            return [
                "Draw attention upward with statement necklines and bold tops",
                "A-line skirts and bootcut trousers balance your proportions",
                "Structured shoulders and puff sleeves add width on top",
                "Dark-wash bottoms create a streamlined lower half"
            ]
        case .apple:
            return [
                "Empire waistlines and flowy fabrics are flattering",
                "V-necks elongate your torso beautifully",
                "Structured jackets create definition around the waist",
                "Straight-leg or bootcut trousers balance your silhouette"
            ]
        case .rectangle:
            return [
                "Create curves with peplum tops and belted waists",
                "Layering adds dimension and visual interest",
                "Ruffles and draping soften straight lines",
                "High-waisted bottoms give the illusion of curves"
            ]
        case .invertedTriangle:
            return [
                "Wide-leg trousers and flared skirts balance your shoulders",
                "V-necks and vertical details narrow the upper body",
                "Avoid shoulder pads and boat necks",
                "Full skirts and A-line cuts add volume at the hips"
            ]
        }
    }
}
