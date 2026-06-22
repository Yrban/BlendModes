import SwiftUI

struct LayerListView: View {
    var isCodeSectionVisible: Bool = true
    @Environment(BlendModel.self) private var blendModel
    @State private var showInfo = false

    var body: some View {
        @Bindable var model = blendModel

        VStack(spacing: 0) {
            // Pinned header
            HStack(spacing: 12) {
                Text("Layers")
                    .font(.headline)
                Spacer()
                #if os(iOS)
                EditButton()
                    .font(.callout)
                #endif
                Button {
                    for i in blendModel.layers.indices {
                        blendModel.layers[i].xOffset = 0
                        blendModel.layers[i].yOffset = 0
                    }
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.title3)
                }
                Menu {
                    Section("Add Layer") {
                        ForEach(availableTypes, id: \.self) { type in
                            Button { insertLayer(type: type) } label: {
                                Label(type.rawValue, systemImage: type.systemImage)
                            }
                        }
                    }
                    Section("Presets") {
                        ForEach(Preset.allCases, id: \.self) { preset in
                            Button { blendModel.layers = preset.layers } label: {
                                Label(preset.rawValue, systemImage: preset.systemImage)
                            }
                        }
                    }
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                }
                Button { showInfo = true } label: {
                    Image(systemName: "info.circle")
                        .font(.title3)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)

            Divider()

            List {
                Section {
                    ForEach($model.layers) { $layer in
                        let layerId = $layer.wrappedValue.id
                        LayerRowView(layer: $layer)
                            .moveDisabled($layer.wrappedValue.type == .background)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    blendModel.layers.removeAll { $0.id == layerId }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                    .onMove { from, to in
                        withAnimation { model.layers.move(fromOffsets: from, toOffset: to) }
                        if let bgIdx = model.layers.firstIndex(where: { $0.type == .background }),
                           bgIdx != model.layers.count - 1 {
                            let bg = model.layers.remove(at: bgIdx)
                            model.layers.append(bg)
                        }
                    }
                    .onDelete { offsets in
                        model.layers.remove(atOffsets: offsets)
                    }
                }
            }
            #if os(iOS)
            .listStyle(.insetGrouped)
            #else
            .listStyle(.sidebar)
            #endif

            if isCodeSectionVisible {
                Divider()

                VStack(alignment: .leading, spacing: 6) {
                    Text("Generated Code")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    CodeGeneratorView()
                        .padding(.horizontal, 16)
                        .padding(.bottom, 12)
                }
            }
        }
        .sheet(isPresented: $showInfo) {
            NavigationStack {
                InformationView()
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") { showInfo = false }
                        }
                    }
            }
            #if os(iOS)
            .presentationDetents([.large])
            #elseif os(macOS)
            .frame(minWidth: 500, minHeight: 600)
            #endif
            .environment(blendModel)
        }
    }

    private var availableTypes: [DemoMode] {
        let hasBG = blendModel.layers.contains { $0.type == .background }
        let contentCount = blendModel.layers.filter { $0.type != .compositingGroup && $0.type != .background }.count
        return DemoMode.allCases.filter { type in
            switch type {
            case .background:        return !hasBG
            case .compositingGroup:  return contentCount >= 2
            default:                 return true
            }
        }
    }

    private func insertLayer(type: DemoMode) {
        switch type {
        case .background:
            var bg = Layer(type: .background)
            bg.color = .gray
            blendModel.layers.append(bg)
        case .compositingGroup:
            var seen = 0
            var insertIndex = max(0, blendModel.layers.count - (blendModel.layers.last?.type == .background ? 1 : 0))
            for (i, layer) in blendModel.layers.enumerated() {
                if layer.type != .compositingGroup && layer.type != .background {
                    seen += 1
                    if seen == 2 { insertIndex = i + 1; break }
                }
            }
            blendModel.layers.insert(Layer(type: .compositingGroup), at: insertIndex)
        default:
            blendModel.layers.insert(Layer(type: type), at: 0)
        }
    }
}

private enum Preset: String, CaseIterable {
    case multiplyOnWhite = "Multiply on White"
    case screenOnBlack   = "Screen on Black"
    case overlay         = "Overlay"
    case difference      = "Difference"

    var systemImage: String {
        switch self {
        case .multiplyOnWhite: "circle.lefthalf.filled"
        case .screenOnBlack:   "circle.righthalf.filled"
        case .overlay:         "circle.fill"
        case .difference:      "plus.circle"
        }
    }

    var layers: [Layer] {
        switch self {
        case .multiplyOnWhite:
            var c1 = Layer(type: .circles); c1.color = .blue;   c1.xOffset = -50
            var c2 = Layer(type: .circles); c2.color = .red;    c2.blendMode = .multiply; c2.xOffset = 50
            var bg = Layer(type: .background); bg.color = .white
            return [c2, c1, bg]
        case .screenOnBlack:
            var c1 = Layer(type: .circles); c1.color = .blue;   c1.xOffset = -50
            var c2 = Layer(type: .circles); c2.color = .red;    c2.blendMode = .screen;   c2.xOffset = 50
            var bg = Layer(type: .background); bg.color = .black
            return [c2, c1, bg]
        case .overlay:
            var c1 = Layer(type: .circles); c1.color = .orange; c1.xOffset = -50
            var c2 = Layer(type: .circles); c2.color = .purple; c2.blendMode = .overlay;  c2.xOffset = 50
            var bg = Layer(type: .background); bg.color = Color(white: 0.5)
            return [c2, c1, bg]
        case .difference:
            var c1 = Layer(type: .circles); c1.color = .cyan;   c1.xOffset = -50
            var c2 = Layer(type: .circles); c2.color = .yellow; c2.blendMode = .difference; c2.xOffset = 50
            var bg = Layer(type: .background); bg.color = Color(white: 0.15)
            return [c2, c1, bg]
        }
    }
}

#Preview {
    LayerListView()
        .environment(BlendModel())
}
