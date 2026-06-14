import SwiftUI

struct InformationView: View {
    @Environment(BlendModel.self) private var blendModel
    var mode: BlendMode = .color

    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(BlendMode.allCases, id: \.anchor) { blendMode in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(blendMode.description)
                            .font(.headline)
                            .accessibilityHidden(true)
                        Text(blendMode.longDescription)
                            .id(blendMode.anchor)
                    }
                    .onAppear {
                        proxy.scrollTo(mode.anchor, anchor: .top)
                    }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(".colorInvert()")
                        .font(.headline)
                        .accessibilityHidden(true)
                    Text(colorInvertDescription)
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(".compositingGroup()")
                        .font(.headline)
                        .accessibilityHidden(true)
                    Text(compositingDescription)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .glow(with: blendModel.background)
            .navigationTitle("Blend Mode Info")
        }
    }

    private let colorInvertDescription = """
    The colorInvert() modifier inverts all of the colors in a view so that each color displays as its complementary color. For example, blue converts to yellow, and white converts to black.
    """

    private let compositingDescription = """
    A compositing group makes compositing effects in this view's ancestor views, such as opacity and the blend mode, take effect before this view is rendered.
    Use compositingGroup() to apply effects to a parent view before applying effects to this view. In Blend Modes, the circles are all in the compositing group, and the background is not. This allows you to isolate the circles from the background, or not, to further explore the different blend modes.
    """
}

#Preview {
    NavigationStack {
        InformationView(mode: .multiply)
            .environment(BlendModel())
    }
}
