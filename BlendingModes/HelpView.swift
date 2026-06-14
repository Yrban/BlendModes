import SwiftUI

struct HelpView: View {
    @Environment(\.openURL) private var openURL

    var body: some View {
        List {
            Section {
                Text(helpText)
                    .fixedSize(horizontal: false, vertical: true)
                Button("github.com/Yrban/BlendingModes") {
                    if let url = URL(string: "https://github.com/Yrban/BlendingModes") {
                        openURL(url)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Help")
    }

    private let helpText = """
    Blend Modes is an application to help iOS and macOS developers using SwiftUI explore blend modes with or without compositing, color inverts, blurs, and opacity changes.

    Understanding .blendMode() and what it looks like on screen is not intuitive. You will find colors interacting in unexpected ways. A complete explanation is provided for each blend mode.

    Select a blend mode from the list to see a live preview. Tap the info (ⓘ) button on any mode's detail view for a full written description.

    Controls available in each blend mode's detail view:
    • Color Invert — inverts all colors so each displays as its complementary color (blue → yellow, white → black).
    • Compositing Mode — isolates the circles from the background, so blend and opacity effects apply before compositing with the background.
    • Opacity — adjusts the overall transparency of the layer group.
    • Blur — applies a Gaussian blur to the layer group.
    • Colors — add up to 5 colored circles. Swipe a row left to delete it.
    • Background — choose the background color shown behind the layers.
    """
}

#Preview {
    NavigationStack {
        HelpView()
    }
}
