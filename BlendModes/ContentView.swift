import SwiftUI

struct ContentView: View {
    @Environment(BlendModel.self) private var blendModel

    var body: some View {
        NavigationSplitView {
            LayerListView()
        } detail: {
            BlendGroupView()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
        .environment(BlendModel())
}
