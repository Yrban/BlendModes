import SwiftUI

struct ContentView: View {
    @Environment(BlendModel.self) private var blendModel
    @Environment(\.openWindow) private var openWindow

    var body: some View {
        HSplitView {
            LayerListView()
                .frame(minWidth: 300, idealWidth: 360, maxWidth: 500)
            BlendGroupView()
                .frame(minWidth: 400)
                .ignoresSafeArea()
        }
        .onReceive(NotificationCenter.default.publisher(for: .showBlendModesHelp)) { _ in
            openWindow(id: "blend-modes-help")
        }
    }
}

#Preview {
    ContentView()
        .environment(BlendModel())
}
