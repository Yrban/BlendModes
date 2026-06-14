import SwiftUI

struct SettingsView: View {
    @Environment(BlendModel.self) private var blendModel

    var body: some View {
        @Bindable var model = blendModel

        Form {
            Section("Canvas Type") {
                Picker("Canvas", selection: $model.demoMode) {
                    ForEach(DemoMode.allCases, id: \.self) { m in
                        Label(m.rawValue, systemImage: m.systemImage).tag(m)
                    }
                }
                .pickerStyle(.segmented)
            }

            Section("Modes") {
                AdjustModeView()
            }

            Section("Colors") {
                ChooseColorsView()
            }

            Section("Legal") {
                NavigationLink("EULA") {
                    EULAView()
                }
                NavigationLink("Privacy Policy") {
                    PrivacyPolicyView()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environment(BlendModel())
    }
}
