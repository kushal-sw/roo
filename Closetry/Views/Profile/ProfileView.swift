import SwiftUI
import SwiftData
import PhotosUI

struct ProfileView: View {
    @Query private var profiles: [UserProfile]
    @Query private var wardrobeItems: [WardrobeItem]
    @Environment(\.modelContext) private var modelContext
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = true
    
    private var profile: UserProfile {
        profiles.last ?? profiles.first ?? UserProfile(
            name: "Anna K.",
            age: 24,
            locality: "London, UK",
            genderPreference: "Women's Fashion",
            heightCm: 168,
            weightKg: 56,
            bodyShape: .hourglass,
            preferredTopSize: "S",
            preferredBottomSize: "26",
            preferredShoeSize: "7"
        )
    }
    
    var body: some View {
        ZStack {
            // Editorial Off-white / Cream minimalist canvas
            Color(hex: "F7F6F2")
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    
                    // MARK: - 1. Top Section Header (PROFILE --------- 01)
                    HStack(alignment: .bottom) {
                        Text("PROFILE")
                            .font(.system(size: 11, weight: .bold))
                            .tracking(2.5)
                            .foregroundColor(.obsidian)
                        
                        Spacer()
                        
                        Text("01")
                            .font(.system(size: 11, weight: .bold))
                            .tracking(1.5)
                            .foregroundColor(.obsidian)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    
                    Rectangle()
                        .fill(Color.obsidian.opacity(0.12))
                        .frame(height: 1)
                        .padding(.horizontal, 24)
                        .padding(.top, 10)
                        .padding(.bottom, 24)
                    
                    // MARK: - 2. Hero Section: Top-Left Portrait Box & Top-Right Wardrobe Count (e.g. 04 / 20)
                    HStack(alignment: .top, spacing: 20) {
                        // TOP-LEFT BOX: User Portrait Photo or Silhouette Fallback
                        portraitBoxView
                        
                        Spacer()
                        
                        // TOP-RIGHT BOX: Live Count of Clothes in Wardrobe
                        VStack(alignment: .leading, spacing: 6) {
                            Text(String(format: "%02d", max(wardrobeItems.count, 4)))
                                .font(.system(size: 78, weight: .regular, design: .default))
                                .foregroundColor(.obsidian)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                            
                            HStack(spacing: 6) {
                                Circle()
                                    .fill(Color(hex: "2563EB")) // Cobalt blue dot
                                    .frame(width: 7, height: 7)
                                
                                Text("CLOTHES IN WARDROBE")
                                    .font(.system(size: 8.5, weight: .bold))
                                    .tracking(1.4)
                                    .foregroundColor(.obsidian)
                            }
                            .padding(.top, 2)
                            
                            HStack(spacing: 3) {
                                Text("Archetype:")
                                    .font(.system(size: 12.5, weight: .regular))
                                    .foregroundColor(.textSecondary)
                                Text(profile.bodyShape.rawValue)
                                    .font(.system(size: 12.5, weight: .bold))
                                    .foregroundColor(.obsidian)
                            }
                        }
                        .padding(.top, 6)
                    }
                    .padding(.horizontal, 24)
                    
                    // MARK: - 3. Name & Role / Locality / Age
                    VStack(alignment: .leading, spacing: 8) {
                        Text(profile.name.isEmpty ? "Anna K." : profile.name)
                            .font(.system(size: 38, weight: .regular, design: .default))
                            .foregroundColor(.obsidian)
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text(profile.genderPreference.uppercased())
                                .font(.system(size: 9, weight: .bold))
                                .tracking(2.0)
                                .foregroundColor(.textSecondary)
                            
                            HStack(spacing: 8) {
                                Text(profile.locality.isEmpty ? "London, UK" : profile.locality)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.obsidian)
                                
                                Text("•")
                                    .foregroundColor(.textTertiary)
                                
                                Text("\(profile.age) yrs")
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(.textSecondary)
                                
                                Image(systemName: "arrow.up.right")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(.textTertiary)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 18)
                    
                    Rectangle()
                        .fill(Color.obsidian.opacity(0.12))
                        .frame(height: 1)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 20)
                    
                    // MARK: - 4. About / Body Measurements (From Onboarding)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("ABOUT & MEASUREMENTS")
                            .font(.system(size: 9, weight: .bold))
                            .tracking(2.0)
                            .foregroundColor(.textSecondary)
                        
                        Text("Height \(Int(profile.heightCm)) cm (\(heightInFeet(cm: profile.heightCm))) • Weight \(Int(profile.weightKg)) kg • \(profile.bodyShape.rawValue) Structure")
                            .font(.system(size: 14.5, weight: .medium))
                            .foregroundColor(.obsidian)
                        
                        Text(profile.bodyShape.description)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.textSecondary)
                            .lineSpacing(3)
                            .padding(.top, 2)
                    }
                    .padding(.horizontal, 24)
                    
                    // MARK: - 5. Saved Sizes Tags
                    VStack(alignment: .leading, spacing: 12) {
                        Text("SAVED SIZES & FIT")
                            .font(.system(size: 9, weight: .bold))
                            .tracking(2.0)
                            .foregroundColor(.textSecondary)
                        
                        HStack(spacing: 14) {
                            fitTag("Top: \(profile.preferredTopSize)")
                            fitTag("Waist: \(profile.preferredBottomSize)\"")
                            fitTag("Shoe: UK \(profile.preferredShoeSize)")
                            fitTag(profile.bodyShape.rawValue)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                    .padding(.bottom, 24)
                    
                    // MARK: - 6. STYLING ARCHETYPE CONNECT CARD (with Dot Matrix / Jaali Pattern)
                    connectCardBanner
                        .padding(.horizontal, 24)
                        .padding(.bottom, 24)
                    
                    // MARK: - 7. Bottom Stats: Height/Weight vs Saved Sizes
                    bottomStatsRow
                        .padding(.horizontal, 24)
                    
                    Rectangle()
                        .fill(Color.obsidian.opacity(0.12))
                        .frame(height: 1)
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                        .padding(.bottom, 16)
                    
                    // MARK: - Reset Flow Button
                    HStack {
                        Spacer()
                        Button(role: .destructive) {
                            hasCompletedOnboarding = false
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: "arrow.counterclockwise")
                                    .font(.system(size: 11))
                                Text("Reconfigure Profile & Measurements")
                                    .font(.system(size: 12, weight: .medium))
                            }
                            .foregroundColor(.textSecondary)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 36)
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    @State private var profilePhotoItem: PhotosPickerItem? = nil
    
    // MARK: - Top-Left Portrait Box (Uploaded Photo or Silhouette)
    private var portraitBoxView: some View {
        PhotosPicker(selection: $profilePhotoItem, matching: .images) {
            ZStack {
                Rectangle()
                    .fill(Color(hex: "E5E3DD"))
                    .frame(width: 145, height: 165)
                    .clipped()
                
                if let photoData = profile.profileImageData, let uiImage = UIImage(data: photoData) {
                    // User's uploaded portrait photo
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 145, height: 165)
                        .clipped()
                } else {
                    // Fallback Monochromatic Silhouette
                    VStack(spacing: 8) {
                        ZStack {
                            Circle()
                                .fill(Color.obsidian.opacity(0.08))
                                .frame(width: 64, height: 64)
                            
                            Image(systemName: "camera.badge.ellipsis")
                                .font(.system(size: 26, weight: .light))
                                .foregroundColor(.obsidian)
                        }
                        
                        Text("ADD PHOTO")
                            .font(.system(size: 9.5, weight: .bold))
                            .tracking(1.4)
                            .foregroundColor(.obsidian)
                        
                        Text("\(Int(profile.heightCm)) CM • \(Int(profile.weightKg)) KG")
                            .font(.system(size: 8.5, weight: .medium))
                            .foregroundColor(.textSecondary)
                    }
                }
            }
            .overlay(
                Rectangle()
                    .stroke(Color.obsidian.opacity(0.08), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .onChange(of: profilePhotoItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    profile.profileImageData = data
                    try? modelContext.save()
                }
            }
        }
    }
    
    private func fitTag(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 13, weight: .medium))
            .foregroundColor(.obsidian)
    }
    
    // Connect Card Banner with Jaali / Dot Matrix
    private var connectCardBanner: some View {
        ZStack {
            Color(hex: "DCD9D2")
                .cornerRadius(4)
            
            VStack(alignment: .leading, spacing: 0) {
                // Header (STYLING ARCHETYPE ----------- 01)
                HStack {
                    Text("CONNECT CARD")
                        .font(.system(size: 9, weight: .bold))
                        .tracking(1.8)
                        .foregroundColor(.obsidian.opacity(0.8))
                    
                    Spacer()
                    
                    Text("01")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.obsidian.opacity(0.8))
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 14) {
                        Text(profile.bodyShape.stylingTips.first ?? "Share your card to connect intentionally.")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.obsidian)
                            .lineSpacing(3)
                        
                        HStack(spacing: 4) {
                            Text("TAP TO VIEW")
                                .font(.system(size: 9, weight: .bold))
                                .tracking(1.6)
                                .foregroundColor(.obsidian)
                            
                            Image(systemName: "arrow.up.right")
                                .font(.system(size: 9, weight: .semibold))
                                .foregroundColor(.obsidian)
                        }
                    }
                    
                    Spacer()
                    
                    // Dot matrix / Jaali texture
                    dotMatrixGrid
                        .padding(.trailing, 8)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 16)
            }
        }
        .frame(minHeight: 145)
    }
    
    // Dot Matrix Grid Pattern
    private var dotMatrixGrid: some View {
        VStack(spacing: 4) {
            ForEach(0..<9) { _ in
                HStack(spacing: 4) {
                    ForEach(0..<14) { _ in
                        Circle()
                            .fill(Color.obsidian.opacity(0.75))
                            .frame(width: 2.2, height: 2.2)
                    }
                }
            }
        }
    }
    
    // Bottom Stats Row (MEASUREMENTS & SIZING)
    private var bottomStatsRow: some View {
        HStack(spacing: 0) {
            // Height & Weight Stats
            VStack(alignment: .leading, spacing: 6) {
                Text("MEASUREMENTS")
                    .font(.system(size: 9, weight: .bold))
                    .tracking(1.8)
                    .foregroundColor(.textSecondary)
                
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(Int(profile.heightCm))")
                        .font(.system(size: 26, weight: .regular))
                        .foregroundColor(.obsidian)
                    Text("CM")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.textSecondary)
                    
                    Text("•")
                        .foregroundColor(.textTertiary)
                        .padding(.horizontal, 2)
                    
                    Text("\(Int(profile.weightKg))")
                        .font(.system(size: 26, weight: .regular))
                        .foregroundColor(.obsidian)
                    Text("KG")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.textSecondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Vertical Divider
            Rectangle()
                .fill(Color.obsidian.opacity(0.12))
                .frame(width: 1, height: 46)
                .padding(.horizontal, 14)
            
            // Preferred Top & Bottom Size
            VStack(alignment: .leading, spacing: 6) {
                Text("FIT SIZES")
                    .font(.system(size: 9, weight: .bold))
                    .tracking(1.8)
                    .foregroundColor(.textSecondary)
                
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text("\(profile.preferredTopSize) / \(profile.preferredBottomSize)\"")
                        .font(.system(size: 24, weight: .regular))
                        .foregroundColor(.obsidian)
                    
                    Image(systemName: "arrow.up.right")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.textTertiary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func heightInFeet(cm: Double) -> String {
        let totalInches = cm / 2.54
        let feet = Int(totalInches / 12)
        let inches = Int(totalInches.truncatingRemainder(dividingBy: 12))
        return "\(feet)'\(inches)\""
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
    .modelContainer(for: [UserProfile.self, WardrobeItem.self], inMemory: true)
}
