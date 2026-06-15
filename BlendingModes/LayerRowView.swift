import SwiftUI

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
                    // Blend mode picker
                    Menu {
                        ForEach(BlendMode.allCases, id: \.self) { mode in
                            Button(mode.description) { layer.blendMode = mode }
                        }
                    } label: {
                        HStack {
                            Text("Blend Mode")
                                .foregroundStyle(.primary)
                            Spacer()
                            Text(layer.blendMode.description)
                                .foregroundStyle(.secondary)
                            Image(systemName: "chevron.up.chevron.down")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
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
                    SliderView(value: $layer.blur, title: "Blur")

                    Toggle("Color Invert", isOn: $layer.colorInvert)
                        .accessibilityLabel("color invert")
                        .accessibilityValue(layer.colorInvert ? "is on" : "is off")
                        .accessibilityRemoveTraits(.isButton)
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
                                TextField("Text to blend", text: $layer.text)
                                    .font(.headline)
                                    .foregroundStyle(layer.textColor)
                                    .submitLabel(.done)
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

                    Spacer() // pushes the DisclosureGroup chevron to the far right
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
