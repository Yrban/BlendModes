import SwiftUI

struct InformationView: View {
    @Environment(BlendModel.self) private var blendModel
    @Environment(\.openURL) private var openURL

    var body: some View {
        List {
            Section("About") {
                Text(aboutText)
                    .fixedSize(horizontal: false, vertical: true)
                NavigationLink("How to Use") { InstructionsView() }
                Button("github.com/Yrban/BlendModes") {
                    if let url = URL(string: "https://github.com/Yrban/BlendModes") {
                        openURL(url)
                    }
                }
            }

            Section("Blend Modes") {
                ForEach(BlendMode.allCases, id: \.anchor) { blendMode in
                    BlendModeDisclosureRow(name: blendMode.description,
                                          description: blendMode.longDescription)
                }
                BlendModeDisclosureRow(name: ".colorInvert()", description: colorInvertDescription)
                BlendModeDisclosureRow(name: ".compositingGroup()", description: compositingDescription)
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

    private let aboutText = """
    Blend Modes helps SwiftUI developers explore blend modes, compositing, color inversion, and opacity. Seeing how .blendMode() behaves on screen is not always intuitive — colors interact in unexpected ways.

    Add any combination of Color Circle, Image, and Text layers. Drag layers on the canvas to reposition them. Swipe left on a layer row to delete it.
    """

    private let colorInvertDescription = """
    The colorInvert() modifier inverts all of the colors in a view so that each color displays as its complementary color. For example, blue converts to yellow, and white converts to black.
    """

    private let compositingDescription = """
    By default, each layer's blend mode interacts with everything beneath it — including layers outside any logical group. .compositingGroup() changes this scope.

    Layers inside a compositing group first blend together among themselves, producing a single flattened image. Only that combined result then interacts with the layers below.

    This matters when you want to isolate blending. For example: two layers using .multiply inside a group will multiply against each other first. The merged output then blends against the canvas. Without the group, each layer would multiply independently against every layer below it — which produces a visually different (and often unintended) result.

    Opacity works the same way: applying .opacity() to a compositing group fades the whole group as a unit, rather than making each layer individually semi-transparent and letting them bleed through each other.
    """
}

private struct BlendModeDisclosureRow: View {
    let name: String
    let description: String
    @State private var isExpanded = false

    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            Text(description)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical, 4)
        } label: {
            Text(name)
                .font(.headline)
        }
    }
}

#Preview {
    NavigationStack {
        InformationView()
            .environment(BlendModel())
    }
}
