import SwiftUI
import SwiftData
import PhotosUI

struct OnboardingContainerView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    // Multi-step State
    @State private var currentStep = 0
    
    // User Profile Form Fields
    @State private var name = ""
    @State private var age = 24
    @State private var locality = ""
    @State private var genderPreference = "Women's Fashion"
    @State private var heightCm = 165.0
    @State private var weightKg = 58.0
    @State private var selectedBodyShape: BodyShape = .hourglass
    @State private var preferredTopSize = "M"
    @State private var preferredBottomSize = "28"
    @State private var preferredShoeSize = "7"
    
    // Portrait Photo Picker State
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var selectedPhotoData: Data? = nil
    
    private let totalSteps = 4
    
    var body: some View {
        ZStack {
            Color.alabaster.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Top Progress Bar & Header
                topBar
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                
                // MARK: - Step Content
                TabView(selection: $currentStep) {
                    welcomeStep
                        .tag(0)
                    
                    personalDetailsStep
                        .tag(1)
                    
                    bodyProfileStep
                        .tag(2)
                    
                    stylePreferencesStep
                        .tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut(duration: 0.35), value: currentStep)
                
                // MARK: - Bottom Action Buttons
                bottomActionBar
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
            }
        }
    }
    
    // MARK: - Top Navigation & Progress Bar
    private var topBar: some View {
        VStack(spacing: 12) {
            HStack {
                if currentStep > 0 {
                    Button {
                        withAnimation {
                            currentStep -= 1
                        }
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 14, weight: .semibold))
                            Text("Back")
                                .font(.labelMedium)
                        }
                        .foregroundColor(.obsidian)
                    }
                } else {
                    Spacer()
                        .frame(width: 50)
                }
                
                Spacer()
                
                Text("STEP \(currentStep + 1) OF \(totalSteps)")
                    .font(.system(size: 11, weight: .bold))
                    .tracking(1.8)
                    .foregroundColor(.champagneGold)
                
                Spacer()
                
                if currentStep > 0 && currentStep < totalSteps - 1 {
                    Button("Skip") {
                        withAnimation {
                            currentStep += 1
                        }
                    }
                    .font(.labelMedium)
                    .foregroundColor(.textSecondary)
                } else {
                    Spacer()
                        .frame(width: 50)
                }
            }
            
            // Progress Track
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.divider)
                        .frame(height: 3)
                    
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [Color.champagneGold, Color.peacockBlue],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geo.size.width * CGFloat(currentStep + 1) / CGFloat(totalSteps), height: 3)
                        .animation(.easeInOut(duration: 0.3), value: currentStep)
                }
            }
            .frame(height: 3)
        }
    }
    
    // MARK: - Step 0: Welcome & Philosophy
    private var welcomeStep: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 28) {
                Spacer().frame(height: 20)
                
                ZStack {
                    Circle()
                        .fill(Color.champagneGold.opacity(0.1))
                        .frame(width: 110, height: 110)
                    
                    Image(systemName: "sparkles")
                        .font(.system(size: 44, weight: .light))
                        .foregroundColor(.champagneGold)
                }
                
                VStack(spacing: 10) {
                    Text("Welcome to Closetry")
                        .font(.system(size: 28, weight: .bold, design: .serif))
                        .foregroundColor(.obsidian)
                        .multilineTextAlignment(.center)
                    
                    Text("Your personalized high-fashion stylist and smart digital wardrobe.")
                        .font(.bodyMedium)
                        .foregroundColor(.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                }
                
                VStack(alignment: .leading, spacing: 18) {
                    featureRow(icon: "camera.viewfinder", title: "Digitize Your Closet", subtitle: "Snap photos of your pieces to build your virtual wardrobe.")
                    featureRow(icon: "wand.and.stars", title: "Occasion-Based Styling", subtitle: "Ask our stylist what to wear for weddings, dates, office, or brunch.")
                    featureRow(icon: "bag.badge.plus", title: "Fill The Wardrobe Gaps", subtitle: "Instant smart shopping picks to complete missing outfit slots.")
                }
                .padding(20)
                .background(Color.cardSurface)
                .cornerRadius(16)
                .shadow(color: .cardShadow, radius: 8, y: 3)
                .padding(.horizontal, 4)
                
                Spacer().frame(height: 20)
            }
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Step 1: Personal Details & Portrait Photo
    private var personalDetailsStep: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 22) {
                stepHeader(
                    title: "Personal Profile",
                    subtitle: "Add your portrait and details to personalize your atelier card."
                )
                
                // Photo Upload Card
                HStack(spacing: 16) {
                    ZStack {
                        if let photoData = selectedPhotoData, let uiImage = UIImage(data: photoData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 95)
                                .clipped()
                                .cornerRadius(8)
                        } else {
                            Rectangle()
                                .fill(Color.inputBackground)
                                .frame(width: 80, height: 95)
                                .cornerRadius(8)
                                .overlay(
                                    VStack(spacing: 4) {
                                        Image(systemName: "camera.fill")
                                            .font(.system(size: 20))
                                            .foregroundColor(.champagneGold)
                                        Text("Add Photo")
                                            .font(.system(size: 9, weight: .bold))
                                            .foregroundColor(.textSecondary)
                                    }
                                )
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.obsidian.opacity(0.1), lineWidth: 1)
                    )
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Profile Portrait")
                            .font(.labelLarge)
                            .foregroundColor(.obsidian)
                        
                        Text("Featured on your editorial profile card.")
                            .font(.captionText)
                            .foregroundColor(.textSecondary)
                        
                        PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                            HStack(spacing: 6) {
                                Image(systemName: selectedPhotoData == nil ? "plus" : "arrow.triangle.2.circlepath")
                                    .font(.system(size: 11, weight: .bold))
                                Text(selectedPhotoData == nil ? "Choose Photo" : "Change Photo")
                                    .font(.system(size: 12, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 7)
                            .background(Color.obsidian)
                            .cornerRadius(8)
                        }
                        .onChange(of: selectedPhotoItem) { _, newItem in
                            Task {
                                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                    selectedPhotoData = data
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(14)
                .background(Color.cardSurface)
                .cornerRadius(14)
                .shadow(color: .cardShadow, radius: 4, y: 2)
                .padding(.horizontal, 4)
                
                VStack(spacing: 18) {
                    // Name Field
                    customTextField(
                        title: "Full Name or Nickname",
                        placeholder: "e.g. Ananya Sharma",
                        text: $name,
                        icon: "person"
                    )
                    
                    // Age Field
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Age")
                                .font(.labelMedium)
                                .foregroundColor(.obsidian)
                            Spacer()
                            Text("\(age) years")
                                .font(.labelMedium)
                                .foregroundColor(.champagneGold)
                        }
                        
                        HStack(spacing: 12) {
                            Slider(value: Binding(
                                get: { Double(age) },
                                set: { age = Int($0) }
                            ), in: 16...75, step: 1)
                            .tint(.champagneGold)
                            
                            Stepper("", value: $age, in: 16...80)
                                .labelsHidden()
                        }
                        .padding(14)
                        .background(Color.cardSurface)
                        .cornerRadius(12)
                        .shadow(color: .cardShadow, radius: 4, y: 2)
                    }
                    
                    // Locality Field
                    customTextField(
                        title: "City / Locality",
                        placeholder: "e.g. Mumbai, Bandra West",
                        text: $locality,
                        icon: "mappin.and.ellipse"
                    )
                    
                    // Fashion Preference
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Style Preference")
                            .font(.labelMedium)
                            .foregroundColor(.obsidian)
                        
                        HStack(spacing: 10) {
                            ForEach(["Women's Fashion", "Men's Fashion", "Universal / Unisex"], id: \.self) { pref in
                                selectionChip(title: pref, isSelected: genderPreference == pref) {
                                    genderPreference = pref
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 4)
                
                Spacer().frame(height: 20)
            }
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Step 2: Body Profile
    private var bodyProfileStep: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                stepHeader(
                    title: "Body & Measurements",
                    subtitle: "Helps suggest silhouettes and cuts that elevate your natural form."
                )
                
                // Height Slider
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Height")
                            .font(.labelMedium)
                            .foregroundColor(.obsidian)
                        Spacer()
                        Text("\(Int(heightCm)) cm (\(heightInFeetInches(cm: heightCm)))")
                            .font(.labelMedium)
                            .foregroundColor(.champagneGold)
                    }
                    
                    Slider(value: $heightCm, in: 140...210, step: 1)
                        .tint(.champagneGold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                        .background(Color.cardSurface)
                        .cornerRadius(12)
                        .shadow(color: .cardShadow, radius: 4, y: 2)
                }
                
                // Weight Slider
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Weight")
                            .font(.labelMedium)
                            .foregroundColor(.obsidian)
                        Spacer()
                        Text("\(Int(weightKg)) kg")
                            .font(.labelMedium)
                            .foregroundColor(.champagneGold)
                    }
                    
                    Slider(value: $weightKg, in: 40...140, step: 1)
                        .tint(.champagneGold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 12)
                        .background(Color.cardSurface)
                        .cornerRadius(12)
                        .shadow(color: .cardShadow, radius: 4, y: 2)
                }
                
                // Body Shape Selector
                VStack(alignment: .leading, spacing: 12) {
                    Text("Select Your Body Shape")
                        .font(.labelMedium)
                        .foregroundColor(.obsidian)
                    
                    VStack(spacing: 10) {
                        ForEach(BodyShape.allCases) { shape in
                            bodyShapeCard(shape: shape, isSelected: selectedBodyShape == shape) {
                                selectedBodyShape = shape
                            }
                        }
                    }
                }
                
                Spacer().frame(height: 20)
            }
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Step 3: Size & Fit Preferences
    private var stylePreferencesStep: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                stepHeader(
                    title: "Standard Sizes",
                    subtitle: "Your go-to sizes for smart recommendations and gap-filling picks."
                )
                
                // Top Size
                sizeSelectorSection(
                    title: "Tops / Dress Size",
                    options: ["XS", "S", "M", "L", "XL", "XXL"],
                    selected: $preferredTopSize
                )
                
                // Bottom Waist Size
                sizeSelectorSection(
                    title: "Bottoms / Waist (Inches)",
                    options: ["26", "28", "30", "32", "34", "36", "38"],
                    selected: $preferredBottomSize
                )
                
                // Shoe Size
                sizeSelectorSection(
                    title: "Footwear (UK / India Size)",
                    options: ["5", "6", "7", "8", "9", "10", "11"],
                    selected: $preferredShoeSize
                )
                
                // Summary preview card
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.champagneGold)
                        Text("Profile Ready")
                            .font(.labelLarge)
                            .foregroundColor(.obsidian)
                    }
                    
                    Text("We will configure your styling archetype based on your \(selectedBodyShape.rawValue) silhouette.")
                        .font(.bodySmall)
                        .foregroundColor(.textSecondary)
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.champagneGold.opacity(0.1))
                .cornerRadius(14)
                
                Spacer().frame(height: 20)
            }
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Bottom Action Bar
    private var bottomActionBar: some View {
        VStack(spacing: 8) {
            Button {
                if currentStep < totalSteps - 1 {
                    withAnimation {
                        currentStep += 1
                    }
                } else {
                    saveProfileAndComplete()
                }
            } label: {
                HStack(spacing: 8) {
                    Text(currentStep == totalSteps - 1 ? "Enter Atelier" : "Continue")
                        .font(.labelLarge)
                    
                    Image(systemName: currentStep == totalSteps - 1 ? "sparkles" : "arrow.right")
                        .font(.system(size: 14, weight: .bold))
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
                .shadow(color: Color.champagneGold.opacity(0.3), radius: 8, y: 4)
            }
        }
    }
    
    // MARK: - Save Profile Action
    private func saveProfileAndComplete() {
        let profileName = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Fashion Enthusiast" : name
        let userProfile = UserProfile(
            name: profileName,
            age: age,
            locality: locality.trimmingCharacters(in: .whitespacesAndNewlines),
            genderPreference: genderPreference,
            heightCm: heightCm,
            weightKg: weightKg,
            bodyShape: selectedBodyShape,
            preferredTopSize: preferredTopSize,
            preferredBottomSize: preferredBottomSize,
            preferredShoeSize: preferredShoeSize,
            profileImageData: selectedPhotoData
        )
        
        modelContext.insert(userProfile)
        try? modelContext.save()
        
        withAnimation(.easeInOut(duration: 0.4)) {
            hasCompletedOnboarding = true
        }
    }
    
    // MARK: - Helper Views & Components
    
    private func stepHeader(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 26, weight: .bold, design: .serif))
                .foregroundColor(.obsidian)
            
            Text(subtitle)
                .font(.bodyMedium)
                .foregroundColor(.textSecondary)
        }
        .padding(.top, 8)
    }
    
    private func featureRow(icon: String, title: String, subtitle: String) -> some View {
        HStack(alignment: .top, spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.peacockBlue)
                .frame(width: 32, height: 32)
                .background(Color.peacockBlue.opacity(0.1))
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.labelLarge)
                    .foregroundColor(.obsidian)
                Text(subtitle)
                    .font(.bodySmall)
                    .foregroundColor(.textSecondary)
            }
        }
    }
    
    private func customTextField(title: String, placeholder: String, text: Binding<String>, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.labelMedium)
                .foregroundColor(.obsidian)
            
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(.textTertiary)
                
                TextField(placeholder, text: text)
                    .font(.bodyMedium)
                    .foregroundColor(.obsidian)
            }
            .padding(14)
            .background(Color.cardSurface)
            .cornerRadius(12)
            .shadow(color: .cardShadow, radius: 4, y: 2)
        }
    }
    
    private func selectionChip(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.labelSmall)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.peacockBlue : Color.cardSurface)
                .foregroundColor(isSelected ? .white : .obsidian)
                .cornerRadius(10)
                .shadow(color: .cardShadow, radius: 3, y: 1)
        }
    }
    
    private func bodyShapeCard(shape: BodyShape, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: shape.icon)
                    .font(.system(size: 20))
                    .foregroundColor(isSelected ? .champagneGold : .textSecondary)
                    .frame(width: 36, height: 36)
                    .background(isSelected ? Color.champagneGold.opacity(0.15) : Color.inputBackground)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(shape.rawValue)
                        .font(.labelLarge)
                        .foregroundColor(.obsidian)
                    
                    Text(shape.description)
                        .font(.captionText)
                        .foregroundColor(.textSecondary)
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.champagneGold)
                }
            }
            .padding(14)
            .background(Color.cardSurface)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(isSelected ? Color.champagneGold : Color.clear, lineWidth: 2)
            )
            .cornerRadius(14)
            .shadow(color: .cardShadow, radius: 4, y: 2)
        }
        .buttonStyle(.plain)
    }
    
    private func sizeSelectorSection(title: String, options: [String], selected: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.labelMedium)
                .foregroundColor(.obsidian)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(options, id: \.self) { option in
                        Button {
                            selected.wrappedValue = option
                        } label: {
                            Text(option)
                                .font(.labelMedium)
                                .frame(minWidth: 46, minHeight: 44)
                                .background(selected.wrappedValue == option ? Color.champagneGold : Color.cardSurface)
                                .foregroundColor(selected.wrappedValue == option ? .white : .obsidian)
                                .cornerRadius(10)
                                .shadow(color: .cardShadow, radius: 3, y: 1)
                        }
                    }
                }
                .padding(.horizontal, 2)
                .padding(.vertical, 2)
            }
        }
    }
    
    private func heightInFeetInches(cm: Double) -> String {
        let totalInches = cm / 2.54
        let feet = Int(totalInches / 12)
        let inches = Int(totalInches.truncatingRemainder(dividingBy: 12))
        return "\(feet)'\(inches)\""
    }
}

#Preview {
    OnboardingContainerView()
}
