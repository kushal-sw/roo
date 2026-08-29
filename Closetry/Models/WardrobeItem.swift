import Foundation
import SwiftData

/// A single wardrobe item stored via SwiftData.
/// Each item has a photo, category/subcategory, color, occasion tags, and optional season tags.
@Model
class WardrobeItem {
    var id: UUID
    
    /// Filename of the full-resolution photo stored in the app sandbox
    var photoFileName: String
    
    /// Top-level category (Tops, Bottoms, Dresses, Footwear, Outerwear, Accessories)
    var categoryRaw: String
    
    /// Subcategory dependent on the category (e.g., "Blouse" for Tops)
    var subcategory: String
    
    /// Color from the extended palette
    var colorRaw: String
    
    /// Occasion tags (multi-select, stored as raw values)
    var occasionRaws: [String]
    
    /// Season tags (optional, multi-select, stored as raw values)
    var seasonRaws: [String]
    
    /// Detailed notes or description of the piece
    var itemDescription: String
    
    /// Optional brand or label name
    var brand: String
    
    /// Date the item was added to the wardrobe
    var dateAdded: Date
    
    /// Whether the user has favorited this item
    var isFavorite: Bool
    
    // MARK: - Computed Properties (not persisted)
    
    var category: ItemCategory {
        get { ItemCategory(rawValue: categoryRaw) ?? .tops }
        set { categoryRaw = newValue.rawValue }
    }
    
    var color: ItemColor {
        get { ItemColor(rawValue: colorRaw) ?? .black }
        set { colorRaw = newValue.rawValue }
    }
    
    var occasions: [Occasion] {
        get { occasionRaws.compactMap { Occasion(rawValue: $0) } }
        set { occasionRaws = newValue.map(\.rawValue) }
    }
    
    var seasons: [Season] {
        get { seasonRaws.compactMap { Season(rawValue: $0) } }
        set { seasonRaws = newValue.map(\.rawValue) }
    }
    
    // MARK: - Initializer
    
    init(
        id: UUID = UUID(),
        photoFileName: String,
        category: ItemCategory,
        subcategory: String,
        color: ItemColor,
        occasions: [Occasion],
        seasons: [Season] = [],
        itemDescription: String = "",
        brand: String = "",
        dateAdded: Date = Date(),
        isFavorite: Bool = false
    ) {
        self.id = id
        self.photoFileName = photoFileName
        self.categoryRaw = category.rawValue
        self.subcategory = subcategory
        self.colorRaw = color.rawValue
        self.occasionRaws = occasions.map(\.rawValue)
        self.seasonRaws = seasons.map(\.rawValue)
        self.itemDescription = itemDescription
        self.brand = brand
        self.dateAdded = dateAdded
        self.isFavorite = isFavorite
    }
}
