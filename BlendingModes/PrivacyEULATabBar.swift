import SwiftUI

struct PrivacyEULATabBar: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            NavigationStack {
                EULAView()
            }
            .tabItem { Text("EULA") }
            .tag(0)

            NavigationStack {
                PrivacyPolicyView()
            }
            .tabItem { Text("Privacy Policy") }
            .tag(1)
        }
    }
}

#Preview {
    PrivacyEULATabBar()
}
