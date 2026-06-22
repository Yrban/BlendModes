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
        .commands {
            CommandGroup(replacing: .help) {
                Button("Blend Modes Help") {
                    NotificationCenter.default.post(name: .showBlendModesHelp, object: nil)
                }
                .keyboardShortcut("?", modifiers: .command)
            }
        }

        Window("Blend Modes Help", id: "blend-modes-help") {
            NavigationStack {
                InformationView()
            }
            .environment(blendModel)
        }
        .defaultSize(width: 520, height: 640)
    }
}

extension Notification.Name {
    static let showBlendModesHelp = Notification.Name("showBlendModesHelp")
}
