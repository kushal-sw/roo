import SwiftUI
import SwiftData
import PhotosUI

struct AddItemView: View {
    @Environment(\.modelContext) private var modelContext
    
    // Photo Selection State
    @State private var capturedImage: UIImage? = nil
    @State private var photosPickerItem: PhotosPickerItem? = nil
    @State private var showCameraSheet = false
    
    // Tagging & Label Form State
    @State private var selectedCategory: ItemCategory = .tops
    @State private var selectedSubcategory: String = "Blouse"
    @State private var selectedColor: ItemColor = .black
    @State private var selectedOccasions: Set<Occasion> = [.casual]
    @State private var selectedSeasons: Set<Season> = [.summer]
    
    // Label, Brand & Description Fields
    @State private var customTitle = ""
    @State private var brand = ""
    @State private var itemDescription = ""
    
    // UX & Feedback State
    @State private var showSaveSuccessBanner = false
    @State private var showValidationError = false
    @State private var validationMessage = ""
    
    var body: some View {
        ZStack {
            // Background - Warm Alabaster
            Color(hex: "FBF9F5")
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    
                    // MARK: - Header
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Add to Wardrobe")
                            .font(.system(size: 26, weight: .bold, design: .serif))
                            .foregroundColor(Color(hex: "121110"))
                        
                        Text("Photograph, label, and describe your piece to build your digital atelier.")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color(hex: "6B6966"))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    
                    // MARK: - 1. Photo Capture & Gallery Box
                    photoCaptureSection
                        .padding(.horizontal, 20)
                    
                    // MARK: - 2. Item Labels & Description (High Contrast)
                    itemDetailsSection
                        .padding(.horizontal, 20)
                    
                    // MARK: - 3. Category & Subcategory Selectors
                    categorySection
                        .padding(.horizontal, 20)
                    
                    // MARK: - 4. Color Palette Selector
                    colorSection
                        .padding(.horizontal, 20)
                    
                    // MARK: - 5. Occasion & Season Tags
                    tagsSection
                        .padding(.horizontal, 20)
                    
                    // MARK: - 6. Save Button
                    saveButton
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 36)
                }
            }
            
            // MARK: - Success Banner
            if showSaveSuccessBanner {
                VStack {
                    HStack(spacing: 10) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color.champagneGold)
                        Text("Piece saved to your wardrobe!")
                            .font(.labelMedium)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 22)
                    .padding(.vertical, 14)
                    .background(Color(hex: "121110"))
                    .cornerRadius(24)
                    .shadow(color: .black.opacity(0.15), radius: 10, y: 4)
                    .padding(.top, 16)
                    
                    Spacer()
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .navigationTitle("Add Piece")
        .navigationBarTitleDisplayMode(.inline)
        // Camera Sheet
        .fullScreenCover(isPresented: $showCameraSheet) {
            CameraCaptureView(selectedImage: $capturedImage)
                .ignoresSafeArea()
        }
        // PhotosPicker onChange handler
        .onChange(of: photosPickerItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    await MainActor.run {
                        capturedImage = uiImage
                    }
                }
            }
        }
    }
    
    // MARK: - 1. Photo Capture & Gallery Box
    private var photoCaptureSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("PIECE PHOTO")
                .font(.system(size: 10, weight: .bold))
                .tracking(1.8)
                .foregroundColor(Color(hex: "6B6966"))
            
            if let image = capturedImage {
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 240)
                        .clipped()
                        .cornerRadius(16)
                    
                    HStack(spacing: 8) {
                        // Camera retake
                        Button {
                            showCameraSheet = true
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "camera.fill")
                                Text("Camera")
                            }
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 7)
                            .background(Color(hex: "121110").opacity(0.85))
                            .cornerRadius(16)
                        }
                        
                        // Gallery change
                        PhotosPicker(selection: $photosPickerItem, matching: .images) {
                            HStack(spacing: 4) {
                                Image(systemName: "photo.fill")
                                Text("Gallery")
                            }
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 7)
                            .background(Color(hex: "121110").opacity(0.85))
                            .cornerRadius(16)
                        }
                    }
                    .padding(12)
                }
            } else {
                // Dual Action Photo Box (Camera + Gallery Side-by-Side)
                HStack(spacing: 12) {
                    // Button 1: Click Photo with Camera
                    Button {
                        showCameraSheet = true
                    } label: {
                        VStack(spacing: 10) {
                            ZStack {
                                Circle()
                                    .fill(Color.champagneGold.opacity(0.15))
                                    .frame(width: 52, height: 52)
                                
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(Color.champagneGold)
                            }
                            
                            VStack(spacing: 2) {
                                Text("Take Photo")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(Color(hex: "121110"))
                                Text("Use Camera")
                                    .font(.system(size: 11))
                                    .foregroundColor(Color(hex: "6B6966"))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 155)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.champagneGold.opacity(0.35), lineWidth: 1.2)
                        )
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.04), radius: 4, y: 2)
                    }
                    .buttonStyle(.plain)
                    
                    // Button 2: Choose from Gallery / Library
                    PhotosPicker(selection: $photosPickerItem, matching: .images) {
                        VStack(spacing: 10) {
                            ZStack {
                                Circle()
                                    .fill(Color.peacockBlue.opacity(0.12))
                                    .frame(width: 52, height: 52)
                                
                                Image(systemName: "photo.on.rectangle.angled")
                                    .font(.system(size: 22))
                                    .foregroundColor(Color.peacockBlue)
                            }
                            
                            VStack(spacing: 2) {
                                Text("Choose Photo")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(Color(hex: "121110"))
                                Text("From Gallery")
                                    .font(.system(size: 11))
                                    .foregroundColor(Color(hex: "6B6966"))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 155)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.peacockBlue.opacity(0.35), lineWidth: 1.2)
                        )
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.04), radius: 4, y: 2)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
    
    // MARK: - 2. Item Labels & Description (Explicit High Contrast)
    private var itemDetailsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("PIECE DETAILS & DESCRIPTION")
                .font(.system(size: 10, weight: .bold))
                .tracking(1.8)
                .foregroundColor(Color(hex: "6B6966"))
            
            VStack(spacing: 14) {
                // Piece Label / Name
                VStack(alignment: .leading, spacing: 6) {
                    Text("Piece Title / Label")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color(hex: "121110"))
                    
                    TextField("e.g. Silk Ivory Wrap Blouse", text: $customTitle)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(Color(hex: "121110")) // Explicit Deep Obsidian text
                        .tint(Color.champagneGold)
                        .padding(14)
                        .background(Color.white) // Explicit clean white background
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(hex: "D8D4CE"), lineWidth: 1)
                        )
                }
                
                // Brand / Label
                VStack(alignment: .leading, spacing: 6) {
                    Text("Brand / Boutique (Optional)")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color(hex: "121110"))
                    
                    TextField("e.g. Zara, Raw Mango, Fabindia", text: $brand)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(Color(hex: "121110"))
                        .tint(Color.champagneGold)
                        .padding(14)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(hex: "D8D4CE"), lineWidth: 1)
                        )
                }
                
                // Description Text Area
                VStack(alignment: .leading, spacing: 6) {
                    Text("Description & Styling Notes")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(Color(hex: "121110"))
                    
                    TextField("e.g. Lightweight mulmul cotton with gold zari border, pairs best with high-waisted linen trousers.", text: $itemDescription, axis: .vertical)
                        .lineLimit(3...6)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(Color(hex: "121110")) // Explicit Deep Obsidian text
                        .tint(Color.champagneGold)
                        .padding(14)
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(hex: "D8D4CE"), lineWidth: 1)
                        )
                }
            }
        }
    }
    
    // MARK: - 3. Category & Subcategory Selectors
    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("CATEGORY")
                .font(.system(size: 10, weight: .bold))
                .tracking(1.8)
                .foregroundColor(Color(hex: "6B6966"))
            
            // Top Level Category Grid
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(ItemCategory.allCases) { cat in
                    Button {
                        selectedCategory = cat
                        selectedSubcategory = cat.subcategories.first ?? ""
                    } label: {
                        VStack(spacing: 6) {
                            Image(systemName: cat.icon)
                                .font(.system(size: 18))
                            Text(cat.rawValue)
                                .font(.system(size: 13, weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(selectedCategory == cat ? Color.champagneGold : Color.white)
                        .foregroundColor(selectedCategory == cat ? .white : Color(hex: "121110"))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.03), radius: 2, y: 1)
                    }
                    .buttonStyle(.plain)
                }
            }
            
            // Subcategory Chips
            VStack(alignment: .leading, spacing: 8) {
                Text("Subcategory: \(selectedSubcategory)")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(Color(hex: "121110"))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(selectedCategory.subcategories, id: \.self) { sub in
                            Button {
                                selectedSubcategory = sub
                            } label: {
                                Text(sub)
                                    .font(.system(size: 12.5, weight: .medium))
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 8)
                                    .background(selectedSubcategory == sub ? Color(hex: "121110") : Color.white)
                                    .foregroundColor(selectedSubcategory == sub ? .white : Color(hex: "121110"))
                                    .cornerRadius(20)
                                    .shadow(color: .black.opacity(0.03), radius: 2, y: 1)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 2)
                }
            }
            .padding(.top, 4)
        }
    }
    
    // MARK: - 4. Color Palette Selector
    private var colorSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("COLOR")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(1.8)
                    .foregroundColor(Color(hex: "6B6966"))
                
                Spacer()
                
                Text(selectedColor.rawValue)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(Color.champagneGold)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(ItemColor.allCases) { color in
                        Button {
                            selectedColor = color
                        } label: {
                            VStack(spacing: 4) {
                                Circle()
                                    .fill(color.swatchColor)
                                    .frame(width: 32, height: 32)
                                    .overlay(
                                        Circle()
                                            .stroke(selectedColor == color ? Color.champagneGold : Color(hex: "D8D4CE"), lineWidth: selectedColor == color ? 3 : 1)
                                    )
                                    .scaleEffect(selectedColor == color ? 1.15 : 1.0)
                                
                                Text(color.rawValue)
                                    .font(.system(size: 9.5))
                                    .foregroundColor(selectedColor == color ? Color(hex: "121110") : Color(hex: "6B6966"))
                                    .lineLimit(1)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }
    
    // MARK: - 5. Occasion & Season Tags
    private var tagsSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            // Occasions (Multi-select)
            VStack(alignment: .leading, spacing: 8) {
                Text("OCCASIONS (SELECT ALL THAT APPLY)")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(1.8)
                    .foregroundColor(Color(hex: "6B6966"))
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(Occasion.allCases) { occ in
                            let isSelected = selectedOccasions.contains(occ)
                            Button {
                                if isSelected {
                                    if selectedOccasions.count > 1 {
                                        selectedOccasions.remove(occ)
                                    }
                                } else {
                                    selectedOccasions.insert(occ)
                                }
                            } label: {
                                HStack(spacing: 5) {
                                    Image(systemName: occ.icon)
                                        .font(.system(size: 11))
                                    Text(occ.rawValue)
                                        .font(.system(size: 12.5, weight: .medium))
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(isSelected ? Color.peacockBlue : Color.white)
                                .foregroundColor(isSelected ? .white : Color(hex: "121110"))
                                .cornerRadius(18)
                                .shadow(color: .black.opacity(0.03), radius: 2, y: 1)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 2)
                }
            }
            
            // Seasons (Multi-select)
            VStack(alignment: .leading, spacing: 8) {
                Text("SEASONS")
                    .font(.system(size: 10, weight: .bold))
                    .tracking(1.8)
                    .foregroundColor(Color(hex: "6B6966"))
                
                HStack(spacing: 8) {
                    ForEach(Season.allCases) { season in
                        let isSelected = selectedSeasons.contains(season)
                        Button {
                            if isSelected {
                                selectedSeasons.remove(season)
                            } else {
                                selectedSeasons.insert(season)
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: season.icon)
                                    .font(.system(size: 10))
                                Text(season.rawValue)
                                    .font(.system(size: 12.5, weight: .medium))
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(isSelected ? Color.champagneGold : Color.white)
                            .foregroundColor(isSelected ? .white : Color(hex: "121110"))
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.03), radius: 2, y: 1)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
    
    // MARK: - 6. Save Action
    private var saveButton: some View {
        Button {
            saveWardrobeItem()
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 16, weight: .bold))
                Text("Save Piece to Closet")
                    .font(.system(size: 16, weight: .bold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                LinearGradient(
                    colors: [Color.champagneGold, Color.champagneGold.opacity(0.85)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(14)
            .shadow(color: Color.champagneGold.opacity(0.35), radius: 8, y: 4)
        }
    }
    
    // MARK: - Save Logic
    private func saveWardrobeItem() {
        var photoFileName = "placeholder"
        
        if let image = capturedImage {
            if let savedName = ImageStorageManager.shared.saveImage(image) {
                photoFileName = savedName
            }
        }
        
        let sub = customTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? selectedSubcategory : customTitle
        
        let newItem = WardrobeItem(
            photoFileName: photoFileName,
            category: selectedCategory,
            subcategory: sub,
            color: selectedColor,
            occasions: Array(selectedOccasions),
            seasons: Array(selectedSeasons),
            itemDescription: itemDescription.trimmingCharacters(in: .whitespacesAndNewlines),
            brand: brand.trimmingCharacters(in: .whitespacesAndNewlines),
            dateAdded: Date(),
            isFavorite: false
        )
        
        modelContext.insert(newItem)
        try? modelContext.save()
        
        // Reset form
        capturedImage = nil
        photosPickerItem = nil
        customTitle = ""
        brand = ""
        itemDescription = ""
        
        // Trigger UX confirmation banner
        withAnimation(.easeInOut(duration: 0.3)) {
            showSaveSuccessBanner = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeInOut(duration: 0.3)) {
                showSaveSuccessBanner = false
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddItemView()
    }
    .modelContainer(for: WardrobeItem.self, inMemory: true)
}
