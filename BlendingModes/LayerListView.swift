import SwiftUI

struct LayerListView: View {
    @Environment(BlendModel.self) private var blendModel
    @State private var showInfo = false

    var body: some View {
        @Bindable var model = blendModel

        VStack(spacing: 0) {
            // Pinned header — always visible at top regardless of detent or scroll position
            HStack(spacing: 12) {
                Text("Layers")
                    .font(.headline)
                Spacer()
                EditButton()
                    .font(.callout)
                Menu {
                    ForEach(availableTypes, id: \.self) { type in
                        Button { insertLayer(type: type) } label: {
                            Label(type.rawValue, systemImage: type.systemImage)
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
                        // Ensure background layer stays last after any move
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

                Section("Generated Code") {
                    CodeGeneratorView()
                }
            }
            .listStyle(.insetGrouped)
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
            .environment(blendModel)
        }
    }

    private var availableTypes: [DemoMode] {
        let hasBG = blendModel.layers.contains { $0.type == .background }
        // Only non-CG and non-background layers count toward the CG minimum
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
            // Always insert at end (only reachable when no background layer exists)
            var bg = Layer(type: .background)
            bg.color = .gray
            blendModel.layers.append(bg)
        case .compositingGroup:
            // Must land after the first 2 non-CG, non-background layers
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

#Preview {
    LayerListView()
        .environment(BlendModel())
}
