import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
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
            .navigationTitle("Settings")
    }
}
