import SwiftUI

struct ContentView: View {
    @Environment(BlendModel.self) private var blendModel
    @Environment(\.horizontalSizeClass) private var sizeClass
    @State private var columnVisibility: NavigationSplitViewVisibility = .detailOnly
    @State private var selectedDetent: PresentationDetent = .height(40)
    @State private var isCodeVisible: Bool = false

    var body: some View {
        if sizeClass == .compact {
            NavigationStack {
                BlendGroupView()
                    .sheet(isPresented: .constant(true)) {
                        LayerListView(isCodeSectionVisible: isCodeVisible)
                            .presentationDetents([.height(40), .medium, .large], selection: $selectedDetent)
                            .onChange(of: selectedDetent) { _, newDetent in
                                if newDetent == .height(40) {
                                    isCodeVisible = false
                                } else {
                                    Task {
                                        try? await Task
                                            .sleep(for: .seconds(0.1))
                                        if [.medium, .large].contains(newDetent) {
                                            isCodeVisible = true
                                        }
                                    }
                                }
                            }
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
            }
            
        }
    }
}

#Preview {
    ContentView()
        .environment(BlendModel())
}
