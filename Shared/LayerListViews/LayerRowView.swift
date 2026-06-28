import SwiftUI

private let blendModeGroups: [(title: String, modes: [BlendMode])] = [
    ("Normal",      [.normal]),
    ("Darken",      [.darken, .multiply, .colorBurn, .plusDarker]),
    ("Lighten",     [.lighten, .screen, .colorDodge, .plusLighter]),
    ("Contrast",    [.overlay, .softLight, .hardLight]),
    ("Inversion",   [.difference, .exclusion]),
    ("Component",   [.hue, .saturation, .color, .luminosity]),
    ("Compositing", [.destinationOut, .destinationOver, .sourceAtop]),
]

struct LayerRowView: View {
    @Binding var layer: Layer
    @State private var isExpanded = false

    var body: some View {
        if layer.type == .background {
            HStack(spacing: 10) {
                Image(systemName: DemoMode.background.systemImage)
                    .font(.body.bold())
                    .foregroundStyle(.secondary)
                Text("Background")
                    .font(.headline)
                Spacer()
                ColorPicker("", selection: $layer.color)
                    .labelsHidden()
            }
            .padding(.vertical, 6)
        } else if layer.type == .compositingGroup {
            HStack(spacing: 10) {
                Image(systemName: layer.type.systemImage)
                    .font(.body.bold())
                    .foregroundStyle(.secondary)
                Text(layer.type.rawValue)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("composites layers above")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
            .padding(.vertical, 6)
        } else {
            DisclosureGroup(isExpanded: $isExpanded) {
                VStack(alignment: .leading, spacing: 12) {
                    // Blend mode picker — grouped by category
                    Picker("Blend Mode", selection: $layer.blendMode) {
                        ForEach(blendModeGroups, id: \.title) { group in
                            Section(group.title) {
                                ForEach(group.modes, id: \.self) { mode in
                                    Text(mode.description).tag(mode)
                                }
                            }
                        }
                    }
                    .pickerStyle(.menu)
                    .foregroundStyle(.primary)

                    Divider()

                    switch layer.type {
                    case .circles:                      ChooseColorsView(layer: $layer)
                    case .images:                       ImageLayerControlsView(layer: $layer)
                    case .text:                         TextLayerControlsView(layer: $layer)
                    case .compositingGroup, .background: EmptyView()
                    }

                    Divider()

                    SliderView(value: $layer.opacity, title: "Opacity")

                    Toggle("Color Invert", isOn: $layer.colorInvert)
                        .accessibilityLabel("color invert")
                        .accessibilityValue(layer.colorInvert ? "is on" : "is off")
                        .accessibilityRemoveTraits(.isButton)

                    if layer.xOffset != 0 || layer.yOffset != 0 {
                        Button {
                            layer.xOffset = 0
                            layer.yOffset = 0
                        } label: {
                            Label("Recenter on Canvas", systemImage: "scope")
                        }
                        .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 8)
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: layer.type.systemImage)
                        .font(.body.bold())
                        .foregroundStyle(.primary)

                    // Name on top, blend mode subtitle underneath when collapsed
                    VStack(alignment: .leading, spacing: 2) {
                        HStack(spacing: 6) {
                            switch layer.type {
                            case .circles:
                                Text(layer.type.rawValue)
                                    .font(.headline)
                                    .lineLimit(1)
                                Circle()
                                    .fill(layer.color)
                                    .frame(width: 14, height: 14)
                            case .text:
                                // Static Text here (not TextField) avoids a macOS layout constraint loop
                                Text(layer.text.isEmpty ? "Text" : layer.text)
                                    .font(.headline)
                                    .foregroundStyle(layer.textColor)
                                    .lineLimit(1)
                            case .images:
                                Text(layer.type.rawValue)
                                    .font(.headline)
                                    .lineLimit(1)
                            case .compositingGroup, .background:
                                EmptyView()
                            }
                        }

                        if !isExpanded {
                            Text(layer.blendMode.description)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var layer = Layer(type: .circles)
    List {
        LayerRowView(layer: $layer)
    }
}
