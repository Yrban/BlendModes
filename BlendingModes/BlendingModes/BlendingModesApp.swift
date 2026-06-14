import SwiftUI

@main
struct BlendingModesApp: App {
    @State private var blendModel = BlendModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(blendModel)
        }
    }
}
