import SwiftUI

struct ContentView: View {
    @Environment(BlendModel.self) private var blendModel

    var body: some View {
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
}

#Preview {
    ContentView()
        .environment(BlendModel())
}
