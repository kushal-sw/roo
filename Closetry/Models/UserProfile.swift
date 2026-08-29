import Foundation
import SwiftData

/// User profile stored via SwiftData.
/// Contains personal details, body measurements, and body shape for styling tips.
@Model
class UserProfile {
    var id: UUID
    
    /// User's display name
    var name: String
    
    /// User's locality (city/area)
    var locality: String
    
    /// Height in centimeters
    var heightCm: Double
    
    /// Weight in kilograms
    var weightKg: Double
    
    /// Body shape archetype (stored as raw string)
    var bodyShapeRaw: String
    
    /// Preferred top size (e.g., "S", "M", "L", "XL")
    var preferredTopSize: String
    
    /// Preferred bottom size (e.g., "28", "30", "32")
    var preferredBottomSize: String
    
    /// Preferred shoe size (e.g., "7", "8", "9")
    var preferredShoeSize: String
    
    /// User's age
    var age: Int
    
    /// Styling / fit preference
    var genderPreference: String
    
    /// Profile portrait photo data
    @Attribute(.externalStorage) var profileImageData: Data?
    
    // MARK: - Computed Properties
    
    var bodyShape: BodyShape {
        get { BodyShape(rawValue: bodyShapeRaw) ?? .rectangle }
        set { bodyShapeRaw = newValue.rawValue }
    }
    
    // MARK: - Initializer
    
    init(
        id: UUID = UUID(),
        name: String = "",
        age: Int = 24,
        locality: String = "",
        genderPreference: String = "Women's Fashion",
        heightCm: Double = 165,
        weightKg: Double = 60,
        bodyShape: BodyShape = .rectangle,
        preferredTopSize: String = "M",
        preferredBottomSize: String = "30",
        preferredShoeSize: String = "8",
        profileImageData: Data? = nil
    ) {
        self.id = id
        self.name = name
        self.age = age
        self.locality = locality
        self.genderPreference = genderPreference
        self.heightCm = heightCm
        self.weightKg = weightKg
        self.bodyShapeRaw = bodyShape.rawValue
        self.preferredTopSize = preferredTopSize
        self.preferredBottomSize = preferredBottomSize
        self.preferredShoeSize = preferredShoeSize
        self.profileImageData = profileImageData
    }
}
