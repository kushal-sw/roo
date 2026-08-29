import Foundation

/// Mock wardrobe data for development and testing.
/// 20 seed items spanning all categories, colors, and occasions.
struct MockWardrobe {
    
    static let items: [WardrobeItem] = [
        // MARK: - Tops
        WardrobeItem(
            photoFileName: "mock_top_black_blouse",
            category: .tops,
            subcategory: "Blouse",
            color: .black,
            occasions: [.work, .date, .party]
        ),
        WardrobeItem(
            photoFileName: "mock_top_white_shirt",
            category: .tops,
            subcategory: "Shirt",
            color: .white,
            occasions: [.work, .casual, .brunch]
        ),
        WardrobeItem(
            photoFileName: "mock_top_navy_tshirt",
            category: .tops,
            subcategory: "T-shirt",
            color: .navy,
            occasions: [.casual, .brunch]
        ),
        WardrobeItem(
            photoFileName: "mock_top_saffron_camisole",
            category: .tops,
            subcategory: "Camisole",
            color: .saffron,
            occasions: [.party, .date, .brunch]
        ),
        WardrobeItem(
            photoFileName: "mock_top_maroon_sweater",
            category: .tops,
            subcategory: "Sweater/Knit",
            color: .maroon,
            occasions: [.casual, .date, .work]
        ),
        
        // MARK: - Bottoms
        WardrobeItem(
            photoFileName: "mock_bottom_blue_jeans",
            category: .bottoms,
            subcategory: "Jeans",
            color: .blue,
            occasions: [.casual, .brunch]
        ),
        WardrobeItem(
            photoFileName: "mock_bottom_black_trousers",
            category: .bottoms,
            subcategory: "Trousers",
            color: .black,
            occasions: [.work, .party, .date]
        ),
        WardrobeItem(
            photoFileName: "mock_bottom_beige_skirt",
            category: .bottoms,
            subcategory: "Skirt",
            color: .beige,
            occasions: [.brunch, .casual, .work]
        ),
        WardrobeItem(
            photoFileName: "mock_bottom_olive_shorts",
            category: .bottoms,
            subcategory: "Shorts",
            color: .olive,
            occasions: [.casual, .brunch]
        ),
        
        // MARK: - Dresses
        WardrobeItem(
            photoFileName: "mock_dress_red_cocktail",
            category: .dresses,
            subcategory: "Cocktail Dress",
            color: .red,
            occasions: [.party, .date]
        ),
        WardrobeItem(
            photoFileName: "mock_dress_peacock_maxi",
            category: .dresses,
            subcategory: "Maxi Dress",
            color: .peacockBlue,
            occasions: [.wedding, .party, .date]
        ),
        WardrobeItem(
            photoFileName: "mock_dress_ivory_casual",
            category: .dresses,
            subcategory: "Casual Dress",
            color: .ivory,
            occasions: [.brunch, .casual]
        ),
        
        // MARK: - Footwear
        WardrobeItem(
            photoFileName: "mock_shoes_gold_heels",
            category: .footwear,
            subcategory: "Heels",
            color: .gold,
            occasions: [.party, .wedding, .date]
        ),
        WardrobeItem(
            photoFileName: "mock_shoes_white_sneakers",
            category: .footwear,
            subcategory: "Sneakers",
            color: .white,
            occasions: [.casual, .brunch]
        ),
        WardrobeItem(
            photoFileName: "mock_shoes_black_flats",
            category: .footwear,
            subcategory: "Flats",
            color: .black,
            occasions: [.work, .casual, .brunch]
        ),
        WardrobeItem(
            photoFileName: "mock_shoes_brown_boots",
            category: .footwear,
            subcategory: "Boots",
            color: .brown,
            occasions: [.casual, .date, .work]
        ),
        
        // MARK: - Outerwear
        WardrobeItem(
            photoFileName: "mock_outerwear_black_jacket",
            category: .outerwear,
            subcategory: "Jacket",
            color: .black,
            occasions: [.casual, .party, .date]
        ),
        WardrobeItem(
            photoFileName: "mock_outerwear_rust_cardigan",
            category: .outerwear,
            subcategory: "Cardigan",
            color: .rust,
            occasions: [.casual, .brunch, .work]
        ),
        
        // MARK: - Accessories
        WardrobeItem(
            photoFileName: "mock_accessory_gold_jewelry",
            category: .accessories,
            subcategory: "Jewelry",
            color: .gold,
            occasions: [.party, .wedding, .date]
        ),
        WardrobeItem(
            photoFileName: "mock_accessory_teal_scarf",
            category: .accessories,
            subcategory: "Scarf",
            color: .teal,
            occasions: [.casual, .brunch, .work]
        ),
    ]
}
