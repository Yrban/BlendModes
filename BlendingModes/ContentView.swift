import SwiftUI

struct ContentView: View {
    @Environment(BlendModel.self) private var blendModel
    @Environment(\.horizontalSizeClass) private var sizeClass
    @State private var columnVisibility: NavigationSplitViewVisibility = .detailOnly
    
    var body: some View {
        if sizeClass == .compact {
            NavigationStack {
                BlendGroupView()
                    .ignoresSafeArea()
                    .sheet(isPresented: .constant(true)) {
                        LayerListView()
                            .presentationDetents([.height(40), .medium, .large])
                            .presentationDragIndicator(.visible)
                            .presentationContentInteraction(.scrolls)
                            .presentationBackgroundInteraction(.enabled)
                            .interactiveDismissDisabled()
                            .environment(blendModel)
                    }
            }
        } else {
            NavigationSplitView(columnVisibility: $columnVisibility) {
                LayerListView()
            } detail: {
                BlendGroupView()
                    .ignoresSafeArea()
            }
            
        }
    }
}

#Preview {
    ContentView()
        .environment(BlendModel())
}
