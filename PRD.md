# Closetry — Product Requirements Document (Phase 1)

> **Digital Wardrobe & Outfit Suggestion App**
> A native iOS app where users build a digital wardrobe, get occasion-based outfit suggestions, and discover products to fill wardrobe gaps — wrapped in a premium editorial aesthetic with subtle Indian-inspired design accents.

---

## 1. Overview

| Field | Detail |
|---|---|
| **App Name** | Closetry |
| **Platform** | iOS (iPhone only, portrait) |
| **Target** | iOS 17+ minimum; developed/tested against iOS 26 |
| **Language** | Swift + SwiftUI |
| **Persistence** | SwiftData (wardrobe items, outfits), UserDefaults (flags like "onboarding complete") |
| **Backend** | None in Phase 1 — everything local/mock |
| **Auth** | None in Phase 1 (planned for Phase 2) |
| **Localization** | English only in Phase 1 |
| **Dark Mode** | Light mode only (matches editorial ivory/alabaster aesthetic) |
| **Scope** | Polished v1 — feature-complete with premium design |
| **Project Type** | Client project (B2C, general consumers) |

---

## 2. Core Value Proposition

**"I'm going out — what should I wear?"**

Closetry answers that question by:
1. Letting users photograph and tag their real wardrobe
2. Suggesting complete outfits based on the occasion (via a free-text prompt)
3. Identifying gaps in the wardrobe and recommending products to fill them (with real Amazon redirect links)

---

## 3. Design System

### 3.1 Base Aesthetic — Editorial High-Fashion

| Token | Value | Usage |
|---|---|---|
| **Background** | `#FBF9F5` (warm alabaster/ivory) | Primary surface |
| **Text Primary** | `#121110` (deep obsidian) | Headlines, body |
| **Accent Primary** | `#D4AF37` (gold/champagne) | CTAs, highlights, premium touches |
| **Card Surface** | `#FFFFFF` with subtle shadow | Item cards, outfit cards |
| **Typography** | SF Pro (system) | All UI text |
| **Logo Font** | Distinctive serif / stylized wordmark | Splash screen only |

### 3.2 Indian-Inspired Accent Layer (Applied Sparingly)

| Element | Usage |
|---|---|
| **Peacock Blue** (accent) | Secondary accent color for interactive elements |
| **Maroon / Gulal Red** (accent) | Tertiary accent, badges, alerts |
| **Muted Saffron** (accent) | Warm highlights, occasion tags |
| **Jaali (lattice) pattern** | Light background texture on Profile screen & splash |
| **Paisley motif** | Small corner accents on outfit/item cards |
| **Warli-style line-art** | Empty state illustrations ("no items yet", "no outfits") |
| **Mehrab-style (arch) containers** | Optional arch-shaped headers/modals — nod to Indian architecture |

### 3.3 Color Palette for Item Tagging

Extended palette with Indian-inspired additions (single-select per item):

| Row | Colors |
|---|---|
| **Neutrals** | Black, White, Beige, Grey, Ivory |
| **Core** | Navy, Red, Blue, Green, Pink, Yellow, Brown |
| **Indian-inspired** | Maroon, Saffron, Peacock Blue, Olive, Rust, Teal |
| **Metallic** | Gold, Silver |
| **Mixed** | Multicolor |

---

## 4. Information Architecture

### 4.1 Navigation

**Pattern:** `TabView` with 5 tabs, each wrapping its own `NavigationStack`

```
┌──────────────────────────────────────────┐
│                Tab Bar                    │
├──────────┬────────┬────────┬──────┬──────┤
│  Home    │Wardrobe│ Add +  │ Shop │Profile│
│ (Today)  │(Closet)│ (Item) │(Gap) │      │
└──────────┴────────┴────────┴──────┴──────┘
```

> **Note:** User selected `NavigationStack` as preferred navigation pattern, but the 5-tab layout naturally calls for `TabView` with `NavigationStack` per tab. The TabView is the container; each tab uses `NavigationStack` internally for drill-down flows.

### 4.2 Screen Map

#### Onboarding (4 sequential screens — shown once)

| Step | Screen | Content |
|---|---|---|
| 0 | **Hero / Splash** | Logo, app name "Closetry", tagline, jaali/paisley background animation |
| 1 | **Personal Details** | Name, Locality (text fields) |
| 2 | **Body Details** | Height (picker), Weight (picker), Body Shape (chip selector: Hourglass / Pear / Apple / Rectangle / Inverted Triangle), Size preferences |
| 3 | **Add Your Wardrobe** | Upload first items via camera/photo library, or skip. Live preview grid of added items |

#### Main App (5 Tabs — after onboarding)

**Tab 1: Home / Today** (Default landing tab)
- "Welcome back, [Name]" greeting
- Prompt: "What's the occasion today?" — free-text input box
- Quick actions: Add Item, Browse Wardrobe
- (Future: last outfit worn, closet stats, seasonal prompts)

**Tab 2: Wardrobe (Closet)**
- Grid view of all wardrobe items (photo thumbnails)
- Filter bar: Category, Color, Occasion
- Tap item → Item Detail View (full photo, tags, edit/delete)
- Empty state: Warli-style illustration + "Add your first item" CTA

**Tab 3: Add Item** (Center tab, prominent)
- Camera / Photo Library picker (PHPickerViewController via SwiftUI)
- Tagging flow:
  - Category (single-select, 6 options — required)
  - Subcategory (single-select, dependent on category — required)
  - Color (single-select from extended palette — required)
  - Occasion (multi-select from 6 presets — required)
  - Season (optional, multi-select — captured now for future use)
- Save confirmation → item appears in Wardrobe

**Tab 4: Shop / Fill the Gap**
- Triggered contextually from Stylist results when a gap is detected
- Also browsable standalone: list of suggested products
- Product card: image, name, price (mock), retailer name
- "Buy" button → opens Amazon search URL in Safari

**Tab 5: Profile**
- Body details (editable): height, weight, body shape
- Styling archetype summary + tips (e.g., "Hourglass" — static text in Phase 1)
- Size preferences
- Jaali pattern background texture

---

## 5. Wardrobe Data Model

### 5.1 Item Taxonomy

**Level 1 — Category** (required, single-select, 6 fixed options):

| Category | Subcategories (Level 2) |
|---|---|
| **Tops** | Blouse, T-shirt, Shirt, Sweater/Knit, Blazer, Camisole |
| **Bottoms** | Jeans, Trousers, Skirt, Shorts, Leggings |
| **Dresses** | Casual Dress, Cocktail Dress, Maxi Dress, Wrap Dress |
| **Footwear** | Heels, Flats, Sneakers, Boots, Sandals |
| **Outerwear** | Coat, Jacket, Blazer, Cardigan |
| **Accessories** | Bag, Jewelry, Scarf, Sunglasses, Belt |

**Tags** (flat, multi-select where applicable):
- Color: single-select from extended palette (§3.3)
- Occasion: multi-select from 6 presets (Party, Work, Casual, Date, Wedding, Brunch)
- Season: optional, multi-select (Spring, Summer, Fall, Winter) — not used by engine in Phase 1

### 5.2 SwiftData Model

```swift
@Model
class WardrobeItem {
    var id: UUID
    var photoFileName: String       // reference to full-res image in app sandbox
    var category: ItemCategory       // enum: tops, bottoms, dresses, footwear, outerwear, accessories
    var subcategory: String          // dependent on category
    var color: ItemColor             // enum from extended palette
    var occasions: [Occasion]        // multi-select enum
    var seasons: [Season]            // optional, multi-select
    var dateAdded: Date
    var isFavorite: Bool
}
```

### 5.3 Photo Storage

- **Full resolution** — original photos stored in the app sandbox
- No compression in Phase 1
- Photos referenced by `photoFileName` in the SwiftData model
- Storage managed via `ImageStorageManager` utility

---

## 6. Stylist Engine (Outfit Suggestions)

### 6.1 Input

User enters a **free-text prompt** describing their occasion (e.g., "office meeting", "Saturday brunch", "friend's wedding"). The engine maps this text to one of the 6 preset occasion tags via keyword matching.

> **Note:** No predefined occasion picker chips — the user types naturally. The engine parses intent.

### 6.2 Matching Logic (Rule-Based, No ML)

**Step 1: Occasion Filtering**
- Parse the free-text prompt for occasion keywords
- Pull only items tagged for the matched occasion

**Step 2: Category Completion Rules**
A valid outfit must be one of:
- `Top + Bottom + Footwear` (+ optional Accessory/Outerwear)
- `Dress + Footwear` (+ optional Accessory/Outerwear)

**Step 3: Color Pairing Rules**
Fixed rule set (not full color theory):

| Rule | Example |
|---|---|
| Neutral base + one accent | Black bottom + colored top |
| Monochrome | Same color family, different shades |
| Tonal/earth-tone grouping | Browns, olives, rust together |
| Classic contrast pairs | Black + white, navy + white, black + gold |

Items outside these rules get a **lower score** (not excluded) — keeps the engine flexible.

**Step 4: Match Score**
Weighted formula displayed as a badge (e.g., "92% match"):

| Factor | Weight |
|---|---|
| Occasion tag overlap | 50% |
| Color rule match | 35% |
| Accessory/outerwear completion bonus | 15% |

**Step 5: Gap Detection**
If no complete outfit can be assembled:
- Identify which category slot is missing
- Trigger "Fill the Gap" with that category as the search criterion

### 6.3 Explicitly Out of Scope (Phase 1)

- ❌ Body-type-aware fit logic (save for Phase 3 with ML)
- ❌ Weather/season awareness
- ❌ Learning from past outfit choices
- ❌ Pattern/print clash detection (florals vs. stripes)

---

## 7. Fill the Gap / Shop

### 7.1 Mock Product Catalog

~10–12 curated mock products spread across all categories so every likely gap has something to show.

```swift
struct MockProduct {
    let id: UUID
    let name: String                // "Strappy Metallic Heels"
    let category: ItemCategory       // must match the missing category
    let subcategory: String
    let color: ItemColor
    let occasions: [Occasion]
    let price: Double               // mock, illustrative
    let retailer: String            // "Amazon Fashion"
    let imageAsset: String          // bundled asset name
    let buyURL: URL                 // pre-built Amazon search URL
}
```

### 7.2 Matching Logic

When the Stylist engine detects a gap:

```
findGapFillers(
    missingCategory: .bottoms,
    occasion: .party,
    colorContext: [existing item colors in the outfit]
)
```

Filters:
1. **Category match** — hard filter (must match missing slot)
2. **Occasion tag overlap** — hard filter (must include the occasion)
3. **Color compatibility** — soft filter/sort (prefer colors that match pairing rules)

Returns top 1–3 matches, ranked by outfit completion score.

### 7.3 Fallback

- If no strong match: relax to category-only and show "You might also like"
- **Never show an empty Shop screen** — always surface something

### 7.4 Buy Redirect

Real, functional Amazon search URLs:
```
https://www.amazon.com/s?k=strappy+metallic+heels
```
Not using Amazon Product API — just search redirect. Honest, working MVP.

---

## 8. User Profile & Body Shape

### 8.1 Body Shape Archetypes

5 classic types (single-select chip selector):

| Shape | Description (shown as styling tip) |
|---|---|
| **Hourglass** | Balanced bust and hips, defined waist |
| **Pear** | Hips wider than shoulders, defined waist |
| **Apple** | Fuller midsection, broader shoulders |
| **Rectangle** | Balanced proportions, less defined waist |
| **Inverted Triangle** | Shoulders wider than hips |

### 8.2 Styling Archetype

- Static text tips displayed on Profile screen per body shape
- **Not wired into the Stylist engine** in Phase 1 — purely informational
- Example: "Hourglass — Emphasize your waist with fitted silhouettes and wrap styles"

---

## 9. Technical Architecture

### 9.1 Project Structure

```
Closetry/
├── ClosetryApp.swift                    # App entry point
├── ContentView.swift                    # Root view (onboarding vs. main tab)
│
├── Models/
│   ├── WardrobeItem.swift              # SwiftData @Model
│   ├── UserProfile.swift               # SwiftData @Model
│   ├── MockProduct.swift               # Struct for gap-fill products
│   ├── Enums/
│   │   ├── ItemCategory.swift          # Tops, Bottoms, Dresses, etc.
│   │   ├── ItemColor.swift             # Extended palette enum
│   │   ├── Occasion.swift              # Party, Work, Casual, etc.
│   │   ├── Season.swift                # Spring, Summer, Fall, Winter
│   │   └── BodyShape.swift             # 5 archetypes
│
├── Views/
│   ├── Onboarding/
│   │   ├── OnboardingContainerView.swift
│   │   ├── SplashView.swift
│   │   ├── PersonalDetailsView.swift
│   │   ├── BodyDetailsView.swift
│   │   └── InitialWardrobeView.swift
│   │
│   ├── MainTabView.swift               # 5-tab container
│   │
│   ├── Home/
│   │   └── HomeView.swift              # Today screen with prompt
│   │
│   ├── Wardrobe/
│   │   ├── WardrobeView.swift          # Grid + filters
│   │   ├── WardrobeItemCard.swift      # Grid cell
│   │   └── ItemDetailView.swift        # Full item view
│   │
│   ├── AddItem/
│   │   ├── AddItemView.swift           # Camera/picker + tagging flow
│   │   └── TagSelectionView.swift      # Category/color/occasion chips
│   │
│   ├── Stylist/
│   │   ├── StylistView.swift           # Occasion prompt + results
│   │   └── OutfitCardView.swift        # Outfit suggestion card
│   │
│   ├── Shop/
│   │   ├── ShopView.swift              # Gap-fill product list
│   │   └── ProductCardView.swift       # Product card
│   │
│   └── Profile/
│       └── ProfileView.swift           # Body details + archetype
│
├── Services/
│   ├── ImageStorageManager.swift       # Photo save/load/delete
│   ├── RecommendationEngine.swift      # Outfit matching logic
│   └── PromptParser.swift              # Free-text → occasion mapping
│
├── Theme/
│   ├── Color+Theme.swift               # Design system colors
│   ├── Font+Theme.swift                # Typography tokens
│   └── DecorationComponents.swift      # Jaali, paisley, Warli, mehrab
│
├── Data/
│   ├── MockWardrobe.swift              # Seed data for development
│   └── MockProducts.swift              # 10-12 curated gap-fill products
│
├── Assets.xcassets/                    # App icon, mock product images
└── Preview Content/
    └── Preview Assets.xcassets
```

### 9.2 Key Dependencies

- **None** — pure SwiftUI + SwiftData, no third-party packages in Phase 1
- Camera/Photos: `PhotosUI` framework (built-in `PHPickerViewController`)
- External links: `openURL` environment action for Amazon redirects

---

## 10. Build Order (Milestone-Based)

| Milestone | Scope | Testable Outcome |
|---|---|---|
| **M0: Skeleton** | Project setup, theme system (`Color+Theme`, `Font+Theme`), empty `TabView` shell with all tabs stubbed | Runs and installs on iPhone — proves signing & environment work |
| **M1: Wardrobe (read-only)** | Models, mock data seed, Wardrobe tab (grid + filters + item detail) | Browse a fake closet — validates visual design early |
| **M2: Wardrobe (write)** | Camera/photo picker, `ImageStorageManager`, Add Item flow with tagging, SwiftData persistence | Photograph real clothes and see them saved |
| **M3: Stylist Engine** | `RecommendationEngine`, `PromptParser`, occasion prompt + outfit cards | Core value prop works — pick occasion, get outfit suggestions |
| **M4: Fill the Gap / Shop** | `MockProducts`, gap detection, product cards, Amazon redirect | Full loop: occasion → outfit → gap → buy redirect |
| **M5: Onboarding + Profile + Home** | 4-step onboarding, Profile (body details, archetype), Home/Today screen | Complete first-run experience |
| **M6: Design Polish** | Jaali/paisley/Warli decorations applied across all screens, empty states, loading states, transitions | Visually complete, premium feel |

---

## 11. Future Phases (Not in Scope)

| Phase | Features |
|---|---|
| **Phase 2** | Real backend, user accounts, cloud sync |
| **Phase 3** | Auto-tagging via image recognition, ML-based recommendations, real retailer API |
| **Phase 4** | Push notifications, affiliate tracking, social sharing, App Store / TestFlight release |

---

## 12. Success Criteria (Phase 1)

- [ ] User can complete onboarding and set up profile
- [ ] User can photograph clothing and tag it (category, subcategory, color, occasion)
- [ ] Wardrobe grid displays all items with working filters
- [ ] Free-text occasion prompt returns scored outfit suggestions
- [ ] Gap detection identifies missing pieces and shows product recommendations
- [ ] "Buy" button opens correct Amazon search URL in Safari
- [ ] Indian-inspired design accents are visible and tasteful (not overdone)
- [ ] App runs smoothly on a physical iPhone
- [ ] All data persists across app launches (SwiftData)
