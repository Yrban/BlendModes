import SwiftUI

struct InformationView: View {
    @Environment(BlendModel.self) private var blendModel
    @Environment(\.openURL) private var openURL

    var body: some View {
        #if os(macOS)
        contentList
        #else
        contentList
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .glow(with: blendModel.layers.last(where: { $0.type == .background })?.color ?? .gray)
        #endif
    }

    private var contentList: some View {
        List {
            Section("About") {
                Text(aboutText)
                    .fixedSize(horizontal: false, vertical: true)
                
                NavigationLink {
                    InstructionsView()
                } label: {
                    HStack {
                        Label("How to Use", systemImage: "book.pages.fill")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical)
                
                Button {
                    if let url = URL(string: "https://github.com/Yrban/BlendModes") {
                        openURL(url)
                    }
                } label: {
                    Label("View Source Code on GitHub", systemImage: "chevron.left.forwardslash.chevron.right")
                }
            }
            .listRowSeparator(.hidden)

            ForEach(BlendModeFamily.allCases, id: \.self) { family in
                Section(family.rawValue) {
                    ForEach(BlendMode.allCases.filter { $0.family == family }, id: \.anchor) { blendMode in
                        BlendModeDisclosureRow(name: blendMode.description,
                                              description: blendMode.longDescription)
                    }
                }
            }

            Section("Additional Modifiers") {
                BlendModeDisclosureRow(name: ".colorInvert()", description: colorInvertDescription)
                BlendModeDisclosureRow(name: ".compositingGroup()", description: compositingDescription)
            }

            Section("Legal") {
                #if os(macOS)
                Button {
                    if let url = URL(string: "https://www.alelinapps.com/eula-blend-modes/") {
                        openURL(url)
                    }
                } label: {
                    Label("EULA", systemImage: "doc.text")
                }
                Button {
                    if let url = URL(string: "https://www.alelinapps.com/privacy-policy/") {
                        openURL(url)
                    }
                } label: {
                    Label("Privacy Policy", systemImage: "hand.raised")
                }
                #else
                NavigationLink("EULA") { EULAView() }
                NavigationLink("Privacy Policy") { PrivacyPolicyView() }
                #endif
            }
        }
        .navigationTitle("Information")
    }

    private let aboutText = """
    Blend Modes helps SwiftUI developers explore blend modes, compositing, color inversion, and opacity. Seeing how .blendMode() behaves on screen is not always intuitive — colors interact in unexpected ways.

    Add any combination of Color Circle, Image, and Text layers. Drag layers on the canvas to reposition them.
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
