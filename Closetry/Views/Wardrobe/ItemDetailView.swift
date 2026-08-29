//
//  ItemDetailView.swift
//  Closetry
//
//  Created by kushal sw on 29/08/26.
//

import SwiftUI

/// Full detail view for a single wardrobe item, with edit/delete actions.
struct ItemDetailView: View {
    @Bindable var item: WardrobeItem
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var showDeleteConfirmation = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                photoView
                    .frame(height: 340)
                    .frame(maxWidth: .infinity)
                    .background(Color.inputBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.subcategory)
                                .font(.titleMedium)
                                .foregroundColor(.obsidian)
                            Text(item.category.rawValue)
                                .font(.bodyMedium)
                                .foregroundColor(.textSecondary)
                        }

                        Spacer()

                        Button {
                            item.isFavorite.toggle()
                        } label: {
                            Image(systemName: item.isFavorite ? "heart.fill" : "heart")
                                .font(.system(size: 20))
                                .foregroundColor(.champagneGold)
                        }
                    }

                    if !item.brand.isEmpty {
                        detailRow(label: "Brand / Label") {
                            Text(item.brand)
                                .font(.bodyMedium)
                                .foregroundColor(.obsidian)
                        }
                    }

                    if !item.itemDescription.isEmpty {
                        detailRow(label: "Description & Notes") {
                            Text(item.itemDescription)
                                .font(.bodyMedium)
                                .foregroundColor(.obsidian)
                                .lineSpacing(3)
                        }
                    }

                    detailRow(label: "Color") {
                        HStack(spacing: 6) {
                            Circle()
                                .fill(item.color.swatchColor)
                                .frame(width: 16, height: 16)
                                .overlay(
                                    Circle().stroke(Color.divider, lineWidth: item.color == .white ? 1 : 0)
                                )
                            Text(item.color.rawValue)
                                .font(.bodyMedium)
                                .foregroundColor(.obsidian)
                        }
                    }

                    if !item.occasions.isEmpty {
                        detailRow(label: "Occasions") {
                            tagWrap(items: item.occasions.map(\.rawValue))
                        }
                    }

                    if !item.seasons.isEmpty {
                        detailRow(label: "Seasons") {
                            tagWrap(items: item.seasons.map(\.rawValue))
                        }
                    }

                    detailRow(label: "Added") {
                        Text(item.dateAdded.formatted(date: .abbreviated, time: .omitted))
                            .font(.bodyMedium)
                            .foregroundColor(.obsidian)
                    }
                }
                .padding(.horizontal, 16)

                Button(role: .destructive) {
                    showDeleteConfirmation = true
                } label: {
                    Text("Delete Item")
                        .font(.labelSmall)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.red.opacity(0.85))
                        .cornerRadius(14)
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
            }
            .padding(.bottom, 32)
        }
        .background(Color.alabaster.ignoresSafeArea())
        .navigationTitle(item.subcategory)
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog(
            "Delete this item?",
            isPresented: $showDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) {
                modelContext.delete(item)
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        }
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
                    .font(.system(size: 48, weight: .thin))
                    .foregroundColor(.textTertiary)
            }
        }
    }

    private func detailRow<Content: View>(label: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label.uppercased())
                .font(.captionText)
                .foregroundColor(.textTertiary)
            content()
        }
    }

    private func tagWrap(items: [String]) -> some View {
        HStack(spacing: 6) {
            ForEach(items, id: \.self) { tag in
                Text(tag)
                    .font(.labelSmall)
                    .foregroundColor(.obsidian)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.cardSurface)
                    .cornerRadius(12)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ItemDetailView(
            item: WardrobeItem(
                photoFileName: "placeholder",
                category: .tops,
                subcategory: "Blouse",
                color: .black,
                occasions: [.work, .casual]
            )
        )
    }
}
