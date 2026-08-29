//
//  WardrobeItemCard.swift
//  Closetry
//
//  Created by kushal sw on 29/08/26.
//
import SwiftUI

/// Compact grid cell showing a wardrobe item's photo, category badge, and color dot.
struct WardrobeItemCard: View {
    let item: WardrobeItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                photoView
                    .frame(height: 160)
                    .frame(maxWidth: .infinity)
                    .background(Color.inputBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 14))

                if item.isFavorite {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 13))
                        .foregroundColor(.champagneGold)
                        .padding(8)
                        .background(.ultraThinMaterial, in: Circle())
                        .padding(8)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Circle()
                        .fill(item.color.swatchColor)
                        .frame(width: 10, height: 10)
                        .overlay(
                            Circle().stroke(Color.divider, lineWidth: item.color == .white ? 1 : 0)
                        )

                    Text(item.subcategory)
                        .font(.labelSmall)
                        .foregroundColor(.obsidian)
                        .lineLimit(1)
                }

                HStack(spacing: 4) {
                    Image(systemName: item.category.icon)
                        .font(.system(size: 10))
                    Text(item.category.rawValue)
                        .font(.captionText)
                }
                .foregroundColor(.textSecondary)
            }
            .padding(.horizontal, 4)
        }
        .padding(8)
        .background(Color.cardSurface)
        .cornerRadius(16)
        .shadow(color: .cardShadow, radius: 4, y: 2)
    }

    @ViewBuilder
    private var photoView: some View {
        if let uiImage = ImageStorageManager.shared.loadImage(fileName: item.photoFileName) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .clipped()
        } else {
            VStack {
                Image(systemName: item.category.icon)
                    .font(.system(size: 32, weight: .thin))
                    .foregroundColor(.textTertiary)
            }
        }
    }
}

#Preview {
    WardrobeItemCard(
        item: WardrobeItem(
            photoFileName: "placeholder",
            category: .tops,
            subcategory: "Blouse",
            color: .black,
            occasions: [.work]
        )
    )
    .frame(width: 170)
    .padding()
    .background(Color.alabaster)
}
