import SwiftUI

struct SettingsView: View {
    @Environment(BlendModel.self) private var blendModel

    var body: some View {
        Form {
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
    SettingsView()
        .environment(BlendModel())
}
