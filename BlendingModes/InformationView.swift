import SwiftUI

struct InformationView: View {
    @Environment(BlendModel.self) private var blendModel
    @Environment(\.openURL) private var openURL
    var mode: BlendMode = .color

    var body: some View {
        ScrollViewReader { proxy in
            List {
                Section("About") {
                    Text(aboutText)
                        .fixedSize(horizontal: false, vertical: true)
                    Button("github.com/Yrban/BlendingModes") {
                        if let url = URL(string: "https://github.com/Yrban/BlendingModes") {
                            openURL(url)
                        }
                    }
                }

                Section("Blend Modes") {
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

                Section("Legal") {
                    NavigationLink("EULA") { EULAView() }
                    NavigationLink("Privacy Policy") { PrivacyPolicyView() }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .glow(with: blendModel.layers.last(where: { $0.type == .background })?.color ?? .gray)
            .navigationTitle("Information")
        }
    }

    private let aboutText = """
    Blend Modes helps SwiftUI developers explore blend modes, compositing, color inversion, blur, and opacity. Seeing how .blendMode() behaves on screen is not always intuitive — colors interact in unexpected ways.

    Add any combination of Color Circle, Image, and Text layers. Drag layers on the canvas to reposition them. Swipe left on a layer row to delete it.
    """

    private let colorInvertDescription = """
    The colorInvert() modifier inverts all of the colors in a view so that each color displays as its complementary color. For example, blue converts to yellow, and white converts to black.
    """

    private let compositingDescription = """
    A compositing group makes compositing effects in this view's ancestor views, such as opacity and the blend mode, take effect before this view is rendered. Use compositingGroup() to apply effects to a parent view before applying effects to this view.
    """
}

#Preview {
    NavigationStack {
        InformationView(mode: .multiply)
            .environment(BlendModel())
    }
}
