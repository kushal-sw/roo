import SwiftUI
import SwiftData

@main
struct ClosetryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [WardrobeItem.self, UserProfile.self])
    }
}
