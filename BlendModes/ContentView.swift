import SwiftUI

struct ContentView: View {
    @Environment(BlendModel.self) private var blendModel

    var body: some View {
        NavigationSplitView {
            LayerListView()
                .navigationSplitViewColumnWidth(min: 300, ideal: 360)
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
