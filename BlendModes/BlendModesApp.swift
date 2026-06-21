import SwiftUI

@main
struct BlendModesApp: App {
    @State private var blendModel = BlendModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(blendModel)
        }
        .defaultSize(width: 1100, height: 740)
    }
}
