import SwiftUI

struct ContentView: View {
    @Environment(BlendModel.self) private var blendModel
    @State private var selectedMode: BlendMode? = .normal
    @State private var showHelp = false
    @State private var showSettings = false

    var body: some View {
        NavigationSplitView {
            List(BlendMode.allCases, id: \.self, selection: $selectedMode) { mode in
                blendModeRow(mode: mode)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel("Select blend mode \(mode.description)")
            }
            .navigationTitle("Modes")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showHelp = true
                    } label: {
                        Image(systemName: "questionmark.circle")
                            .accessibilityLabel("Help")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .accessibilityLabel("Settings")
                    }
                }
            }
        } detail: {
            NavigationStack {
                if let mode = selectedMode {
                    BlendModeDetail(mode: mode)
                } else {
                    ContentUnavailableView(
                        "Select a Blend Mode",
                        systemImage: "circle.grid.3x3",
                        description: Text("Choose a blend mode from the list to explore it.")
                    )
                }
            }
        }
        .glow(with: blendModel.background)
        .sheet(isPresented: $showHelp) {
            NavigationStack {
                HelpView()
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") { showHelp = false }
                        }
                    }
            }
        }
        .sheet(isPresented: $showSettings) {
            NavigationStack {
                SettingsView()
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") { showSettings = false }
                        }
                    }
            }
            .environment(blendModel)
        }
    }

    private func blendModeRow(mode: BlendMode) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                blendModeLabel(mode: mode)
                backgroundLabel
            }
            Spacer()
            BlendGroupView(mode: mode)
                .frame(width: 75, height: 75)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.leading)
        }
    }

    private func blendModeLabel(mode: BlendMode) -> some View {
        VStack {
            HStack {
                Text("Blend Mode:")
                Spacer()
            }
            HStack {
                Spacer()
                Text(mode.description)
            }
        }
    }

    private var backgroundLabel: some View {
        VStack {
            HStack {
                Text("Background:")
                Spacer()
            }
            HStack {
                Spacer()
                Text(backgroundColorName)
            }
        }
    }

    private var backgroundColorName: String {
        #if canImport(UIKit)
        return UIColor(blendModel.background).accessibilityName
        #else
        return blendModel.background.description
        #endif
    }
}

#Preview {
    ContentView()
        .environment(BlendModel())
}
