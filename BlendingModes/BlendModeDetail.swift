import SwiftUI

struct BlendModeDetail: View {
    @Environment(BlendModel.self) private var blendModel
    let mode: BlendMode
    @State private var showInfo = false

    var body: some View {
        @Bindable var model = blendModel

        VStack(spacing: 0) {
            BlendGroupView(mode: mode)
                .aspectRatio(1, contentMode: .fit)
                .padding()
                .layoutPriority(1)

            Form {
                // Canvas type picker
                Section {
                    Picker("Canvas", selection: $model.demoMode) {
                        ForEach(DemoMode.allCases, id: \.self) { m in
                            Label(m.rawValue, systemImage: m.systemImage).tag(m)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                // Layer controls — depend on selected canvas type
                Section(layerSectionTitle) {
                    switch blendModel.demoMode {
                    case .circles: ChooseColorsView()
                    case .images:  ImageLayerControlsView()
                    case .text:    TextLayerControlsView()
                    }
                }

                Section("Adjustments") {
                    AdjustModeView()
                }

                Section("Generated Code") {
                    CodeGeneratorView(mode: mode)
                }
            }
        }
        .glow(with: blendModel.background)
        .navigationTitle(mode.description)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showInfo = true
                } label: {
                    Image(systemName: "info.circle")
                        .accessibilityLabel("Blend mode information")
                }
            }
        }
        .sheet(isPresented: $showInfo) {
            NavigationStack {
                InformationView(mode: mode)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") { showInfo = false }
                        }
                    }
            }
            .environment(blendModel)
        }
    }

    private var layerSectionTitle: String {
        switch blendModel.demoMode {
        case .circles: "Colors"
        case .images:  "Images"
        case .text:    "Text"
        }
    }
}

#Preview {
    NavigationStack {
        BlendModeDetail(mode: .multiply)
            .environment(BlendModel(colors: [.red, .blue, .green]))
    }
}
